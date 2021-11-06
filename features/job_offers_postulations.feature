Feature: Job offer postulations counter
  In order to know the amount of postulations
  As a job offerer
  I want to be able too see it

  Background:
    Given I am logged in as job offerer
    And I have "Programmer vacancy" offer in my offers list
    And I activate it


  Scenario: JP1 - No postulations
    Given there are 0 postulations
    When I see my offers list
    Then I should see "No postulants" postulations in the "Programmer vacancy" offer

  @wip
  Scenario: JP2 - 1 postulation
    Given there are 5 postulations
    When I see my offers list
    Then I should see 5 postulations in the "Programmer vacancy" offer
