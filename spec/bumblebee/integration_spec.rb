require 'spec_helper'

describe 'ETL' do

  include FixturesHelper

  it 'does magic' do
    sources = [fixture_path('student.csv'), fixture_path('class.csv')]
    connector = Bumblebee::FileSystemConnector.new(sources)
    adapter = Bumblebee::CsvDataSourceAdapter.new(connector, Bumblebee::Configuration.get(:school))
    op_formatter = Bumblebee::ConsoleOutputFormatter.new
    runner = Bumblebee::Runner.new(adapter, op_formatter)
    #result = JSON.parse(runner.run(:school))
    #ap result
    #JSON.parse(capture_stdout { runner.run }).map { |e| JSON.parse(e) }
  end

end
