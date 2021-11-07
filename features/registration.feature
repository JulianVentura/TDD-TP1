Feature: Registration
  In order to publish offers
  I want to register in Job Vacancy

  Scenario: P1 - Valid password
    Given I am not registered
    When I register with email "anemail@mail.com" and password "StrongPa$sw0rd"
    Then I should be able to login with email "anemail@mail.com" and password "StrongPa$sw0rd"

  @wip
  Scenario: P2 - Less than 8 characters
    Given I am not registered
    When I register with email "anemail@mail.com" and password "$tr0nG"
    Then I should see error "password must contain at least 8 characters"

  @wip
  Scenario: P3 - No symbol
    Given I am not registered
    When I register with email "anemail@mail.com" and password "str0nGpassword"
    Then I should see error "password must contain at least 1 of these special characters $ ) _"

  @wip
  Scenario: P4 - No number
    Given I am not registered
    When I register with email "anemail@mail.com" and password "$tronGpassword"
    Then I should see error "password must contain at least 1 number"

  @wip
  Scenario: P5 - No uppercase
    Given I am not registered
    When I register with email "anemail@mail.com" and password "$tr0ngpassword"
    Then I should see error "password must contain at least 1 uppercase character"
