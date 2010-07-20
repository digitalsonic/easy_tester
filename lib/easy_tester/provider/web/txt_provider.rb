require 'iconv'
require 'yaml'
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
        attr_accessor :encode, :holder

        def initialize encode = 'UTF-8', holder_file = nil
          @encode = encode
          @holder = YAML.load(File.open(holder_file)) unless holder_file.nil?
        end
        
        # 从文件中加载数据
        def load_data file_path
          data = []
          if File.exist?(file_path)
            file = File.new file_path
            is_first_line = true
            server = nil
            port = 80
            file.each do |line|
              line = Iconv.iconv("UTF-8", @encode, line.strip).to_s
              next if line =~ /^#/ or line.empty?
              if is_first_line
                server, port = line.split(/;/)
                server, port = process_server_and_port server, port unless @holder.nil?
                is_first_line = false
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

        # 如果提供了@holder map，则根据其中的属性替换server和port的值
        def process_server_and_port origin_server, origin_port
          server = eval("\"#{origin_server}\"")
          port = eval("\"#{origin_port}\".to_i")
          [server, port]
        end
      end
    end
  end
end
