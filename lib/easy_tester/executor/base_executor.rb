require 'easy_tester/util'

module EasyTester
  module Executor
    class BaseExecutor
      include Util
      attr_accessor :data_file, :data_provider, :encode, :logger

      def initialize options = {}
        @logger = options[:logger] || create_default_logger
        @encode = options[:encode] || 'UTF-8'
      end

      # 验证结果
      def validate_result data, result
        validator = eval("#{data.validator}.new")
        set_encode_charset validator
        validator.validate data.expectation, result unless validator.nil?
        @logger.info "Validating Success!"
      end
      
      #protected :data_file, :data_provider, :encode, :logger
    end
  end
end
