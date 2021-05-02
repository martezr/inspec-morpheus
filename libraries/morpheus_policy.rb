require 'json'
require 'morpheus/api'


class MorpheusPolicy < Inspec.resource(1)
  name 'morpheus_policy'
  desc 'Verifies settings for a morpheus policy'

  example "
    describe morpheus_policy(name: 'mophopolicy') do
      it { should exist }
    end
  "

  def initialize(opts)
    @opts = opts
    @display_name = @opts[:name]
    Morpheus::RestClient.enable_ssl_verification = false
    @client = Morpheus::APIClient.new(url:ENV['MORPHEUS_API_URL'], access_token: ENV['MORPHEUS_API_TOKEN'], verify_ssl: false)
    begin
      output = @client.policies.list({max:10000,sort:"name"})
      policies = output["policies"]
      policies.each do |policy|
        if policy["name"] == @opts[:name]
            @policy = policy
        end
      end
    rescue => e
      puts e
      @policy = e
    end
  end

  def name
    if @policy
      @policy.name
    else
      @error['error']['message']
    end
  end

  def exists?
    !@policy.nil?
  end

  def to_s
    "policy #{@display_name}"
  end
end