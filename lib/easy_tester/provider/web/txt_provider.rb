require 'iconv'
require 'easy_tester/provider/web/test_case_data'
require 'easy_tester/util'

module EasyTester
  module Provider
    module Web
      # TXT测试数据提取类，忽略#开头的注释
      # 数据格式：
      # Server;Port
      # URL;HTTP METHOD;"参数";验证器类;期望结果...
      class TxtProvider
        attr_accessor :encode

        def initialize encode = 'UTF-8'
          @encode = encode
        end
        
        # 从文件中加载数据
        def load_data file_path
          data = []
          if File.exist?(file_path)
            file = File.new file_path
            file.each do |line|
              line = Iconv.iconv("UTF-8", @encode, line.strip).to_s
              next if line =~ /^#/ or line.empty?
              if data.empty?
                server, port = line.split /;/
                next
              end
              test_case = parse_detail line
              test_case.server, test_case.port = server, port
              data << test_case
            end
            file.close
          end
          data
        end

        def parse_detail line
          tc = TestCaseData.new
          tc.url, tc.method, tc.parameters, tc.validator, *tc.expectation = (line.split /;/)
          tc
        end
      end
    end
  end
end
