users Cookbook
==============

This cookbook makes users.

Requirements
------------

#### packages
- gem `unix-crypt` - for making hashed password

Attributes
----------

no attributes.

Usage
-----
#### users::default

Make data_bags "users" and data_bag_item "login_account" like below in your repository.

```json.
{
  "id": "login_account",
  "users":[
    {
      "comment":         "Login User",
      "authorized_keys": "ssh-rsa xxx",
      "name":            "login-user",
      "home":            "/home/login-user",
      "shell":           "/bin/bash",
      "password":        null,
      "sudo":            false,
      "active":          true
    },
    {
      "comment":         "Admin User",
      "authorized_keys": null,
      "name":            "admin",
      "home":            "/home/admin",
      "shell":           "/bin/bash",
      "password":        "YOUR_PASSWORD",
      "sudo":            true,
      "active":          true
    },
    {
      "roles": [
        "web"
      ],
      "comment":         "Web User",
      "authorized_keys": null,
      "name":            "www-user",
      "home":            "/home/www-user",
      "shell":           "/bin/bash",
      "password":        "YOUR_PASSWORD",
      "sudo":            false,
      "active":          true
    }
  ]
}
```

Authors
-------------------
Authors: naga41
