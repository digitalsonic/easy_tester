require 'logger'

module EasyTester
  module Util
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

    # 创建输出到STDOUT的日志，级别默认为为INFO
    def create_default_logger level = Logger::INFO
      logger = Logger.new(STDOUT)
      logger.level = level
      logger
    end

    # 如果给定对象有encode=方法，则通过该方法来设置编码
    def set_encode_charset obj, encode
      obj.encode = encode if !obj.nil? && obj.respond_to?("encode=".intern)
    end
  end
end
