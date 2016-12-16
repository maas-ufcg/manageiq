module Api
  class PhysicalServersController < BaseController
    include Subcollections::Firmwares
  
    def show
      if params[:c_id]
        physical_server = PhysicalServer.find(params[:c_id])
        response_payload = physical_server.as_json
        firmwares = physical_server.firmwares.map(&:as_json)
        response_payload["firmwares"] = firmwares
        response_payload["host_id"] = case physical_server.host
                                      when nil then nil
                                      else physical_server.host.id
                                      end

        render json: response_payload
      else
        super
      end
    end
  end
end
