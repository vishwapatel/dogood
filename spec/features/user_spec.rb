require 'spec_helper'

describe 'Adding a user' do
	it 'requires a name' do
		visit new_user_registration_path
		fill_in "Email", with: "john@gmail.com"

		click_button "Sign up"

		error_message = "Name can't be blank"
		page.should have_content(error_message)

	end
end