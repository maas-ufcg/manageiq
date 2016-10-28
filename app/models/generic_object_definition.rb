class GenericObjectDefinition < ApplicationRecord
  TYPE_MAP = {
    :boolean  => ActiveModel::Type::Boolean.new,
    :datetime => ActiveModel::Type::DateTime.new,
    :float    => ActiveModel::Type::Float.new,
    :integer  => ActiveModel::Type::Integer.new,
    :string   => ActiveModel::Type::String.new,
    :time     => ActiveModel::Type::Time.new
  }.freeze

  FEATURES = %w(attribute association method).freeze

  serialize :properties, Hash

  has_one   :picture, :dependent => :destroy, :as => :resource
  has_many  :generic_objects

  validates :name, :presence => true, :uniqueness => true
  validate  :validate_property_attributes,
            :validate_property_associations,
            :validate_property_name_unique,
            :validate_supported_property_features

  before_validation :set_default_properties
  before_validation :normalize_property_attributes,
                    :normalize_property_associations,
                    :normalize_property_methods

  before_destroy    :check_not_in_use

  def create_object(options)
    GenericObject.create!({:generic_object_definition => self}.merge(options))
  end

  FEATURES.each do |feature|
    define_method("property_#{feature}s") do
      return errors[:properties] if properties_changed? && !valid?
      properties["#{feature}s".to_sym]
    end

    define_method("property_#{feature}_defined?") do |attr|
      attr = attr.to_s
      return property_methods.include?(attr) if feature == 'method'
      send("property_#{feature}s").key?(attr)
    end
  end

  def property_defined?(attr)
    property_attribute_defined?(attr) || property_association_defined?(attr) || property_method_defined?(attr)
  end

  def property_getter(attr, val)
    return type_cast(attr, val) if property_attribute_defined?(attr)
    return get_objects_of_association(attr, val) if property_association_defined?(attr)
  end

  def type_cast(attr, value)
    TYPE_MAP.fetch(property_attributes[attr]).cast(value)
  end

  def properties=(props)
    props.reverse_merge!(:attributes => {}, :associations => {}, :methods => [])
    super
  end

  def add_property_attribute(name, type)
    properties[:attributes][name.to_s] = type.to_sym
    save
  end

  def delete_property_attribute(name)
    transaction do
      properties[:attributes].delete(name.to_s)
      save!

      generic_objects.find_each { |o| o.delete_property(name) }
    end
  end

  def add_property_association(name, type)
    properties[:associations][name.to_s] = type.to_s.classify
    save
  end

  def delete_property_association(name)
    transaction do
      properties[:associations].delete(name.to_s)
      save!

      generic_objects.find_each { |o| o.delete_property(name) }
    end
  end

  def add_property_method(name)
    properties[:methods] << name.to_s unless properties[:methods].include?(name.to_s)
    save
  end

  def delete_property_method(name)
    properties[:methods].delete(name.to_s)
    save
  end

  private

  def get_objects_of_association(attr, values)
    property_associations[attr].constantize.where(:id => values).to_a
  end

  def normalize_property_attributes
    props = properties.symbolize_keys

    properties[:attributes] = props[:attributes].each_with_object({}) do |(name, type), hash|
      hash[name.to_s] = type.to_sym
    end
  end

  def normalize_property_associations
    props = properties.symbolize_keys

    properties[:associations] = props[:associations].each_with_object({}) do |(name, type), hash|
      hash[name.to_s] = type.to_s.classify
    end
  end

  def normalize_property_methods
    props = properties.symbolize_keys
    properties[:methods] = props[:methods].collect(&:to_s)
  end

  def validate_property_attributes
    properties[:attributes].each do |name, type|
      errors[:properties] << "attribute [#{name}] is not of a recognized type: [#{type}]" unless TYPE_MAP.key?(type.to_sym)
    end
  end

  def validate_property_associations
    properties[:associations].each do |name, klass|
      begin
        klass.constantize
      rescue NameError
        errors[:properties] << "association [#{name}] is not of a valid model: [#{klass}]"
      end
    end
  end

  def validate_property_name_unique
    all = properties[:attributes].keys + properties[:associations].keys + properties[:methods]
    common = all.group_by(&:to_s).select { |_k, v| v.size > 1 }.collect(&:first)
    errors[:properties] << "property name has to be unique: [#{common.join(",")}]" unless common.blank?
  end

  def validate_supported_property_features
    if properties.keys.any? { |f| !f.to_s.singularize.in?(FEATURES) }
      errors[:properties] << "only these features are supported: [#{FEATURES.join(", ")}]"
    end
  end

  def check_not_in_use
    return true if generic_objects.empty?
    errors[:base] << "Cannot delete the definition while it is referenced by some generic objects"
    throw :abort
  end

  def set_default_properties
    self.properties = {:attributes => {}, :associations => {}, :methods => []} unless properties.present?
  end
end
