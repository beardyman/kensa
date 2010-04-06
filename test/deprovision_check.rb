require File.dirname(__FILE__) + "/helper"
require "heroku/sensei"

class DeprovisionCheckTest < Test::Unit::TestCase
  include Heroku::Sensei

  setup do
    @data = Manifest.skeleton.merge :id => 123
    @responses = [
      [200, ""],
      [401, ""],
    ]
  end

  def check ; DeprovisionCheck ; end

  test "valid on 200" do
    assert_valid do |check|
      stub :delete, check, @responses
    end
  end

  test "status other than 200" do
    @responses[0] = [500, ""]
    assert_invalid do |check|
      stub :delete, check, @responses
    end
  end

  test "runs auth check" do
    @responses[1] = [200, ""]
    assert_invalid do |check|
      stub :delete, check, @responses
    end
  end

end