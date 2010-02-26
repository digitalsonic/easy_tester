require 'logger'
require 'easy_tester/util'

module EasyTester
  # 测试用例执行器
  class EasyTester
    include Util
    attr_accessor :data_file, :data_provider, :encode

    def initialize encode = 'UTF-8', logger_level = Logger::INFO
      @logger = create_default_logger(logger_level)
      @encode = encode
    end

    # 执行测试，目前支持执行器:webservice和:web
    # 可提供一个{|data|...}块，在执行测试前处理数据
    def execute_test executor_name, &block
      get_executor(executor_name).execute_test &block
    end

    # 根据名字取得Executor
    def get_executor name
      case name
      when :webservice
        require 'easy_tester/executor/web_service_executor'
        executor = Executor::WebServiceExecutor.new({:encode => @encode, :logger => @logger})
      when :web
        require 'easy_tester/executor/web_executor'
        executor = Executor::WebExecutor.new({:encode => @encode, :logger => @logger})
      else
        raise "Can not find the specified executor #{name}"
      end
      executor.data_file = @data_file
      executor.data_provider = @data_provider
      executor
    end
  end
end
