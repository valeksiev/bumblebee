module Bumblebee

  class Configuration

    @@configurations = {}

    def initialize(name, &block)
      @name = name
      @entities = {}
      instance_eval(&block)
    end

    def entity(name, &block)
      entity = EntityConfiguration.new(name)
      entity.instance_eval(&block)
      @entities[name.to_sym] = entity
    end

    def get_entity(name)
      raise EntityUnregisteredError.new("entity #{name.to_s} is not registered") unless @entities.has_key?(name)
      @entities[name.to_sym]
    end

    def get_key_for_entity(source_key)
      @entities.values.find { |entity| entity.get_source == source_key }.entity_name
    end

    class << self

      def configure(name, &block)
        @@configurations[name.to_sym] = self.new(name, &block)
      end

      def get(name)
        @@configurations[name.to_sym]
      end
    end
  end
end


require_relative '../../spec/fixtures/configuration.rb'
