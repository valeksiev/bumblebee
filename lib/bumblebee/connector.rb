module Bumblebee

  class Connector

    def data(source = '')
      raise 'Not implemented'
    end
  end
end

require 'bumblebee/connector/file_system_connector'
