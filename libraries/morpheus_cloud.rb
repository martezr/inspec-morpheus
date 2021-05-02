require 'json'
require 'morpheus/api'


class MorpheusCloud < Inspec.resource(1)
  name 'morpheus_cloud'
  desc 'Verifies settings for a morpheus cloud'

  example "
    describe morpheus_cloud(name: 'demo') do
      it { should exist }
    end
  "

  def initialize(opts)
    @opts = opts
    @display_name = @opts[:name]
    Morpheus::RestClient.enable_ssl_verification = false
    @client = Morpheus::APIClient.new(url:ENV['MORPHEUS_API_URL'], access_token: ENV['MORPHEUS_API_TOKEN'], verify_ssl: false)
    begin
      output = @client.clouds.list({max:10000,sort:"name"})
      clouds = output["zones"]
      clouds.each do |cloud|
        if cloud["name"] == @opts[:name]
            @cloud = cloud
        end
      end
    rescue => e
      puts e
      @cloud = e
    end
  end

  def name
    if @cloud
      @cloud.name
    else
      @error['error']['message']
    end
  end

  def code
    if @cloud
      @cloud["code"]
    else
      @error['error']['message']
    end
  end

  def location
    if @cloud
      @cloud["location"]
    else
      @error['error']['message']
    end
  end

  def visibility
    if @cloud
      @cloud["visibility"]
    else
      @error['error']['message']
    end
  end

  def status
    if @cloud
      @cloud["status"]
    else
      @error['error']['message']
    end
  end

  def exists?
    !@cloud.nil?
  end

  def to_s
    "cloud #{@display_name}"
  end
end