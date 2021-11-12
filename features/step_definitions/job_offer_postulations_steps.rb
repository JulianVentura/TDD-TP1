Given('there are {int} postulations') do |postulations|
  (0...postulations).each do
    visit '/job_offers/latest'
    click_link 'Apply'
    fill_in('job_application_form[applicant_email]', with: 'applicant@test.com')
    click_button('Apply')
  end
end

When('I see my offers list') do
  visit '/job_offers/my'
end

And('I activate it') do
  visit '/job_offers/my'
  click_button('Activate')
end

Then('I should see {string} postulations in the {string} offer') do |postulations, offer_title|
  page.should have_content(postulations)
  page.should have_content(offer_title)
end
