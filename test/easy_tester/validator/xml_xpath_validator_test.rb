$:.unshift File.join(File.dirname(__FILE__),'../../..','lib')

require 'test/unit'
require 'easy_tester/validator/xml_xpath_validator'

class SingleXmlXpathValidatorTest < Test::Unit::TestCase
  def test_validate
    result = "<results><is_success>T</is_success><result>ABC</result><result>DEF</result></results>"
    validator = EasyTester::Validator::XmlXpathValidator.new
    validator.validate(["/results/is_success='T'", "//is_success[1]='T'"], result)
    validator.validate(["//result[1]='ABC'", "//result[2]='DEF'"], result)
  end
end
