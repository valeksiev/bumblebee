require 'spec_helper'

module Bumblebee

  describe 'FieldRule' do

    let(:rule) { FieldRule.new [:key, { :key => 'value' } ] }

    it 'has run method' do
      expect(rule).to respond_to(:run)
    end

    context '#run' do

      it 'expects data' do
        expect{ rule.run }.to raise_error ArgumentError
        expect{ rule.run({}) }.not_to raise_error
      end

      it 'extracts value from the data by key' do
        data = double('data')
        expect(data).to receive(:[]).with('value')
        rule.run data
      end

      it 'calls lambda function' do
        data = double('data')
        expect(data).to receive(:[]).with('value').and_return 'slon'
        lmbda = double('lambda')
        expect(lmbda).to receive(:nil?).and_return(false)
        expect(lmbda).to receive(:call).with('slon')
        rule.instance_variable_set(:@lambda, lmbda)
        rule.run data
      end

      it 'does not calls lambda function if not present' do
        data = double('data')
        expect(data).to receive(:[]).with('value').and_return 'slon'
        lmbda = double('lambda')
        expect(lmbda).to receive(:nil?).and_return(true)
        expect(lmbda).not_to receive(:call)
        rule.instance_variable_set(:@lambda, lmbda)
        rule.run data
      end

      it 'returns hash' do
        result = rule.run({})
        expect(result).to be_instance_of(Hash)
      end

    end
  end
end
