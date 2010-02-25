$:.unshift File.join(File.dirname(__FILE__),'../','lib')

require 'test/unit'
require 'easy_tester'
require 'easy_tester/provider/web_service/testcase_data'

class EasyTesterTest < Test::Unit::TestCase
  def test_make_request_parameters
    tester = EasyTester::EasyTester.new

    data = EasyTester::Provider::WebService::TestcaseData.new
    data.expectation = '1'
    data.test_method = 'test'
    data.parameters = ["1", "'2'"]
    data.parameters_class = 'TesterClass'

    parameters = tester.make_request_parameters data
    assert_equal 1, parameters.in0
    assert_equal '2', parameters.in1
  end

  def test_execute_method
    tester = EasyTester::EasyTester.new
    tc = TesterClass.new '1', '2'
    assert_equal 2, tester.execute_method(tc, 'add', 1)
  end
end

class TesterClass
  attr_accessor :in0, :in1

  def initialize param1 = nil, param2 = nil
    @in0 = param1
    @in1 = param2
  end

  def add val1
    val1 + 1
  end
end
