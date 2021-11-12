Given('a {string} offer with location {string} and description {string} exists in the offers list') do |job_title, job_location, job_description|
  @job_offer = JobOffer.new(title: job_title, location: job_location, description: job_description)
  @job_offer.owner = UserRepository.new.first
  @job_offer.is_active = true

  JobOfferRepository.new.save @job_offer
end

Given('I fill search field with {string}') do |search_text|
  fill_in('q', with: search_text)
end

Given('I click search button') do
  click_button('search')
end

When('I click clean button') do
  click_button('clean')
end

Then('I should see {string} in offers list') do |text|
  page.should have_content(text)
end
