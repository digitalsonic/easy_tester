require 'easy_tester/util'

module EasyTester
  module Provider
    module Web
      # 测试数据类
      class TestCaseData
        include Util
        attr_accessor :server, :port, :url, :method, :validator, :expectation, :parameters

        # 只接受POST/GET，默认为GET
        def method=(method)
          method = 'GET' unless !method.nil? && ['POST', 'GET'].include?(method.upcase)
          @method = method.upcase 
        end

        # parameters=赋值后调立刻进行数据处理，参数需要用"包围
        def parameters=(parameters)
          @parameters = translate_value parameters
        end
      end
    end
  end
end
