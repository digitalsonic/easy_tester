require 'easy_tester/util'

module EasyTester
  module Provider
    module WebService
      # 测试数据
      class TestCaseData
        include Util
        attr_accessor :test_method, :validator, :expectation, :parameters_class, :parameters

        # parameters=赋值后调立刻进行数据处理
        def parameters=(parameters)
          @parameters = parameters
          @parameters.each_index do |idx|
            params = @parameters[idx].split '='
            if params.size == 1
              param_name = "in#{idx}"
              param_value = translate_value(@parameters[idx])
            else
              param_name = params[0]
              param_value = translate_value(params[1])
            end
            
            @parameters[idx] = [param_name, param_value]
          end
        end
      end
    end
  end
end