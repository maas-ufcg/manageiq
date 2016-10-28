class MiddlewareDeploymentController < ApplicationController
  include EmsCommon
  include MiddlewareCommonMixin

  before_action :check_privileges
  before_action :get_session_data
  after_action :cleanup_action
  after_action :set_session_data

  OPERATIONS = {
    :middleware_deployment_restart  => {:op   => :restart_middleware_deployment,
                                        :hawk => N_('Not restarting deployment'),
                                        :msg  => N_('Restart initiated for selected deployment(s)')
    },
    :middleware_deployment_disable  => {:op   => :disable_middleware_deployment,
                                        :hawk => N_('Not disabling deployment'),
                                        :msg  => N_('Disable initiated for selected deployment(s)')
    },
    :middleware_deployment_enable   => {:op   => :enable_middleware_deployment,
                                        :hawk => N_('Not enabling deployment'),
                                        :msg  => N_('Enable initiated for selected deployment(s)')
    },
    :middleware_deployment_undeploy => {:op   => :undeploy_middleware_deployment,
                                        :hawk => N_('Not undeploying deployment'),
                                        :msg  => N_('Undeployment initiated for selected deployment(s)')
    }
  }.freeze

  def button
    selected_operation = params[:pressed].to_sym
    if OPERATIONS.key?(selected_operation)
      selected_archives = identify_selected_entities
      run_operation(OPERATIONS.fetch(selected_operation), selected_archives)
      javascript_flash
    else
      super
    end
  end

  def trigger_mw_operation(operation, mw_deployment, _params = nil)
    mw_manager = mw_deployment.ext_management_system
    op = mw_manager.public_method operation
    op.call(mw_deployment.ems_ref, mw_deployment.name)
  end
end
