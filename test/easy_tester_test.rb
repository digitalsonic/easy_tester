$:.unshift File.join(File.dirname(__FILE__),'../','lib')

require 'test/unit'
require 'easy_tester'

class EasyTesterTest < Test::Unit::TestCase
  def test_init
    EasyTester::EasyTester.new
  end
end
