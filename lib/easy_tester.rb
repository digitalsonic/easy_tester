require 'logger'
require 'easy_tester/util'

module EasyTester
  # 测试用例执行器
  class EasyTester
    include Util
    attr_accessor :data_file, :data_provider, :encode

    def initialize encode = 'UTF-8'
      @logger = create_default_logger
      @encode = encode
    end

    # 执行测试
    def execute_test executor
      get_executor(executor).execute_test
    end

    # 根据名字取得Executor
    def get_executor name
      case name
      when :webservice
        require 'easy_tester/executor/web_service_executor'
        executor = Executor::WebServiceExecutor.new @encode, @logger
      when :web
        # TODO:
      else
        raise "Can not find the specified executor #{name}"
      end
      executor.data_file = @data_file
      executor.data_provider = @data_provider
      executor
    end
  end
end
