#
# Cookbook Name:: users
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# User add or delete
data_bag_item('users','login_account')['users'].each do |user|
  # if roles are specified in user, check if user is target
  if user.has_key? "roles"
    if (user["roles"] & node["roles"]).empty?
      next
    end
  end

  # delete if active flag is false
  user_act = user["active"] ? "create":"remove"

  # make text of home directory
  home_dir = "/home/" + user["name"]
  log user["password"]

  # make hashed password
  if user["password"]
    chef_gem "unix-crypt"
    require "unix_crypt"

    SALT_CHARSET = "./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    salt = (0..7).inject(""){|s,i| s << SALT_CHARSET[rand 64]}
    hashed_pass = UnixCrypt::SHA512.build(user["password"], salt)
  end

  # add user
  user user["name"] do
    comment  user["comment"]
    shell    user["shell"]
    home     user["home"]
    password hashed_pass
    supports :manage_home => true
    action   user_act
  end

  # .ssh directory
  ssh_dir         = home_dir + "/.ssh"
  # authorized_keys
  authorized_keys = ssh_dir + "/authorized_keys"

  # make .ssh directory
  if user["active"]
    directory ssh_dir do
      owner user["name"]
      group user["name"]
      mode  0700
    end

    # make authorized_key
    if user["authorized_keys"]
      file authorized_keys do
        owner   user["name"]
        mode    0600
        content user["authorized_keys"]
      end
    end
  end

  # add user to sudo enable group
  if user["sudo"]
    case node['platform']
    when "ubuntu"
      group "sudo" do
        action  :modify
        members [ user["name"] ]
        append  true
      end
    when "centos", "redhat"
      group "wheel" do
        action  :modify
        members [ user["name"] ]
        append  true
      end
    end
  end
end
