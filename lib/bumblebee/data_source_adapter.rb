module Bumblebee

  class DataSourceAdapter

    attr_accessor :data

    def initialize(connector, configuration)
      @connector = connector
      @configuration = configuration
      @data = {}
      prepare_data
    end

    def get_extra_data
      -> (key) {
        @data[key]
      }
    end

    private

    def prepare_data
      raise 'Not Implmeneted'
    end
  end
end

require 'bumblebee/adapter/csv_data_source_adapter'
