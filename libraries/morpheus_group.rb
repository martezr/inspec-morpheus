require 'json'
require 'morpheus/api'


class MorpheusGroup < Inspec.resource(1)
  name 'morpheus_group'
  desc 'Verifies settings for a morpheus group'

  example "
    describe morpheus_group(name: 'demo') do
      it { should exist }
    end
  "

  def initialize(opts)
    @opts = opts
    @display_name = @opts[:name]
    Morpheus::RestClient.enable_ssl_verification = false
    @client = Morpheus::APIClient.new(url:ENV['MORPHEUS_API_URL'], access_token: ENV['MORPHEUS_API_TOKEN'], verify_ssl: false)
    begin
      output = @client.groups.list({max:10000,sort:"name"})
      groups = output["groups"]
      groups.each do |group|
        if group["name"] == @opts[:name]
            @group = group
        end
      end
    rescue => e
      puts e
      @group = e
    end
  end

  def name
    if @group
      @group.name
    else
      @error['error']['message']
    end
  end

  def code
    if @group
      @group["code"]
    else
      @error['error']['message']
    end
  end

  def location
    if @group
      @group["location"]
    else
      @error['error']['message']
    end
  end

  def exists?
    !@group.nil?
  end

  def to_s
    "group #{@display_name}"
  end
end