$:.unshift File.join(File.dirname(__FILE__),'../../..','lib')

require 'test/unit'
require 'easy_tester/validator/xml_xpath_validator'

class SingleXmlXpathValidatorTest < Test::Unit::TestCase
  def test_validate
    result = "<result><is_success>T</is_success></result>"
    validator = EasyTester::Validator::XmlXpathValidator.new
    validator.validate(["/result/is_success='T'", "//is_success[0]='T'"], result)
  end
end
