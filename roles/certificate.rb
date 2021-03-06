name 'certificate'

default_attributes 'user'              => 'certificate',
                   'group'             => 'certificate',
                   'ruby'              => '1.9.3-p392',
                   'project_fqdn'      => 'certificate.theodi.org',
                   'mysql_db'          => 'certificate',
                   'git_project'       => 'open-data-certificate',
                   'migration_command' => 'bundle exec rake db:migrate ; bundle exec rake surveyor:build_changed_surveys',
                   'chef_client'       => {
                       'cron' => {
                           'use_cron_d' => true,
                           'hour'       => "*",
                           'minute'     => "*/5",
                           'log_file'   => "/var/log/chef/cron.log"
                       }
                   }

override_attributes 'envbuilder'  => {
    'base_dir' => '/var/www/certificate.theodi.org/shared/config',
    'owner'    => 'certificate',
    'group'    => 'certificate'
},
                    'chef_client' => {
                        'interval' => 300,
                        'splay'    => 30
                    }


run_list "role[base]",
         "recipe[chef-client::cron]",
         "recipe[build-essential]",
         "recipe[nginx]",
         "recipe[odi-users]",
         "recipe[odi-rvm]",
         "recipe[odi-xml]",
         "recipe[odi-nginx]",
         "recipe[xslt]",
         "recipe[libcurl]",
         "recipe[nodejs::install_from_package]",
         "recipe[mysql::client]",
         "recipe[sqlite::dev]",
         "recipe[envbuilder]",
         "recipe[odi-deployment]"