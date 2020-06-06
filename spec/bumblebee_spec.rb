require "spec_helper"

RSpec.describe Bumblebee do
  it "has a version number" do
    expect(Bumblebee::VERSION).not_to be nil
  end
end
