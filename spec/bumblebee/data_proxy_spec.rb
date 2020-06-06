require 'spec_helper'

module Bumblebee

  describe 'DataProxy' do
    let(:config) {
      config = double('config').as_null_object
      config
    }

    let(:extra_data_lambda) {
      extra_data_lambda = double('extra_data_lambda').as_null_object
      extra_data_lambda
    }

    before :each do
      stub_config
    end

    let(:data_proxy) { DataProxy.new(:user, {}, config, extra_data_lambda) }

    context('#initialize') do
      it 'expects entity_name and hash as data' do
        expect{ DataProxy.new }.to raise_error ArgumentError
        expect{ DataProxy.new(:user, {}, config, extra_data_lambda) }.not_to raise_error
      end

      it 'initializes instance variables' do
        data_proxy = DataProxy.new(:user, {'key' => 'val'}, config, extra_data_lambda)
        expect(data_proxy.instance_variable_get(:@mapped)).to eq nil
        expect(data_proxy.instance_variable_get(:@data)).to eq({'key' => 'val'})
        expect(data_proxy.instance_variable_get(:@entity_name)).to eq :user
      end

      it 'gets entity configuration on initialization' do
        expect(config).to receive(:get_entity).with(:user)
        proxy = DataProxy.new(:user, {}, config, extra_data_lambda)
      end
    end

    context '#run!' do

      it 'has run method' do
        proxy = DataProxy.new(:user, {'key' => 'val'}, config, extra_data_lambda)
        expect { proxy.run! }.not_to raise_error
      end

      it 'reads entity config and executes it' do
        configuration = double('configuration')
        expect(config).to receive(:get_entity).with(:user).and_return(configuration)
        expect(configuration).to receive(:run).with({'key' => 'val'}, extra_data_lambda)
        proxy = DataProxy.new(:user, {'key' => 'val'}, config, extra_data_lambda)
        proxy.run!
      end

      it 'executes EntityConfiguration#run only once if called multiple times' do
        configuration = double('configuration')
        expect(config).to receive(:get_entity).with(:user).and_return(configuration)
        expect(configuration).to receive(:run).with({'key' => 'val'}, extra_data_lambda).and_return({ data: 1 })
        proxy = DataProxy.new(:user, {'key' => 'val'}, config, extra_data_lambda)
        proxy.run!
        proxy.run!
      end
    end

    context '#to_json' do

      it 'has to_json that returns mapped.to_json' do
        mapped = { 'mapped' => 'true' }
        data_proxy.instance_variable_set(:@mapped, mapped)
        expect(data_proxy.to_json).to eq mapped.to_json
      end

      it 'forwards the options to mapped#to_json' do
        mapped = double('mapped')
        expect(mapped).to receive(:to_json).with({option: :value})
        data_proxy.instance_variable_set(:@mapped, mapped)
        data_proxy.to_json({option: :value})
      end
    end

    context '#field_matches?' do

      it 'has field_matches? method' do
        expect { data_proxy.field_matches?(:field, :value) }.not_to raise_error
      end

      it 'return true if the value is present in the data with the corresponding key' do
        data_proxy.instance_variable_set(:@data, { field: :value })
        expect(data_proxy.field_matches?(:field, :value)).to be true
      end

      it 'return false if the value is not present in the data with the corresponding key' do
        data_proxy.instance_variable_set(:@data, { field: :value })
        expect(data_proxy.field_matches?(:field, :diff_value)).to be false
      end

    end

    def stub_config
      entities = double('entities').as_null_object
      allow(entities).to receive(:has_key?).and_return(true)
      Configuration.class_variable_set(:@@entities, entities)
    end
  end
end
