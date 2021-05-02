require 'json'
require 'morpheus/api'


class MorpheusRole < Inspec.resource(1)
  name 'morpheus_role'
  desc 'Verifies settings for a morpheus role'

  example "
    describe morpheus_role(name: 'System Admin') do
      it { should exist }
    end
  "

  def initialize(opts)
    @opts = opts
    @display_name = @opts[:name]
    Morpheus::RestClient.enable_ssl_verification = false
    @client = Morpheus::APIClient.new(url:ENV['MORPHEUS_API_URL'], access_token: ENV['MORPHEUS_API_TOKEN'], verify_ssl: false)
    begin
      output = @client.roles.list(nil, {max:10000,sort:""})
      roles = output["roles"]
      @roleid = nil
      roles.each do |role|
        if role["authority"] == @opts[:name]
            @roleid = role["id"]
        end
      end
      @role = @client.roles.get(nil, @roleid)
    rescue => e
      @role = e
    end
  end

  def name
    if @role
      @role["authority"]
    else
      @error['error']['message']
    end
  end

  def persona_permissions
    if @role
        permissions = Hash.new
        @role["personaPermissions"].each do |permission|
          permissions[permission["name"]] = permission["access"]
        end
        permissions
    else
        @error['error']['message']
    end
  end

  def global_site_access
    if @role
        @role["globalSiteAccess"]
    else
        @error['error']['message']
    end
  end

  def global_zone_access
    if @role
        @role["globalZoneAccess"]
    else
        @error['error']['message']
    end
  end

  def global_catalog_item_type_access
    if @role
        @role["globalCatalogItemTypeAccess"]
    else
        @error['error']['message']
    end
  end

  def global_app_template_access
    if @role
        @role["globalAppTemplateAccess"]
    else
        @error['error']['message']
    end
  end

  def global_instance_type_access
    if @role
        @role["globalInstanceTypeAccess"]
    else
        @error['error']['message']
    end
  end

  def exists?
    !@role.nil?
  end

  def to_s
    "role #{@display_name}"
  end
end