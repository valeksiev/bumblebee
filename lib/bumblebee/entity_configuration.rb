module Bumblebee

  class EntityConfiguration

    attr_accessor :source, :entity_name

    def initialize(entity_name)
      @entity_name = @source = entity_name
      @rules = []
    end

    def source(source_name)
      @source = source_name
    end

    def get_source
      @source
    end

    def method_missing(meth, *args, &block)
      begin
        rule_class_name = "Bumblebee::#{meth.to_s.capitalize}Rule"
        rule_class = Object.const_get(rule_class_name)
      rescue NameError => e
        raise Bumblebee::UndefinedRule.new("Rule '#{meth}' is not defined. Expected class '#{rule_class_name}'.")
      end
      @rules.push(rule_class.new(args))
    end

    def skip_unmaped_fields(value = true)
      @skip_unmatched_field = value
    end

    def run(data, extra_data_lambda)
      mapped = {}
      @rules.each do |rule|
        mapped.merge!(rule.run(data, extra_data_lambda))
      end
      if !@skip_unmatched_field
        mapped_keys = @rules.map(&:key)
        data.select { |key, value| mapped_keys.include?(key) }
      end
      mapped
    end
  end
end
