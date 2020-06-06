require 'spec_helper'

module Bumblebee

  describe 'EntityConfiguration' do

    let(:entity_config){ entity_config = EntityConfiguration.new('user') }

    context '#initialize' do

      it 'expects entity name on initialization' do
        expect{ EntityConfiguration.new }.to raise_error ArgumentError
        expect{ EntityConfiguration.new 'user' }.not_to raise_error
      end

      it 'initilizes instance variables' do
        expect(entity_config.instance_variable_get(:@entity_name)).to eq 'user'
        expect(entity_config.instance_variable_get(:@rules)).to eq([])
      end
    end

    context '#method_missing' do
      it 'defines method_missing' do
        expect(entity_config).to respond_to(:method_missing)
      end

      it 'instantiates Rule objec from the name of the missing method' do
        rule = double('rule')
        expect(Object).to receive(:const_get).with('Bumblebee::NameRule').and_return(rule)
        expect(rule).to receive(:new).with([:field_name, :key => 'key'])
        entity_config.name(:field_name, :key => 'key')
      end

      it 'validates Rule class name' do
        expect{ entity_config.name(:field_name, :key => 'key') }.to raise_error(UndefinedRule, "Rule 'name' is not defined. Expected class 'Bumblebee::NameRule'.")
      end

      it 'adds the new rule to the rules array' do
        rule = double('rule').as_null_object
        expect(Object).to receive(:const_get).with('Bumblebee::NameRule').and_return(rule)
        rules = double('rules')
        entity_config.instance_variable_set(:@rules, rules)
        expect(rules).to receive(:push).with(rule)
        entity_config.name :field_name, :key => 'key'
      end
    end

    context '#run' do

      let(:extra_data_lambda) { double('extra_data_lambda').as_null_object }

      it 'expects data as param' do
        expect{ entity_config.run}.to raise_error ArgumentError
      end

      it 'loops through the rules and applies them' do
        rules = double('rules').as_null_object
        rule = double('rule')
        expect(rule).to receive(:run).with({}, extra_data_lambda).and_return({})
        expect(rules).to receive(:each).and_yield(rule)
        entity_config.instance_variable_set(:@rules, rules)
        entity_config.run({}, extra_data_lambda)
      end
    end
  end
end
