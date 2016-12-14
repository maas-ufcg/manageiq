class PhysicalServer < ApplicationRecord
  include NewWithTypeStiMixin


  acts_as_miq_taggable

  belongs_to :ext_management_system, :foreign_key => :ems_id, :class_name => "ManageIQ::Providers::PhysicalInfraManager"
  has_many :firmwares, :foreign_key => "ph_server_uuid", :primary_key => "uuid"

  def name_with_details
    details % {
      :name => name,
    }
  end
end
