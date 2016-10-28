module Api
  class ServiceRequestsController < BaseController
    include Subcollections::RequestTasks
    include Subcollections::Tasks

    def approve_resource(type, id, data)
      raise "Must specify a reason for approving a service request" unless data["reason"].present?
      api_action(type, id) do |klass|
        provreq = resource_search(id, type, klass)
        provreq.approve(@auth_user, data['reason'])
        action_result(true, "Service request #{id} approved")
      end
    rescue => err
      action_result(false, err.to_s)
    end

    def deny_resource(type, id, data)
      raise "Must specify a reason for denying a service request" unless data["reason"].present?
      api_action(type, id) do |klass|
        provreq = resource_search(id, type, klass)
        provreq.deny(@auth_user, data['reason'])
        action_result(true, "Service request #{id} denied")
      end
    rescue => err
      action_result(false, err.to_s)
    end

    def find_service_requests(id)
      klass = collection_class(:service_requests)
      return klass.find(id) if @auth_user_obj.admin?
      klass.find_by!(:requester => @auth_user_obj, :id => id)
    end

    def service_requests_search_conditions
      return {} if @auth_user_obj.admin?
      {:requester => @auth_user_obj}
    end
  end
end
