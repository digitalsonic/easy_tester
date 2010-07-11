$:.unshift File.join(File.dirname(__FILE__),'../../../..','lib')

require 'test/unit'
require 'digest/md5'
require 'easy_tester/provider/web/txt_provider'

class TxtroviderTest < Test::Unit::TestCase
  include EasyTester::Provider::Web

  # URL;HTTP METHOD;验证器类;期望结果;"参数"
  def test_parse_detail
    time = Time.new
    sign = Digest::MD5.hexdigest 'abc'
    line = "/url;get;\"param1=abc&param2=\#{Time.new}&sign=\#{md5('abc')}\";SimpleValidator;aa;bb;cc"
    provider = TxtProvider.new
    tc = provider.parse_detail line
    assert_equal '/url', tc.url
    assert_equal 'GET', tc.method
    assert_equal 'SimpleValidator', tc.validator
    assert_equal "param1=abc&param2=#{time}&sign=#{sign}", tc.parameters
    
    assert_not_nil tc.expectation
    assert_kind_of Array, tc.expectation
    assert_equal 3, tc.expectation.size
    assert_equal 'aa', tc.expectation[0]
  end
end
