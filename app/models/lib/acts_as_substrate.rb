# substrate can hold a bundle of properties [i.e. custom fields/properties]
module ActsAsSubstrate
  def self.included(base)
    base.extend(ActsAsSubstrate::ClassMethods)
  end

  def properties_hash
    unless @properties_hash_cache
      if self.class.enable_bundles
        if self.bundle
          @properties_hash_cache = self.bundle.properties.inject({}) {|acc, p| acc[p.id] = p; acc }
        else
          @properties_hash_cache = {}
        end
      else
        @properties_hash_cache = self.class.properties.inject({}) {|acc, p| acc[p.id] = p; acc }
      end
    end

    @properties_hash_cache
  end

  def values
    properties_hash.map do |pid, p|
      {
        id: pid,
        name: p.name,
        value_type: p.value_type,
        entity_type: p.entity_type,
        value: (property_values || {})[pid.to_s]
      }
    end
  end

  def property_values
    read_attribute(:property_values) || {}
  end

  def property_value(property_name)
    self.property_values[Property.where(name: property_name, entity_type: self.class.name).first.id.to_s] rescue nil
  end

  # { pid => value }
  def property_values=(vals)
    write_attribute(:property_values, property_values.merge(vals || {}))
  end

  # reset property values on bundle type change
  def reset_property_values
    write_attribute(:property_values, {})
  end

  module ClassMethods
    def properties
      Property.where(entity_type: self.name)
    end

    def bundles
      Bundle.where(entity_type: self.name)
    end
  end

  module Base
    def acts_as_substrate(options = {})
      self.class_attribute :enable_bundles
      if options[:bundles]
        self.enable_bundles = true

        belongs_to :bundle
        # reset property values on bundle type change
        before_update :reset_property_values, :if => :bundle_id_changed?
      else
        self.enable_bundles = false
      end

      self.send(:include, ActsAsSubstrate)
    end
  end
end
