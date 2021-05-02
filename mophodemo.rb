require 'morpheus/api'

Morpheus::RestClient.enable_ssl_verification = false
client = Morpheus::APIClient.new(url:ENV['MORPHEUS_API_URL'], access_token: ENV['MORPHEUS_API_TOKEN'], verify_ssl: false)
#blueprints = client.blueprints.list({max:10000,sort:"name"})
#puts blueprints
#blueprints["blueprints"].each do |blueprint|
#    puts blueprint["name"]
#end

clouds = client.clouds.list({max:10000,sort:"name"})
puts clouds
#roleid = 0
#roles["roles"].each do | role |
#    if role["authority"] == "System Admin"
#        roleid = role["id"]
#    end
#end

#role = client.roles.get(nil, roleid)
#puts role
#users = output["users"]
#users.each do |user|
#    puts user
# end


#output = client.roles.list(nil, {max:10000,sort:""})
#roles = output["roles"]
#roles.each do |role|
#    puts role
#end

#data = client.roles.get(nil,1)
#puts data
#data["featurePermissions"].each do |permission|
#    puts permission["name"] + " - " + permission["access"]
#end

#data["instanceTypePermissions"].each do |permission|
#    puts permission["name"] + " - " + permission["access"]
#end

#puts data["globalInstanceTypeAccess"]
#puts data["globalAppTemplateAccess"]
#puts data["globalCatalogItemTypeAccess"]
#puts data["personaPermissions"]

#catalogItemTypePermissions
#appTemplatePermissions