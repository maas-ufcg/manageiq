(function () {
  var element, timeline;

  function handlePopover(element) {
    var popover = '';
    if (element.hasOwnProperty("events")) {
      popover = 'Group of ' + element.events.length + ' events';
    } else {
      for (var i in element.details) {
        popover = popover + element.details[i];
      }
    }
    return popover;
  }

  function eventClick(el) {
    var table = '<table class="table table-striped table-bordered">';
    console.log(el);
    if (el.hasOwnProperty("events")) {
      table = table + '<thead>This is a group of ' + el.events.length + ' events starting on ' + el.date.toLocaleString() + '</thead><tbody>';
      table = table + '<tr><th>Date</th><th>Event</th></tr>'
      for (var i = 0; i < el.events.length; i++) {
        table = table + '<tr><td>' + el.events[i].date.toLocaleString() + ' </td> ';
        for (var j in el.events[i].details) {
          table = table + '<td> ' + el.events[i].details[j] + ' </td> ';
        }
        table = table + '</tr>'
      }
      table = table + '</tbody>';
    } else {
      table = table + 'Date: ' + el.date.toLocaleString() + '<br>';
      for (var i in el.details) {
        table = table + el.details[i] + '<br>';
      }
    }
    $('#chart_placeholder').append(table);
  }

  function createTooltip() {
    if (timeline && timeline.constructor && timeline.call && timeline.apply) {
      timeline(element);
    }
    $('[data-toggle="popover"]').popover({
      'container': '#tl_div',
      'placement': 'top',
      'html': true
    });
  }

  ManageIQ.Timeline = {
    load: function (json, start, end) {
      var data = [],
        one_hour = 60 * 60 * 1000,
        one_day = 24 * 60 * 60 * 1000,
        one_week = one_day * 7,
        one_month = one_day * 30,
        dataHasName = false;
      for (var x in json) {
        data[x] = {};
        if (json[x].name !== undefined && json[x].name !== '') {
          dataHasName = true;
          data[x].name = json[x].name;
        }
        data[x].data = [];
        if (json[x].data.length > 0) {
          var timelinedata = json[x].data[0];
          for (var y in timelinedata) {
            data[x].data.push({});
            data[x].data[y].date = new Date(timelinedata[y].start);
            data[x].data[y].details = {};
            data[x].data[y].details.event = timelinedata[y].description;
          }
          data[x].display = true;
        }
      }
      timeline = d3.chart.timeline().end(end).start(start)
        .minScale(one_week / one_month)
        .maxScale(one_week / one_hour)
        .eventGrouping(360000).labelWidth(170)
        .eventPopover(handlePopover).eventClick(eventClick);

      if(!dataHasName) {
        timeline.labelWidth(60);
      }

      element = d3.select(chart_placeholder).append('div').datum(data);
      if (timeline && timeline.constructor && timeline.call && timeline.apply) {
        timeline(element);
      }

      $('[data-toggle="popover"]').popover({
        'container': '#tl_div',
        'placement': 'top',
        'html': true
      });

      $(window).on('resize', createTooltip);
    }
  };
})(ManageIQ);