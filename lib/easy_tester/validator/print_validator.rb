require 'iconv'

module EasyTester
  module Validator
    # 简单打印结果
    class PrintValidator
      attr_accessor :encode
      @encode = 'UTF-8'

      def validate expectation, result
        puts "[result - START]"
        result.instance_variables.each { |var| puts var + "=" + Iconv.iconv(@encode, "UTF-8", result.instance_variable_get(var)).to_s }
        puts "[result - END]"
      end
    end
  end
end
