$:.unshift File.join(File.dirname(__FILE__),'../../..','lib')

require 'test/unit'
require 'easy_tester/validator/attr_validator'
require 'easy_tester/validator/validator_test_data_class'

class AttrValidatorTest < Test::Unit::TestCase
  def test_validate
    expectation = "key1='value1'|key2='value2'"
    data = ValidatorTestDataClass.new
    data.key1 = 'value1'
    data.key2 = 'value2'
    validator = EasyTester::Validator::AttrValidator.new
    validator.validate expectation, data
  end
end

