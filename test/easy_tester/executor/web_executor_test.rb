$:.unshift File.join(File.dirname(__FILE__),'../../','lib')

require 'test/unit'
require 'easy_tester/executor/web_executor'
require 'easy_tester/provider/web/test_case_data'

module EasyTester
  module Executor
    class WebExecutorTest < Test::Unit::TestCase
      def test_get_result
        executor = EasyTester::Executor::WebExecutor.new
        data = EasyTester::Provider::Web::TestCaseData.new
        data.server = 'www.google.com'
        data.port = '80'
        data.url = '/'
        data.parameters = ""
        result = executor.get_result(data)
        assert_not_nil result
      end
    end
  end
end
