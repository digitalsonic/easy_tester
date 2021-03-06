$:.unshift File.join(File.dirname(__FILE__),'../../../..','lib')

require 'test/unit'
require 'easy_tester/provider/web_service/txt_provider'

class TxtProviderTest < Test::Unit::TestCase
  include EasyTester::Provider::WebService

  def test_load_data
    data_file = File.dirname(__FILE__) + "/txt_test_data_file.txt"
    provider = TxtProvider.new
    data = provider.load_data data_file
    ws_info = data.ws_info
    tc = data.test_cases[0]
    assert_equal 'LocalService', ws_info.ws_driver
    assert_equal 'http://localhost:8080/services/localService?wsdl', ws_info.endpoint
    assert_equal 'method', tc.test_method
    assert_equal 'SimpleValidator', tc.validator
    assert_equal '1', tc.expectation
    assert_equal 'ParamClass', tc.parameters_class
  end

  # Driver,wsdl
  def test_parse_head
    line = 'LocalService;http://localhost:8080/services/localService?wsdl'
    provider = TxtProvider.new
    ws_info = provider.parse_head line
    assert_equal 'LocalService', ws_info.ws_driver
    assert_equal 'http://localhost:8080/services/localService?wsdl', ws_info.endpoint
  end

  # 测试方法,期望结果,参数类,参数...
  def test_parse_detail
    line = "download;SimpleValidator;aa|bb|cc;DownloadParams;'aa';1;1.1;Time.new - (60 * 60 * 24 * 100)"
    provider = TxtProvider.new
    tc = provider.parse_detail line
    assert_equal 'download', tc.test_method
    assert_equal 'SimpleValidator', tc.validator
    assert_equal 'aa|bb|cc', tc.expectation
    assert_equal 'DownloadParams', tc.parameters_class
    
    assert_not_nil tc.parameters
    assert_kind_of Array, tc.parameters
    assert_equal 4, tc.parameters.size
    assert_equal ['in0', 'aa'], tc.parameters[0]
    assert_equal ['in1', 1], tc.parameters[1]
    assert_equal ['in2', 1.1], tc.parameters[2]
    assert Time.new - (60 * 60 * 24 * 100) - tc.parameters[3][1] < 10
  end

  def test_process_driver_and_wsdl
    provider = TxtProvider.new
    provider.holder = {"domain" => "localhost:8080", "driver" => "Service"}
    driver, endpoint = provider.process_driver_and_endpoint("\#{@holder['driver']}", "http://\#{@holder['domain']}/services/localService?wsdl")
    assert_equal "Service", driver
    assert_equal "http://localhost:8080/services/localService?wsdl", endpoint
  end
end
