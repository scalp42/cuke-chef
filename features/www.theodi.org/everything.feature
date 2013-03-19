@theodi-org
Feature: We have a functioning website

  Background:
    Given I have a server called "theodi-org"
    And "theodi-org" is running "ubuntu" "precise"
    And "theodi-org" should be persistent
    And "theodi-org" has been provisioned

    And all of the cookbooks in "./cookbooks" have been uploaded
    And all of the cookbooks in "./site-cookbooks" have been uploaded

    And the "chef-client::service" recipe has been added to the "theodi-org" run list
    And the "apache2::mod_php5" recipe has been added to the "theodi-org" run list
    And the "apache2::mod_rewrite" recipe has been added to the "theodi-org" run list
    And the "php::module_gd" recipe has been added to the "theodi-org" run list
    And the "php::module_mysql" recipe has been added to the "theodi-org" run list
    And the "git" recipe has been added to the "theodi-org" run list

    And the chef-client has been run on "theodi-org"

    When I ssh to "theodi-org" with the following credentials:
      | username | keyfile |
      | $lxc$    | $lxc$   |

  Scenario: Can connect to the provisioned server via SSH authentication
    When I run "hostname"
    Then I should see "theodi-org" in the output

  Scenario: Apache2 is installed
    * package "apache2" should be installed

  Scenario: apache modules are enabled
    * "mod_php5" should be enabled
    * "mod_rewrite" should be enabled

  Scenario: git should be installed
    * package "git" should be installed

  Scenario: php5-gd is installed
    * package "php5-gd" should be installed

  Scenario: php5-mysql is installed
    * package "php5-mysql" should be installed

#  Scenario: code is deployed
#    * directory "/var/www/theodi.org" should exist
#    * directory "/var/www/theodi.org" should be owned by "www-data:www-data"
#    * directory "/var/www/theodi.org/sites/all/modules/course_list" should exist
#
#  Scenario: memcached is installed
#    * package "php5-memcached" should be installed
#
#  Scenario: postfix is installed
#    * package "postfix" is installed
#
#  Scenario: vhost exists
#    * file "/etc/apache2/sites-available/theodi.org" should exist
#    * file "/etc/apache2/sites-available/theodi.org" should contain
#    """
#<VirtualHost *:80>
#  ServerName theodi.org
#  ServerAlias www.theodi.org
#  DocumentRoot /var/www/theodi.org
#  <Directory /var/www/theodi.org>
#    Options +FollowSymLinks
#    AllowOverride All
#    Order allow,deny
#    Allow from all
#  </Directory>
#  ErrorLog /var/log/apache2/theodi.org.err
#  CustomLog /var/log/apache2/theodi.org.log Combined
#</VirtualHost>
#    """
#    * symlink "/etc/apache2/sites-enabled/theodi.org" should exist
#
# Scenario: settings file has correct stuff
#   When I run "cat /var/www/theodi.org/sites/default/settings.php"
#   Then I should see "$base_url = 'http://theodi.org';" in the output
#   And I should see "'database' => 'theodi_org'" in the output
#   And I should see "'username' => 'theodi_org'" in the output
#
# Scenario: drush is installed
#   When I run "drush -v | grep version"
#   Then I should see "5." in the output