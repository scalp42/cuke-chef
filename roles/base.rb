name 'base'

run_list "recipe[apt]",
         "recipe[chef-client]",
         "recipe[chef-client::config]",
         "recipe[git]"