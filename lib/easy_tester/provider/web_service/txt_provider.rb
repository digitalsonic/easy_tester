require 'iconv'
require 'yaml'
require 'easy_tester/provider/web_service/data'
require 'easy_tester/provider/web_service/test_case_data'
require 'easy_tester/provider/web_service/web_service_info'
require 'easy_tester/util'

module EasyTester
  module Provider
    module WebService
      # TXT测试数据提取类，忽略#开头的注释
      # 数据格式：
      # Driver;wsdl
      # 测试方法;验证器类;期望结果;参数类;参数...
      # 测试方法;验证器类;期望结果;参数类;参数...
      class TxtProvider
        attr_accessor :encode, :holder
      
        def initialize encode = 'UTF-8', holder_file = nil
          @encode = encode
          @holder = YAML.load(File.open(holder_file)) unless holder_file.nil?
        end

        # 从文件中加载数据
        def load_data file_path
          data = nil
          if File.exist?(file_path)
            file = File.new file_path
            data = Data.new
            file.each do |line|
              line = Iconv.iconv("UTF-8", @encode, line.strip).to_s
              next if line =~ /^#\s/ or line.empty?
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
          driver, endpoint = line.split /;/
          driver, endpoint = process_driver_and_endpoint driver, endpoint unless @holder.nil?
          WebServiceInfo.new driver, endpoint
        end

        # 解析数据明细
        def parse_detail line
          tc = TestCaseData.new
          tc.test_method, tc.validator, tc.expectation, tc.parameters_class, *tc.parameters = (line.split /;/)
          tc
        end

        # 如果提供了@holder map，则根据其中的属性替换driver和endpoint的值
        def process_driver_and_endpoint origin_driver, origin_endpoint
          driver = eval("\"#{origin_driver}\"")
          endpoint = eval("\"#{origin_endpoint}\"")
          [driver, endpoint]
        end
      end
    end
  end
end
