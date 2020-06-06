module Bumblebee

  class DataProxy

    def initialize(entity_name, data, configuration, get_extra_data)
      @mapped = nil
      @data = data
      @entity_name = entity_name.to_sym
      @entity_configuration = configuration.get_entity(@entity_name)
      @get_extra_data = get_extra_data
    end

    def run!
     @mapped ||= @entity_configuration.run(@data, @get_extra_data)
    end

    def to_json(options = {})
      @mapped.to_json(options)
    end

    def field_matches?(field, value)
      @data[field] == value
    end
  end
end
