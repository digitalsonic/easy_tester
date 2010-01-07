$:.unshift File.join(File.dirname(__FILE__),'../../..','lib')

require 'test/unit'
require 'easy_tester/validator/print_validator'
require 'easy_tester/validator/validator_test_data_class'

class PrintValidatorTest < Test::Unit::TestCase
  def test_validate
    validator = EasyTester::Validator::PrintValidator.new
    data = ValidatorTestDataClass.new
    data.key1 = 'test1'
    data.key2 = 'test2'
    validator.validate nil, data
  end
end
