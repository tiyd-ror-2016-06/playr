require 'rails_helper'

describe SlackCommandHandler do
  it "can start a new game" do
    handler = SlackCommandHandler.new(
      slack_id:   "1",
      slack_name: "me",
      message:    "start"
    )

    r = handler.response

    expect(Hangman.count).to eq 1
    expect(User.first.slack_id).to eq "1"
    expect(r).to include "_"
    expect(r).to include "Lives left: 6"
  end

  it "can check the environment token" do
    handler = SlackCommandHandler.new(
      slack_id:   "1",
      slack_name: "me",
      message:    "start"
    )

    expect(handler.allowed? ENV["SLACK_SLASH_TOKEN"]).to eq true
    expect(handler.allowed? "asdfxsfjnwkjwnrsd").to eq false
  end
end
