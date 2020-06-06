require 'spec_helper'

module Bumblebee

  describe 'Connector' do

    it 'has data method which is not imeplemented' do
      connector = Bumblebee::Connector.new
      expect{connector.data}.to raise_error(RuntimeError)
    end
  end
end
