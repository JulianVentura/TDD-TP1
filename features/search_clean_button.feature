Feature: Clean search
  In order to get a job
  As a candidate
  I want to clean search results

  Background:
    Given a "Web Dev" offer with location "CABA" and description "Ruby programmer" exists in the offers list
    And a "C Developer" offer with location "CABA" and description "C" exists in the offers list
    And I access the offers list page
    And I fill search field with "Web"
    And I click search button

  Scenario: C1 - Clean search
    When I click clean button
    Then I should see "Web Dev" in offers list
    Then I should see "C Developer" in offers list
