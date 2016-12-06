module MiqServer::WorkerManagement::Monitor::ClassNames
  extend ActiveSupport::Concern

  MONITOR_CLASS_NAMES = %w(
    ManageIQ::Providers::Azure::CloudManager::MetricsCollectorWorker
    ManageIQ::Providers::Amazon::CloudManager::MetricsCollectorWorker
    ManageIQ::Providers::Redhat::InfraManager::MetricsCollectorWorker
    ManageIQ::Providers::Kubernetes::ContainerManager::MetricsCollectorWorker
    ManageIQ::Providers::Openshift::ContainerManager::MetricsCollectorWorker
    ManageIQ::Providers::Google::CloudManager::MetricsCollectorWorker
    ManageIQ::Providers::OpenshiftEnterprise::ContainerManager::MetricsCollectorWorker
    ManageIQ::Providers::Vmware::InfraManager::MetricsCollectorWorker
    ManageIQ::Providers::Openstack::CloudManager::MetricsCollectorWorker
    ManageIQ::Providers::Openstack::NetworkManager::MetricsCollectorWorker
    ManageIQ::Providers::Openstack::InfraManager::MetricsCollectorWorker
    MiqEmsMetricsProcessorWorker
    MiqEmsRefreshCoreWorker
    ManageIQ::Providers::Azure::CloudManager::RefreshWorker
    ManageIQ::Providers::Azure::NetworkManager::RefreshWorker
    ManageIQ::Providers::Amazon::CloudManager::RefreshWorker
    ManageIQ::Providers::Amazon::NetworkManager::RefreshWorker
    ManageIQ::Providers::Google::CloudManager::RefreshWorker
    ManageIQ::Providers::Google::NetworkManager::RefreshWorker
    ManageIQ::Providers::AnsibleTower::ConfigurationManager::RefreshWorker
    ManageIQ::Providers::Foreman::ConfigurationManager::RefreshWorker
    ManageIQ::Providers::Foreman::ProvisioningManager::RefreshWorker
    ManageIQ::Providers::Hawkular::MiddlewareManager::RefreshWorker
    ManageIQ::Providers::Hawkular::DatawarehouseManager::RefreshWorker
    ManageIQ::Providers::Kubernetes::ContainerManager::RefreshWorker
    ManageIQ::Providers::Openshift::ContainerManager::RefreshWorker
    ManageIQ::Providers::OpenshiftEnterprise::ContainerManager::RefreshWorker
    ManageIQ::Providers::Microsoft::InfraManager::RefreshWorker
    ManageIQ::Providers::Redhat::InfraManager::RefreshWorker
    ManageIQ::Providers::Openstack::CloudManager::RefreshWorker
    ManageIQ::Providers::Openstack::NetworkManager::RefreshWorker
    ManageIQ::Providers::Openstack::InfraManager::RefreshWorker
    ManageIQ::Providers::StorageManager::CinderManager::RefreshWorker
    ManageIQ::Providers::StorageManager::SwiftManager::RefreshWorker
    ManageIQ::Providers::Lenovo::PhysicalInfraManager::RefreshWorker
    ManageIQ::Providers::Vmware::CloudManager::RefreshWorker
    ManageIQ::Providers::Vmware::NetworkManager::RefreshWorker
    ManageIQ::Providers::Vmware::InfraManager::RefreshWorker
    ManageIQ::Providers::Nuage::NetworkManager::RefreshWorker
    ManageIQ::Providers::Amazon::CloudManager::EventCatcher
    ManageIQ::Providers::Azure::CloudManager::EventCatcher
    ManageIQ::Providers::Hawkular::MiddlewareManager::EventCatcher
    ManageIQ::Providers::Google::CloudManager::EventCatcher
    ManageIQ::Providers::Kubernetes::ContainerManager::EventCatcher
    ManageIQ::Providers::Openshift::ContainerManager::EventCatcher
    ManageIQ::Providers::OpenshiftEnterprise::ContainerManager::EventCatcher
    ManageIQ::Providers::Redhat::InfraManager::EventCatcher
    ManageIQ::Providers::Openstack::CloudManager::EventCatcher
    ManageIQ::Providers::Openstack::NetworkManager::EventCatcher
    ManageIQ::Providers::Openstack::InfraManager::EventCatcher
    ManageIQ::Providers::StorageManager::CinderManager::EventCatcher
    ManageIQ::Providers::Vmware::InfraManager::EventCatcher
    ManageIQ::Providers::Vmware::CloudManager::EventCatcher
    ManageIQ::Providers::Lenovo::PhysicalInfraManager::EventCatcher
    MiqEventHandler
    MiqGenericWorker
    MiqNetappRefreshWorker
    MiqPriorityWorker
    MiqReportingWorker
    MiqScheduleWorker
    MiqSmartProxyWorker
    MiqSmisRefreshWorker
    MiqStorageMetricsCollectorWorker
    MiqWebsocketWorker
    MiqUiWorker
    MiqVimBrokerWorker
    MiqVmdbStorageBridgeWorker
    MiqWebServiceWorker
  ).freeze

  MONITOR_CLASS_NAMES_IN_KILL_ORDER = %w(
    MiqEmsMetricsProcessorWorker
    ManageIQ::Providers::Azure::CloudManager::MetricsCollectorWorker
    ManageIQ::Providers::Amazon::CloudManager::MetricsCollectorWorker
    ManageIQ::Providers::Redhat::InfraManager::MetricsCollectorWorker
    ManageIQ::Providers::Kubernetes::ContainerManager::MetricsCollectorWorker
    ManageIQ::Providers::Openshift::ContainerManager::MetricsCollectorWorker
    ManageIQ::Providers::Google::CloudManager::MetricsCollectorWorker
    ManageIQ::Providers::OpenshiftEnterprise::ContainerManager::MetricsCollectorWorker
    ManageIQ::Providers::Vmware::InfraManager::MetricsCollectorWorker
    ManageIQ::Providers::Openstack::CloudManager::MetricsCollectorWorker
    ManageIQ::Providers::Openstack::NetworkManager::MetricsCollectorWorker
    ManageIQ::Providers::Openstack::InfraManager::MetricsCollectorWorker
    MiqReportingWorker
    MiqSmartProxyWorker
    MiqGenericWorker
    MiqEventHandler
    MiqSmisRefreshWorker
    MiqNetappRefreshWorker
    MiqVmdbStorageBridgeWorker
    MiqStorageMetricsCollectorWorker
    ManageIQ::Providers::Azure::CloudManager::RefreshWorker
    ManageIQ::Providers::Azure::NetworkManager::RefreshWorker
    ManageIQ::Providers::Amazon::CloudManager::RefreshWorker
    ManageIQ::Providers::Amazon::NetworkManager::RefreshWorker
    ManageIQ::Providers::Google::CloudManager::RefreshWorker
    ManageIQ::Providers::Google::NetworkManager::RefreshWorker
    ManageIQ::Providers::AnsibleTower::ConfigurationManager::RefreshWorker
    ManageIQ::Providers::Foreman::ConfigurationManager::RefreshWorker
    ManageIQ::Providers::Foreman::ProvisioningManager::RefreshWorker
    ManageIQ::Providers::Hawkular::MiddlewareManager::RefreshWorker
    ManageIQ::Providers::Hawkular::DatawarehouseManager::RefreshWorker
    ManageIQ::Providers::Kubernetes::ContainerManager::RefreshWorker
    ManageIQ::Providers::Openshift::ContainerManager::RefreshWorker
    ManageIQ::Providers::OpenshiftEnterprise::ContainerManager::RefreshWorker
    ManageIQ::Providers::Microsoft::InfraManager::RefreshWorker
    ManageIQ::Providers::Redhat::InfraManager::RefreshWorker
    ManageIQ::Providers::Openstack::CloudManager::RefreshWorker
    ManageIQ::Providers::Openstack::NetworkManager::RefreshWorker
    ManageIQ::Providers::Openstack::InfraManager::RefreshWorker
    ManageIQ::Providers::StorageManager::CinderManager::RefreshWorker
    ManageIQ::Providers::StorageManager::SwiftManager::RefreshWorker
    ManageIQ::Providers::Lenovo::PhysicalInfraManager::RefreshWorker
    ManageIQ::Providers::Vmware::CloudManager::RefreshWorker
    ManageIQ::Providers::Vmware::NetworkManager::RefreshWorker
    ManageIQ::Providers::Vmware::InfraManager::RefreshWorker
    ManageIQ::Providers::Nuage::NetworkManager::RefreshWorker
    MiqScheduleWorker
    MiqPriorityWorker
    MiqWebServiceWorker
    MiqEmsRefreshCoreWorker
    MiqVimBrokerWorker
    ManageIQ::Providers::Vmware::CloudManager::EventCatcher
    ManageIQ::Providers::Vmware::InfraManager::EventCatcher
    ManageIQ::Providers::Redhat::InfraManager::EventCatcher
    ManageIQ::Providers::Openstack::CloudManager::EventCatcher
    ManageIQ::Providers::Openstack::NetworkManager::EventCatcher
    ManageIQ::Providers::Openstack::InfraManager::EventCatcher
    ManageIQ::Providers::StorageManager::CinderManager::EventCatcher
    ManageIQ::Providers::Amazon::CloudManager::EventCatcher
    ManageIQ::Providers::Azure::CloudManager::EventCatcher
    ManageIQ::Providers::Hawkular::MiddlewareManager::EventCatcher
    ManageIQ::Providers::Google::CloudManager::EventCatcher
    ManageIQ::Providers::Kubernetes::ContainerManager::EventCatcher
    ManageIQ::Providers::Openshift::ContainerManager::EventCatcher
    ManageIQ::Providers::OpenshiftEnterprise::ContainerManager::EventCatcher
    MiqUiWorker
    MiqWebsocketWorker
  ).freeze

  module ClassMethods
    def monitor_class_names
      MONITOR_CLASS_NAMES
    end

    def monitor_class_names_in_kill_order
      MONITOR_CLASS_NAMES_IN_KILL_ORDER
    end
  end
end
