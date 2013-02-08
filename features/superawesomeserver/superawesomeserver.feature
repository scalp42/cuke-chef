@superawesomeserver
Feature: Perform test driven infrastructure with Cucumber-Chef

  In order to learn how to develop test driven infrastructure
  As an infrastructure developer
  I want to better understand how to use Cucumber-Chef

  Background:
    * I have a server called "superawesomeserver"
    * "superawesomeserver" is running "ubuntu" "precise"
    * "superawesomeserver" should be persistent
    * "superawesomeserver" has been provisioned

    * all of the cookbooks in "./cookbooks" have been uploaded
    * all of the cookbooks in "./site-cookbooks" have been uploaded

    * the "chef-client::service" recipe has been added to the "superawesomeserver" run list
    * the chef-client has been run on "superawesomeserver"

    * I ssh to "superawesomeserver" with the following credentials:
      | username | keyfile |
      | $lxc$    | $lxc$   |

  Scenario: Can connect to the provisioned server via SSH authentication
    When I run "hostname"
    Then I should see "superawesomeserver" in the output

  Scenario: Default root shell is bash
    When I run "echo $SHELL"
    Then I should see "bash" in the output

  Scenario: Default gateway and resolver are using Cucumber-Chef Test Lab
    When I run "route -n | grep 'UG'"
    Then I should see "192.168.255.254" in the output

    When I run "cat /etc/resolv.conf"
    Then I should see "192.168.255.254" in the output
    And I should see "8.8.8.8" in the output
    And I should see "8.8.4.4" in the output

  Scenario: Primary interface is configured with my IP address and MAC address
    When I run "ifconfig eth0"
    Then I should see the "IP" of "superawesomeserver" in the output
    And I should see the "MAC" of "superawesomeserver" in the output

  Scenario: Local interface is not configured with my IP address or MAC address
    When I run "ifconfig lo"
    Then I should see "127.0.0.1" in the output
    And I should not see the "IP" of "superawesomeserver" in the output
    And I should not see the "MAC" of "superawesomeserver" in the output

  Scenario: Chef-Client is running as a daemon
    When I run "ps aux | grep [c]hef-client"
    Then I should see "chef-client" in the output
    And I should see "-d" in the output
    And I should see "-i 1800" in the output
    And I should see "-s 20" in the output
