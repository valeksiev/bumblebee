require 'spec_helper'

module Bumblebee

  describe 'CsvDataSourceAdapter' do

    include FixturesHelper

    let(:connector) {
      connector = double('connector').as_null_object
      allow(connector).to receive(:data).and_return({ 'student' => File.open(fixture_path('student.csv')).read })
      connector
    }

    let(:config) {
      config = double('connector').as_null_object
      allow(connector).to receive(:data).and_return({ 'student' => File.open(fixture_path('student.csv')).read })
      connector
    }

    let(:adapter) { CsvDataSourceAdapter.new(connector, config) }

    it 'expects connector on initialization' do
      expect{ CsvDataSourceAdapter.new }.to raise_error ArgumentError
      expect{ adapter }.not_to raise_error
    end

    it 'assigns connector as instance varibale' do
      expect(adapter.instance_variable_get(:@connector)).to eq connector
    end

    context '#prepare_data' do

      it 'gets data from connector' do
        expect(connector).to receive(:data)
        adapter
      end

      it 'parses data as CSV' do
        expect(CSV).to receive(:parse).with(File.open(fixture_path('student.csv')).read, {:headers => true, :header_converters => :symbol})
        adapter
      end

      it 'parses data from connector as DataProxy' do
        # two rows in the fixture
        expect(DataProxy).to receive(:new).twice.and_return(double('data-proxy'))
        adapter
      end
    end
  end
end
