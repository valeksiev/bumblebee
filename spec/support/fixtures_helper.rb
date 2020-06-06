module FixturesHelper

  def fixture_path fixture
    File.join(File.dirname(__FILE__), "../fixtures/#{fixture}")
  end
end
