module Bumblebee

  class Rule

    attr_accessor :key, :get_data_method

    def initialize(args)
      @property = args.shift
      config = args.shift
      config&.each { |name, value| instance_variable_set("@#{name}", value) }
      @key ||= @property
    end

    def run(data, extra_data_lambda = nil)
      raise 'Not implemented'
    end

    private

    def handle_compound(data)
      @compound_of.map { |field| data[field] }.join(@glued_with)
    end

    def is_compound?
      !@compound_of.nil?
    end
  end
end

require 'bumblebee/rule/field_rule'
require 'bumblebee/rule/relation_rule'
