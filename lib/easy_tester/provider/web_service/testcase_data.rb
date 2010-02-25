require 'easy_tester/util'

module EasyTester
  module Provider
    module WebService
      # 测试数据
      class TestcaseData
        include Util
        attr_accessor :test_method, :validator, :expectation, :parameters_class, :parameters

        # parameters=赋值后调立刻进行数据处理
        def parameters=(parameters)
          @parameters = parameters
          @parameters.each_index { |idx| @parameters[idx] = translate_value(@parameters[idx]) }
        end
      end
    end
  end
end
