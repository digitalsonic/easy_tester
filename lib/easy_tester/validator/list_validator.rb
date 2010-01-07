require 'test/unit/assertions'
require 'easy_tester/validator/attr_validator'

module EasyTester
  module Validator
    # 列表对象验证器，调用AttrValidator进行具体对象的验证
    # key1=value1|key2=value2$key3=value3
    class ListValidator
      include Test::Unit::Assertions
      
      def validate expectation, result
        validator = AttrValidator.new
        list = expectation.split /\$/
        assert_equal list.size, result.size
        list.each_index { |idx| validator.validate list[idx], result[idx] }
      end
    end
  end
end
