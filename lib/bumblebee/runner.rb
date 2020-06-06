module Bumblebee

  class Runner

    def initialize(ds_adapter, op_formatter, configuration = nil)
      raise Bumblebee::InvalidDataSourceError unless ds_adapter.is_a?(Bumblebee::DataSourceAdapter)
      raise Bumblebee::InvalidOutputFormatter unless op_formatter.is_a?(Bumblebee::OutputFormatter)
      @ds_adapter = ds_adapter
      @op_formatter = op_formatter
    end

    def run(configuration_name)
      data = @ds_adapter.data
      data.each do |key, d|
        d.each do |data_proxy|
          data_proxy.run!
        end
      end
      @op_formatter.output(data)
    end
  end
end
