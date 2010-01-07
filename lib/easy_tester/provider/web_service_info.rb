module EasyTester
  module Provider
    # WebService基础信息，包含Stub类及WSDL的URL
    class WebServiceInfo
      attr_accessor :ws_driver, :wsdl_url

      def initialize ws_driver, wsdl_url
        @ws_driver = ws_driver
        @wsdl_url = wsdl_url
      end
    end
  end
end
