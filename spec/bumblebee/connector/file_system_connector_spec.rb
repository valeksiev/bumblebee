require 'spec_helper'
module Bumblebee
  describe 'FileSystemConnector' do

    include FixturesHelper

    subject(:connector) { Bumblebee::FileSystemConnector.new(valid_path) }
    subject(:multi_connector) { Bumblebee::FileSystemConnector.new(valid_paths) }

    it 'can be initialized with multiple files' do
      expect(multi_connector).to be_instance_of Bumblebee::FileSystemConnector
    end

    it 'can be initialized' do
      expect(connector).to be_instance_of Bumblebee::FileSystemConnector
    end

    it 'raises if file does not exists' do
      expect{ Bumblebee::FileSystemConnector.new 'slon' }.to raise_error FileSystemConnectorFileNotExists
    end

    it 'has data method' do
      expect(connector).to respond_to :data
    end

    it 'returns file content as string if called with argument' do
      expect(connector.data(:student)).to be_a(String)
    end

    it 'returns file content as hash if called without argument' do
      expect(multi_connector.data()).to be_a(Hash)
    end

    it 'returns file contents for specific file' do
      expect(multi_connector.data(:student)).to eq File.open(valid_path).read
    end

    it 'does not mix when used with multiple files' do
      expect(multi_connector.data(:student)).not_to eq File.open(valid_paths.last).read
    end

    it 'does not raise if data is called without params' do
      expect { multi_connector.data() }.not_to raise_error
    end

    it 'returns the all files when no param is provided' do
      expect(multi_connector.data()).to eq({ student: File.open(valid_paths.first).read, class: File.open(valid_paths.last).read })
    end

    def valid_path
      fixture_path('student.csv')
    end

    def valid_paths
      [fixture_path('student.csv'), fixture_path('class.csv')]
    end

  end
end
