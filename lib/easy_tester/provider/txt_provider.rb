require 'iconv'
require 'easy_tester/provider/data'
require 'easy_tester/provider/testcase_data'
require 'easy_tester/provider/web_service_info'
require 'easy_tester/util/value_util'

module EasyTester
  module Provider
    # TXT测试数据提取类，忽略#开头的注释
    # 数据格式：
    # Driver,wsdl
    # 测试方法,期望结果,参数类,参数...
    # 测试方法,期望结果,参数类,参数...
    class TxtProvider
      attr_accessor :encode
      @encode = 'UTF-8'
	  
      def load_data *args
        load_data_from_file args[0]
      end

      # 从文件中加载数据
      def load_data_from_file file_path
        data = nil
        if File.exist?(file_path)
          file = File.new file_path
          data = Data.new
          file.each do |line|
            line = Iconv.iconv("UTF-8", @encode, line.strip).to_s
            next if line =~ /^#/ or line.empty?
            if data.ws_info.nil?
              data.ws_info = parse_head line
              next
            end
            data.test_cases << parse_detail(line)
          end
          file.close
        end
        data
      end

      # 解析文件头
      def parse_head line
        head_data = line.split /;/
        WebServiceInfo.new head_data[0], head_data[1]
      end

      # 解析数据明细
      def parse_detail line
        tc = TestcaseData.new
        tc.test_method, tc.validator, tc.expectation, tc.parameters_class, *tc.parameters = (line.split /;/)
        tc
      end
    end
  end
end
