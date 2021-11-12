HOME_PATH = '/'.freeze

Given('I am not registered') do
  # Do nothing
end

When('I register with email {string} and password {string}') do |email, password|
  visit '/register'
  fill_in('user_form[email]', with: email)
  fill_in('user_form[name]', with: email)
  fill_in('user_form[password]', with: password)
  fill_in('user_form[password_confirmation]', with: password)
  click_button('Create')
end

Then('I should be able to login with email {string} and password {string}') do |email, password|
  visit '/login'
  fill_in('user_form[email]', with: email)
  fill_in('user_form[password]', with: password)
  click_button('Login')
  page.should have_content(email)
  current_path = URI.parse(current_url).path
  current_path.should == HOME_PATH
end
