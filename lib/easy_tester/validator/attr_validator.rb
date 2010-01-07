require 'test/unit/assertions'
require 'easy_tester/util/value_util'

module EasyTester
  module Validator
    # 验证对象属性值
    # key1=value1|key2=value2
    class AttrValidator
      include Test::Unit::Assertions
      include EasyTester::Util::ValueUtil
    
      def validate expectation, result
        value_map = {}
        arr = expectation.split "|"
        arr.each { |pair| value_map[pair.split("=")[0].intern] = translate_value(pair.split("=")[1]) }
        validate_attr value_map, result
      end

      def validate_attr expectation, result
        expectation.each { |key, value| assert_equal value, result.send(key) }
      end
    end
  end
end
