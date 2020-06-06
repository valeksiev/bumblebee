require 'csv'

module Bumblebee

  class CsvDataSourceAdapter < DataSourceAdapter

    private

    def prepare_data
      @connector.data.each do |key, data|
        key = @configuration.get_key_for_entity(key)
        @data[key] = []
        CSV.parse(data, {:headers => true, :header_converters => :symbol}) do |row|
          @data[key].push(DataProxy.new(key, row, @configuration, get_extra_data))
        end
      end
    end
  end
end
