class EmsSwiftController < ApplicationController
  include EmsCommon
  include Mixins::EmsCommonAngular
  include Mixins::GenericSessionMixin

  before_action :check_privileges
  before_action :get_session_data
  after_action :cleanup_action
  after_action :set_session_data

  def self.model
    ManageIQ::Providers::StorageManager::SwiftManager
  end

  def self.table_name
    @table_name ||= "ems_swift"
  end

  def ems_path(*args)
    path_hash = {:action => 'show', :id => args[0].id.to_s }
    path_hash.merge(args[1])
  end

  def new_ems_path
    {:action => 'new'}
  end

  def ems_swift_form_fields
    ems_form_fields
  end
end
