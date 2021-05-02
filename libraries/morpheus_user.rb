require 'json'
require 'morpheus/api'


class MorpheusUser < Inspec.resource(1)
  name 'morpheus_user'
  desc 'Verifies settings for a morpheus user'

  example "
    describe morpheus_user(name: 'admin') do
      it { should exist }
    end
  "

  def initialize(opts)
    @opts = opts
    @display_name = @opts[:name]
    Morpheus::RestClient.enable_ssl_verification = false
    @client = Morpheus::APIClient.new(url:ENV['MORPHEUS_API_URL'], access_token: ENV['MORPHEUS_API_TOKEN'], verify_ssl: false)
    begin
      output = @client.users.list(nil, {max:10000,sort:"username"})
      users = output["users"]
      users.each do |user|
        if user["username"] == @opts[:name]
            @user = user
        end
      end
    rescue => e
      puts e
      @user = e
    end
  end

  def name
    if @user
      @user.username
    else
      @error['error']['message']
    end
  end

  def email
    if @user
      @user["email"]
    else
      @error['error']['message']
    end
  end

  def display_name
    if @user
      @user["displayName"]
    else
      @error['error']['message']
    end
  end

  def roles
    if @user
      userroles = @user["roles"]
      roles = []
      userroles.each do |role|
        roles.append(role["authority"])
      end
      roles
    else
      @error['error']['message']
    end
  end

  def exists?
    !@user.nil?
  end

  def to_s
    "User #{@display_name}"
  end
end