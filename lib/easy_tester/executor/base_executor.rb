require 'easy_tester/util'
require 'easy_tester/validator/validator'

module EasyTester
  module Executor
    class BaseExecutor
      include Util
      include Validator
      attr_accessor :data_file, :data_provider, :encode, :logger, :continue_when_assert_fail

      def initialize options = {}
        @logger = options[:logger] || create_default_logger
        @encode = options[:encode] || 'UTF-8'
        @validation_count = 0
        @validation_failed_count = 0
      end

      # 验证结果
      def validate_result data, result
        begin
          @validation_count += 1
          validator = eval("#{data.validator}.new")
          set_encode_charset validator, @encode
          validator.validate data.expectation, result unless validator.nil?
          @logger.info "Validating Success!"
        rescue Test::Unit::AssertionFailedError
          @validation_failed_count += 1
          handle_assertion_failure $!
        end
      end

      # 根据@continue_when_assert_fail参数内容，决定继续执行任务，或者终止执行
      def handle_assertion_failure exception
        if @continue_when_assert_fail.nil?
          raise exception
        else
          @logger.warn "Validation Failed!\n" + exception
        end
      end

      # 打印执行结果
      def print_validation_result
        @logger.info "Validation Finished! Excuted: #{@validation_count} Failed: #{@validation_failed_count}"
      end
    end
  end
end
