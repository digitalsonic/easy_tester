require 'net/http'
require 'easy_tester/executor/base_executor'
require 'easy_tester/provider/web/txt_provider'

module EasyTester
  module Executor
    class WebExecutor < BaseExecutor
      attr_accessor :data_file, :data_provider, :encode, :logger

      # 执行测试
      def execute_test
        @logger.info "Initializing..."
        data_list = load_test_data @data_file
        
        yield(data_list) if block_given?

        @logger.debug "Iterate the test data, executing test."
        data_list.each do |data|
          result = get_result data
          validate_result data, result
        end
        print_validation_result
      end

      # 加载测试数据
      def load_test_data file
        @logger.info "Loading test data..."
        @data_provider ||= Provider::Web::TxtProvider.new
        set_encode_charset @data_provider, @encode
        @data_provider.load_data file
      end

      # 获取请求返回内容
      def get_result data
        result = nil
        @logger.info "Get result from #{data.server}:#{data.port}#{data.url}..."
        res = Net::HTTP.start(data.server, data.port) {|http|
          if data.method == 'POST'
            http.post data.url, data.parameters
          else
            if data.parameters.nil? || data.parameters.empty?
              http.get data.url
            else
              http.get data.url + "?" + data.parameters
            end
          end
        }
        result = res.body
        
        # @logger.warn "Exception occured when #{data.method} #{data.url} with #{data.parameters}"
        
        result
      end
    end
  end
end
