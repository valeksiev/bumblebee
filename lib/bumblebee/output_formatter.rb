module Bumblebee

  class OutputFormatter

    def output(data)
      raise 'Not implemented'
    end
  end
end

require 'bumblebee/output_formatter/console_output_formatter'
