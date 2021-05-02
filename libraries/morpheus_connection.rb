require 'morpheus/api'

class MorpheusConnection
    def initialize
      Morpheus::RestClient.enable_ssl_verification = false
      return Morpheus::APIClient
    end
end
  