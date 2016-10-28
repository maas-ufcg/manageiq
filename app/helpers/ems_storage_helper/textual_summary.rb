module EmsStorageHelper::TextualSummary
  include TextualMixins::TextualRefreshStatus
  #
  # Groups
  #

  def textual_group_properties
    %i(provider_region hostname ipaddress type port guid)
  end

  def textual_group_relationships
    %i(parent_ems_cloud cloud_volumes cloud_object_store_containers)
  end

  def textual_group_status
    textual_authentications(@ems.authentication_for_summary) + %i(refresh_status)
  end

  def textual_group_smart_management
    %i(zone tags)
  end

  def textual_group_topology
  end

  #
  # Items
  #
  def textual_provider_region
    return nil if @ems.provider_region.nil?
    {:label => _("Region"), :value => @ems.description}
  end

  def textual_hostname
    @ems.hostname
  end

  def textual_ipaddress
    return nil if @ems.ipaddress.blank?
    {:label => _("Discovered IP Address"), :value => @ems.ipaddress}
  end

  def textual_type
    @ems.emstype_description
  end

  def textual_port
    @ems.supports_port? ? {:label => _("API Port"), :value => @ems.port} : nil
  end

  def textual_guid
    {:label => _("Management Engine GUID"), :value => @ems.guid}
  end

  def textual_parent_ems_cloud
    label = ui_lookup(:model => "ManageIQ::Providers::CloudManager")
    textual_link(@record.try(:parent_manager), :label => _("Parent #{label}"))
  end

  def textual_zone
    {:label => _("Managed by Zone"), :image => "zone", :value => @ems.zone.try(:name)}
  end

  def textual_cloud_volumes
    @record.try(:cloud_volumes)
  end

  def textual_cloud_object_store_containers
    @record.try(:cloud_object_store_containers)
  end
end
