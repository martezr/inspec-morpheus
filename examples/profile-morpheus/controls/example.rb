control 'lab-1' do
    title 'Verify that the user exists with the correct roles'
    impact 1.0

    describe morpheus_group(name: 'demo') do
      it { should exist }
      its('code') { should eq 'test' }
      its('location') { should eq 'test' }
    end
end

control 'lab-2' do
  title 'Verify that the user exists with the correct roles'
  impact 1.0
  describe morpheus_cloud(name: 'GRTVCENTER') do
    it { should exist }
    its('code') { should eq 'test' }
    its('location') { should eq 'test' }
  end
end

#control 'morpheus_user_example' do
#    title 'Verify that the user exists with the correct roles'
#    impact 1.0
  
#    describe morpheus_user(name: 'mreed') do
#      it { should exist }
#      its('email') { should eq 'inspec-test' }
#      its('display_name') { should eq 'inspec-test' }
#      its('roles') { should cmp ['System Admin'] }
#    end
#  end

#control 'morpheus_blueprint_example' do
#  title 'Check if blueprint exist'
#  impact 1.0

#  describe morpheus_blueprint(name: 'awxdemo') do
#    it { should exist }
#  end
#end

#control 'morpheus_workflow_example' do
#  title 'Check if workflow exist'
#  impact 1.0

#  describe morpheus_workflow(name: 'TowerTest') do
#    it { should exist }
#  end
#end

#control 'morpheus_task_validation' do
#  title 'Check if task exist'
#  impact 1.0
#  describe morpheus_task(name: 'test') do
#    it { should exist }
#  end
#end

#describe morpheus_integration(name: 'Ansible Hello World') do
#  it { should exist }
#  its('status') { should eq 'ok' }
#  its('type') { should eq 'Ansible' }
#end

#describe morpheus_policy(name: 'GRT Naming') do
#  it { should exist }
#end

#describe morpheus_role(name: 'System Admin') do
#  it { should exist }
#  its('global_site_access') { should eq 'full' }
#  its('global_zone_access') { should eq 'full' }
#  its('global_catalog_item_type_access') { should eq 'inspec-test' }
#  its('global_instance_type_access') { should eq 'inspec-test' }
#  its('global_app_template_access') { should eq 'full' }
#  its('persona_permissions') { should include("Service Catalog" => "full") }
#end

