require 'spec_helper'

module Bumblebee

  describe 'Runner' do

    skip 'cam be initialized' do
      expect{ valid_bumblebee }.not_to raise_error
    end

    it 'expects DataSourceAdapter on initialization' do
      expect { Bumblebee::Runner.new 'slon', 'mlon' }.to raise_error Bumblebee::InvalidDataSourceError
    end

    skip 'expects OutputFormatter on initialization' do
      expect { Bumblebee::Runner.new Bumblebee::DataSourceAdapter.new, 'mlon' }.to raise_error Bumblebee::InvalidOutputFormatter
    end

    skip 'has run method' do
      bumblebee = valid_bumblebee
      expect(bumblebee).to respond_to(:run)
    end

    context '#run' do

      it 'loops the data from adapter and invokes #run! on it' do
        op_formatter = double('opr-formatter').as_null_object
        expect(op_formatter).to receive(:is_a?).and_return(true)

        proxy = double('dataproxy')
        expect(proxy).to receive(:each)

        data = double('data')
        expect(data).to receive(:each).and_yield('key', proxy)

        adapter = double('adapter')
        expect(adapter).to receive(:is_a?).and_return(true)
        expect(adapter).to receive(:data).and_return(data)

        runner = valid_bumblebee adapter, op_formatter
        runner.run(:school)
      end

      it 'invokes output on the OPFormatter with the data' do
        proxy = double('dataproxy')
        expect(proxy).to receive(:each)

        data = double('data')
        expect(data).to receive(:each).and_yield('key', proxy)

        adapter = double('adapter')
        expect(adapter).to receive(:is_a?).and_return(true)
        expect(adapter).to receive(:data).and_return(data)

        op_formatter = double('opr-formatter')
        expect(op_formatter).to receive(:is_a?).and_return(true)
        expect(op_formatter).to receive(:output).with(data)


        runner = valid_bumblebee adapter, op_formatter
        runner.run(:school)
      end

    end

    def valid_bumblebee(bumblebee = Bumblebee::DataSourceAdapter.new(double(:connector).as_null_object, double(:config).as_null_object), op_formatter = Bumblebee::OutputFormatter.new)
      Bumblebee::Runner.new(bumblebee, op_formatter)
    end
  end

end
