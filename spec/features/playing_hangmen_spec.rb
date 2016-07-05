require 'rails_helper'

feature "Playing hangman", type: :feature do
  it "can create a user account" do
    visit "/"
    click_on "Sign Up"

    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "hunter2"
    fill_in "Password confirmation", with: "hunter2"
    click_on "Sign up"

    expect(User.count).to eq 1 # ??
    expect(page).to have_content "You have signed up successfully."
  end

  it "can play hangman" do
    # Signed in
    # On home page
    # Select hangman
    # Click play
    # See board
    # Type in a letter
    # Click check guess
    # See result ...
  end
end
