module EasyTester
  module Provider
    # 测试数据类
    # 包含Webservice信息和所有测试用例数据
    class Data
      attr_accessor :ws_info, :test_cases

      def initialize
        @test_cases = []
      end
    end
  end
end
