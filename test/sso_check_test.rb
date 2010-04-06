require File.dirname(__FILE__) + "/helper"
require "heroku/sensei"

class SsoCheckTest < Test::Unit::TestCase
  include Heroku::Sensei

  setup do
    @data = Manifest.skeleton.merge :id => 123
    @data['api']['sso_salt'] = 'SSO_SALT'
  end

  def check ; SsoCheck ; end

  test "working sso request" do
    @data['api']['test'] += "working"
    assert_valid
  end

  test "rejects bad token" do
    @data['api']['test'] += "notoken"
    assert_invalid
  end

  test "rejects old timestamp" do
    @data['api']['test'] += "notimestamp"
    assert_invalid
  end

end