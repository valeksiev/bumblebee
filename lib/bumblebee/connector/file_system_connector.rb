module Bumblebee

  class FileSystemConnector < Connector

    def initialize(paths)
      paths = Array(paths)
      @files = {}
      paths.each do |path|
        raise FileSystemConnectorFileNotExists.new "path '#{path}' does not exists" unless File.exist?(path) and File.file?(path)
        file_name = File.basename(path).split('.').first.to_sym
        @files[file_name] = path
      end
      @files
    end

    def data(source = '')
      return File.open(@files[source.to_sym], 'rb').read unless source.empty?
      @files.map { |source, file_name| [source, File.open(file_name).read] }.to_h
    end
  end
end
