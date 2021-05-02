require 'json'
require 'morpheus/api'


class Morpheustask < Inspec.resource(1)
  name 'morpheus_task'
  desc 'Verifies settings for a morpheus task'

  example "
    describe morpheus_task(name: 'mophotask') do
      it { should exist }
    end
  "

  def initialize(opts)
    @opts = opts
    @display_name = @opts[:name]
    Morpheus::RestClient.enable_ssl_verification = false
    @client = Morpheus::APIClient.new(url:ENV['MORPHEUS_API_URL'], access_token: ENV['MORPHEUS_API_TOKEN'], verify_ssl: false)
    begin
      output = @client.tasks.list({max:10000,sort:"name"})
      tasks = output["tasks"]
      tasks.each do |task|
        if task["name"] == @opts[:name]
            @task = task
        end
      end
    rescue => e
      puts e
      @task = e
    end
  end

  def name
    if @task
      @task.name
    else
      @error['error']['message']
    end
  end

  def exists?
    !@task.nil?
  end

  def to_s
    "task #{@display_name}"
  end
end