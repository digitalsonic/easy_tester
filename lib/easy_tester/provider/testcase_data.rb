require 'easy_tester/util/value_util'

module EasyTester
  module Provider
    # 测试数据
    class TestcaseData
      include EasyTester::Util::ValueUtil

      attr_accessor :test_method, :validator, :expectation, :parameters_class, :parameters

      # parameters=赋值后调立刻进行数据处理
      def parameters=(parameters)
        @parameters = parameters
        @parameters.each_index { |idx| @parameters[idx] = translate_value(@parameters[idx]) }
      end
    end
  end
end