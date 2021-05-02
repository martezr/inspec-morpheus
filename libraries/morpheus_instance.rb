require 'json'
require 'morpheus/api'


class MorpheusInstance < Inspec.resource(1)
  name 'morpheus_instance'
  desc 'Verifies settings for a morpheus instance'

  example "
    describe morpheus_instance(name: 'mophoinstance') do
      it { should exist }
    end
  "

  def initialize(opts)
    @opts = opts
    @display_name = @opts[:name]
    Morpheus::RestClient.enable_ssl_verification = false
    @client = Morpheus::APIClient.new(url:ENV['MORPHEUS_API_URL'], access_token: ENV['MORPHEUS_API_TOKEN'], verify_ssl: false)
    begin
      output = @client.instances.list({max:10000,sort:"name"})
      instances = output["instances"]
      instances.each do |instance|
        if instance["name"] == @opts[:name]
            @instance = instance
        end
      end
    rescue => e
      puts e
      @instance = e
    end
  end

  def name
    if @instance
      @instance.name
    else
      @error['error']['message']
    end
  end

  def exists?
    !@instance.nil?
  end

  def to_s
    "instance #{@display_name}"
  end
end