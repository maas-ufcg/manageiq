class ContainerNodeController < ApplicationController
  include ContainersCommonMixin

  before_action :check_privileges
  before_action :get_session_data
  after_action :cleanup_action
  after_action :set_session_data

  def launch_cockpit
    node = identify_record(params[:id], ContainerNode)

    if node.ipaddress
      javascript_open_window(node.cockpit_url)
    else
      render_flash_and_stop_sparkle(node.unsupported_reason(:launch_cockpit), :error)
    end
  end
end
