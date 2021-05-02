require 'json'
require 'morpheus/api'


class MorpheusBluePrint < Inspec.resource(1)
  name 'morpheus_blueprint'
  desc 'Verifies settings for a morpheus blueprint'

  example "
    describe morpheus_blueprint(name: 'admin') do
      it { should exist }
    end
  "

  def initialize(opts)
    @opts = opts
    @display_name = @opts[:name]
    Morpheus::RestClient.enable_ssl_verification = false
    @client = Morpheus::APIClient.new(url:ENV['MORPHEUS_API_URL'], access_token: ENV['MORPHEUS_API_TOKEN'], verify_ssl: false)
    begin
      output = @client.blueprints.list({max:10000,sort:"name"})
      blueprints = output["blueprints"]
      blueprints.each do |blueprint|
        if blueprint["name"] == @opts[:name]
            @blueprint = blueprint
        end
      end
    rescue => e
      puts e
      @blueprint = e
    end
  end

  def name
    if @blueprint
      @blueprint.name
    else
      @error['error']['message']
    end
  end

  def exists?
    !@blueprint.nil?
  end

  def to_s
    "blueprint #{@display_name}"
  end
end