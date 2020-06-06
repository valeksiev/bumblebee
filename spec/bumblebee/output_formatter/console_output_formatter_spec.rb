require 'spec_helper'

module Bumblebee

  describe 'ConsoleOutputFormatter' do

    subject(:op_formatter){ Bumblebee::ConsoleOutputFormatter.new }

    context '#output' do

      it 'has output method with one param' do
        expect{ op_formatter.output }.to raise_error ArgumentError
        expect{ capture_stdout{ op_formatter.output({}) }  }.not_to raise_error
      end

      it 'invokes to_json on the data and prints it' do
        data = double('data')
        expect(JSON).to receive(:generate).with(data).and_return('{ "s" : "b" }')
        op_formatter.output(data)
      end
    end
  end
end
