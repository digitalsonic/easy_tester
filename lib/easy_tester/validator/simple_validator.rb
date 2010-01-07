require 'test/unit/assertions'
require 'easy_tester/util/value_util'

module EasyTester
  module Validator
    # 验证两个值是否相等
    class SimpleValidator
      include Test::Unit::Assertions
      include EasyTester::Util::ValueUtil

      def validate expectation, result
        assert_equal translate_value(expectation), result
      end
    end
  end
end
