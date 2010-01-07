module EasyTester
  module Util
    module ValueUtil
      # 转换特定格式的字符串值
      # 普通字符串用''围绕
      # 整数及小数直接书写
      # 其他类型最后将使用eval转换
      def translate_value value
        ret_value = nil
        if value =~ /^'.*'$/ # 普通字符串
          ret_value = value.delete "'"
        elsif value =~ /^-?\d+$/ # 整数
          ret_value = value.to_i
        elsif value =~ /^-?\d+\.\d+$/ # 小数
          ret_value = value.to_f
        else
          ret_value = eval(value)
        end
        ret_value
      end
    end
  end
end
