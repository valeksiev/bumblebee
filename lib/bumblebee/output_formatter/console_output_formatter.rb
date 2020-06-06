require 'json'

module Bumblebee

  class ConsoleOutputFormatter < OutputFormatter

    def output(data)
      JSON.generate(data)
    end
  end
end
