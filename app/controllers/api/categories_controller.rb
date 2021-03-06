module Api
  class CategoriesController < BaseController
    include Subcollections::Tags

    def show
      request_additional_attributes
      super
    end

    def edit_resource(type, id, data = {})
      raise BaseController::Forbidden if Category.find(id).read_only?
      request_additional_attributes
      super
    end

    def delete_resource(type, id, data = {})
      raise BaseController::Forbidden if Category.find(id).read_only?
      super
    end

    private

    def request_additional_attributes
      @additional_attributes = %w(name)
    end
  end
end
