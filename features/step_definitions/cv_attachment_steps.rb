When('I apply adding {string} as cv link') do |url|
  click_link 'Apply'
  fill_in('job_application_form[applicant_email]', with: 'applicant@test.com')
  fill_in('job_application_form[cv_url]', with: url)
  click_button('Apply')
end
