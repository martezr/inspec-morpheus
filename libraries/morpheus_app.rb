require 'json'
require 'morpheus/api'


class MorpheusApp < Inspec.resource(1)
  name 'morpheus_app'
  desc 'Verifies settings for a morpheus app'

  example "
    describe morpheus_app(name: 'admin') do
      it { should exist }
    end
  "

  def initialize(opts)
    @opts = opts
    @display_name = @opts[:name]
    Morpheus::RestClient.enable_ssl_verification = false
    @client = Morpheus::APIClient.new(url:ENV['MORPHEUS_API_URL'], access_token: ENV['MORPHEUS_API_TOKEN'], verify_ssl: false)
    begin
      output = @client.apps.list({max:10000,sort:"name"})
      apps = output["apps"]
      apps.each do |app|
        if app["name"] == @opts[:name]
            @app = app
        end
      end
    rescue => e
      puts e
      @app = e
    end
  end

  def name
    if @app
      @app.name
    else
      @error['error']['message']
    end
  end

  def exists?
    !@app.nil?
  end

  def to_s
    "app #{@display_name}"
  end
end