Feature: CV Attachment
  In order to get a job
  As a candidate
  I want to attach my CV to the job offer

  Background:
    Given only a "Web Programmer" offer exists in the offers list

  Scenario: CV1 - Valid link
    Given I access the offers list page
    When I apply adding "www.linkedin.com/mylinkedin" as cv link
    Then I should receive a mail with offerer info

  Scenario: CV2 - Invalid link
    Given I access the offers list page
    When I apply adding "linkedin.com/mylinkedin" as cv link
    Then I should see error "CV should be a link (example www.linkedin.com/mycv)"

  Scenario: CV3 - No CV
    Given I access the offers list page
    When I apply adding "" as cv link
    Then I should receive a mail with offerer info

  Scenario: CV4 - Mail remains on error
    Given I access the offers list page
    When I apply adding "linkedin.com/mylinkedin" as cv link and "mail@mail.com" as email
    Then the "job_application_form[applicant_email]" field should contain "mail@mail.com"
