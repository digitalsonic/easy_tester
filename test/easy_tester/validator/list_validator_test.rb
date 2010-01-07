$:.unshift File.join(File.dirname(__FILE__),'../../..','lib')

require 'test/unit'
require 'easy_tester/validator/list_validator'
require 'easy_tester/validator/validator_test_data_class'

class ListValidatorTest < Test::Unit::TestCase
  def test_validator
    expectation = "key1='value1'|key2=2$key1=1.1"
    data1 = ValidatorTestDataClass.new
    data1.key1 = 'value1'
    data1.key2 = 2
    data2 = ValidatorTestDataClass.new
    data2.key1 = 1.1

    validator = EasyTester::Validator::ListValidator.new
    validator.validate expectation, [data1, data2]
  end
end

