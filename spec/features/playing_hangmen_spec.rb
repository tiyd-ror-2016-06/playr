require 'rails_helper'

feature "Playing hangman", type: :feature do
  def make_user
    User.create! email: "user@example.com", password: "hunter2"
  end

  def log_in user=nil
    user ||= make_user

    visit "/"
    click_on "Sign In"
    within "#new_user" do
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_on "Log in"
    end
  end

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
    Hangman.word_list = ["aardwolf"]

    log_in

    visit "/"
    select "Hangman", from: "select_game"
    click_on "Play"

    expect(page).to have_content "New game created"
    expect(page).to have_content "Play Hangman!"

    # Word is `aardwolf` ...
    expect(page).to have_content "6 lives left"

    fill_in "guess", with: "a"
    click_on "Guess"

    expect(page.find(".board")).to have_content "a a _ _"
    expect(page).to have_content "6 lives left"

    fill_in "guess", with: "b"
    click_on "Guess"
    expect(page).to have_content "5 lives left"
  end
end
