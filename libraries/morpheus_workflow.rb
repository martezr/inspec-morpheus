require 'json'
require 'morpheus/api'


class MorpheusWorkflow < Inspec.resource(1)
  name 'morpheus_workflow'
  desc 'Verifies settings for a morpheus workflow'

  example "
    describe morpheus_workflow(name: 'mophoworkflow') do
      it { should exist }
    end
  "

  def initialize(opts)
    @opts = opts
    @display_name = @opts[:name]
    Morpheus::RestClient.enable_ssl_verification = false
    @client = Morpheus::APIClient.new(url:ENV['MORPHEUS_API_URL'], access_token: ENV['MORPHEUS_API_TOKEN'], verify_ssl: false)
    begin
      output = @client.task_sets.list({max:10000,sort:"name"})
      workflows = output["taskSets"]
      workflows.each do |workflow|
        if workflow["name"] == @opts[:name]
            @workflow = workflow
        end
      end
    rescue => e
      puts e
      @workflow = e
    end
  end

  def name
    if @workflow
      @workflow.name
    else
      @error['error']['message']
    end
  end

  def exists?
    !@workflow.nil?
  end

  def to_s
    "workflow #{@display_name}"
  end
end