class PhysicalServer < ApplicationRecord
  include NewWithTypeStiMixin

  acts_as_miq_taggable

  belongs_to :ext_management_system, :foreign_key => :ems_id, :class_name => "ManageIQ::Providers::PhysicalInfraManager"

  def firmwares
    Firmware.where("ph_server_uuid = ?",  uuid)

  end


  def name_with_details
    details % {
      :name => name,
    }
  end
end
