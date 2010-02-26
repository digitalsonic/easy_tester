require 'rubygems'
require 'nokogiri'
require 'test/unit/assertions'
require 'easy_tester/util'

module EasyTester
  module Validator
    # 针对XML的XPATH验证器
    # /html/body/p=xxx;/html/body/a[0]=xxx;/html/body/a[1]=xxx
    class XmlXpathValidator
      include Test::Unit::Assertions
      include Util

      attr_accessor :encode
      
      def validate expectation, result
        doc = Nokogiri::XML result, nil, @encode || 'UTF-8'
        expectation.each do |exp|
          xpath = exp.split("=")[0]
          value = translate_value(exp.split("=")[1])
          doc.xpath(xpath).each { |node| assert_equal value, node.content }
        end
      end
    end
  end
end
