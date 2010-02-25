require 'logger'
require 'rubygems'
require 'easy_tester/validator/validator'
require 'easy_tester/provider/web_service/txt_provider'
gem 'soap4r'

module EasyTester
  # 测试用例执行器
  class EasyTester
    include Validator
    attr_accessor :data_file, :data_provider, :encode

    def initialize encode = 'UTF-8'
      @logger = Logger.new(STDOUT)
      @logger.level = Logger::INFO
      @encode = encode
    end

    # 执行测试
    def execute_test
      @logger.info "Initializing..."
      data = load_test_data @data_file
      obj = create_ws_obj data.ws_info.ws_driver, data.ws_info.wsdl_url
      data_list = data.test_cases

      unless obj.nil?
        @logger.debug "Iterate the test data, executing test methods."
        data_list.each do |tc_data|
          parameters = make_request_parameters tc_data
          result = execute_method(obj, tc_data.test_method, parameters).out
          validate_result tc_data, result
        end
      end
    end

    # 加载测试数据
    def load_test_data file
      @logger.info "Loading test data..."
      @data_provider = Provider::TxtProvider.new if @data_provider.nil?
      set_encode_charset @data_provider
      @data_provider.load_data file
    end

    # 创建WebService
    def create_ws_obj driver, wsdl
      @logger.info "Creating web service stub: #{driver}, wsdl: #{wsdl}"
      eval "#{driver}.new '#{wsdl}'"
    end

    # 构造参数
    def make_request_parameters data
      @logger.debug "Construct parameters, total count: #{data.parameters.size}"
      param = eval("#{data.parameters_class}.new")
      data.parameters.each_index { |idx| param.send("in#{idx}=".intern, data.parameters[idx]) }
      param
    end

    # 执行Web Service
    def execute_method ws_stub, method_name, parameters
      @logger.info "Invoking method: #{method_name} Parameters: #{parameters.inspect}"
      ws_stub.send method_name.intern, parameters unless ws_stub.nil?
    end

    # 验证结果
    def validate_result data, result
      validator = eval("#{data.validator}.new")
      set_encode_charset validator
      validator.validate data.expectation, result unless validator.nil?
      @logger.info "Validating Success!"
    end

    def set_encode_charset obj
      obj.encode = @encode if obj.respond_to?("encode=".intern)
    end
  end
end
