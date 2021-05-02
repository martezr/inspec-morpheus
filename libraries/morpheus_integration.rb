require 'json'
require 'morpheus/api'


class MorpheusIntegration < Inspec.resource(1)
  name 'morpheus_integration'
  desc 'Verifies settings for a morpheus integration'

  example "
    describe morpheus_integration(name: 'admin') do
      it { should exist }
    end
  "

  def initialize(opts)
    @opts = opts
    @display_name = @opts[:name]
    Morpheus::RestClient.enable_ssl_verification = false
    @client = Morpheus::APIClient.new(url:ENV['MORPHEUS_API_URL'], access_token: ENV['MORPHEUS_API_TOKEN'], verify_ssl: false)
    begin
      output = @client.integrations.list({max:10000,sort:"name"})
      integrations = output["integrations"]
      integrations.each do |integration|
        if integration["name"] == @opts[:name]
            @integration = integration
        end
      end
    rescue => e
      puts e
      @integration = e
    end
  end

  def name
    if @integration
      @integration.name
    else
      @error['error']['message']
    end
  end

  def type
    if @integration
      @integration["integrationType"]["name"]
    else
      @error['error']['message']
    end
  end

  def status
    if @integration
      @integration["status"]
    else
      @error['error']['message']
    end
  end

  def exists?
    !@integration.nil?
  end

  def to_s
    "integration #{@display_name}"
  end
end