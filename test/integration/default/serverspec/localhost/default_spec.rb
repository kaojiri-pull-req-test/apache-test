require 'serverspec'
include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
	c.before :all do 
		c.os = backend(Serverspec::Commands::Base).check_os
	end
	c.path = "/sbin:/user/sbin"
end

describe package('httpd') do
	it { should be_installed }
end

describe service('httpd') do
	it { should be_enabled }
	it { should be_running }
end

describe file("/etc/httpd/conf/httpd.conf") do
	it { should be_file }
	it { should be_mode 644 }
end

