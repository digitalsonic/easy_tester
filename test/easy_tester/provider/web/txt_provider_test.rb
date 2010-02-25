$:.unshift File.join(File.dirname(__FILE__),'../../../..','lib')

require 'test/unit'
require 'easy_tester/provider/web/txt_provider'

class TxtroviderTest < Test::Unit::TestCase
  include EasyTester::Provider::Web

  # HTTP METHOD;验证器类;期望结果;"参数"
  def test_parse_detail
    time = Time.new
    line = "get;SimpleValidator;aa|bb|cc;\"abc&\#{Time.new}\""
    provider = TxtProvider.new
    tc = provider.parse_detail line
    assert_equal 'GET', tc.method
    assert_equal 'SimpleValidator', tc.validator
    assert_equal 'aa|bb|cc', tc.expectation
    assert_equal "abc&#{time}", tc.parameters
  end
end
