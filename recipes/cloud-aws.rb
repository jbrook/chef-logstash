include_recipe "ark"
include_recipe "java"

# Put the EC2 discovery plugin in logstash home.
ark "cloud-aws-plugin" do
  version       node['logstash']['es-cloud-aws-plugin']['version']
  url           node['logstash']['es-cloud-aws-plugin']['download_url']
  prefix_home   node['logstash']['instance']['default']['home']
  owner         node['logstash']['user']
  group         node['logstash']['group']
  action        :install
end

# Create an ES conf file in the logstash working directory
template "#{node['logstash']['instance']['default']['home']}/elasticsearch.yml" do
  source    "logstash-elasticsearch.yml.erb"
  mode      0644
  owner     node['logstash']['user']
  group     node['logstash']['group']
  #notifies  :restart, "service[server]"
end