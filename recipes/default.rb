#
# Cookbook Name:: webserver
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# from https://learn.chef.io/controls-for-compliance/windows/create-a-basic-audit-control/

# Install IIS
powershell_script 'Install IIS' do
  code 'Add-WindowsFeature Web-Server'
  guard_interpreter :powershell_script
  not_if '(Get-WindowsFeature -Name Web-Server).Installed'
end

# Enable and start W3SVC
service 'W3SVC' do
  action [:enable, :start]
end

# Create the pages directory under the Web application root directory.
directory 'c:\inetpub\wwwroot\pages'

# Add files to the site
%w(Default.htm pages\Page1.htm pages\Page2.htm).each do |web_file|
  file File.join('c:\inetpub\wwwroot', web_file) do
    content "<html>This is #{web_file}.</html>"
  end
end
