$:.unshift File.join(File.dirname(__FILE__),'../../','lib')

require 'test/unit'
require 'easy_tester/executor/web_service_executor'
require 'easy_tester/provider/web_service/test_case_data'

module EasyTester
  module Executor
    class WebServiceExecutorTest < Test::Unit::TestCase
      def test_make_request_parameters
        executor = Executor::WebServiceExecutor.new

        data = Provider::WebService::TestCaseData.new
        data.expectation = '1'
        data.test_method = 'test'
        data.parameters = ["1", "'2'"]
        data.parameters_class = 'TesterClass'

        parameters = executor.make_request_parameters data
        assert_equal 1, parameters.in0
        assert_equal '2', parameters.in1
      end

      def test_execute_method
        executor = Executor::WebServiceExecutor.new
        tc = TesterClass.new '1', '2'
        assert_equal 2, executor.execute_method(tc, 'add', 1)
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
  end
end
