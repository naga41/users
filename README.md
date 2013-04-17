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

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: naga41
