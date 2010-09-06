module EasyTester
  module Provider
    module WebService
      # WebService基础信息，包含Stub类及Endpoint的URL
      class WebServiceInfo
        attr_accessor :ws_driver, :endpoint

        def initialize ws_driver, endpoint
          @ws_driver = ws_driver
          @endpoint = endpoint
        end
      end
    end
  end
end
