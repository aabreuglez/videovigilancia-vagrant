include_recipe "ubuntu-desktop"

## Qt requires the OpenGL development files

package "libgl1-mesa-dev" do
  action :install
end

## Download the Qt Creator installer

package "wget" do
  action :install
end

bash "download-installers" do
  user "vagrant"
  group "vagrant"
  environment ({'HOME' => '/home/vagrant', 'USER' => 'vagrant'})
  code <<-EOF
    set -e
    cd "$(xdg-user-dir DESKTOP)"
    wget --recursive --no-parent --no-directories \
         --accept 'qt-unified-linux-x64-online.run' \
           '#{node[:qt][:online_installers_url]}/'
    chmod 0755 qt-unified-linux-x64-online.run
  EOF
end
