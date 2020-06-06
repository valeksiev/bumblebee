module Bumblebee

  class RelationRule < Rule

    def run(data, extra_data_lambda)
      extra_data = extra_data_lambda.call(@entity_name)
      raise EntityUnregisteredError.new("Couldn't find entity with name '#{@entity_name}'.") if extra_data.nil?
      relation = extra_data.find do |data_proxy|
        data_proxy.field_matches?(@id_field, data[@id_value])
      end
      { @key => relation.run! }
    end
  end
end
