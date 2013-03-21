name 'directory'

default_attributes 'user'              => 'directory',
                   'group'             => 'directory',
                   'ruby'              => '1.9.3-p374',
                   'project_fqdn'      => 'directory.theodi.org',
                   'git_project'       => 'member-directory',
                   'migration_command' => 'bundle exec rake db:migrate:with_data'

override_attributes 'envbuilder'  => {
    'base_dir' => '/var/www/directory.theodi.org/shared/config',
    'owner'    => 'directory',
    'group'    => 'directory'
},
                    'chef_client' => {
                        'interval' => 300,
                         'splay'     => 30
                    }


run_list "role[base]",
         "recipe[build-essential]",
         "recipe[imagemagick]",
         "recipe[nginx]",
         "recipe[odi-users]",
         "recipe[odi-rvm]",
         "recipe[odi-xml]",
         "recipe[odi-nginx]",
         "recipe[xslt]",
         "recipe[libcurl]",
         "recipe[nodejs]",
         "recipe[mysql::client]",
         "recipe[sqlite::dev]",
         "recipe[redisio::install]",
         "recipe[redisio::enable]",
         "recipe[envbuilder]",
         "recipe[odi-deployment]"