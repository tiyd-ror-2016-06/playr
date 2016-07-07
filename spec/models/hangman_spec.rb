require 'rails_helper'

describe Hangman, type: :model do
  it "can record good guesses" do
    g = Hangman.create! word: "jazz"

    g.record_guess "z"

    expect(g.lives_left).to eq 6
    expect(g.guesses).to include "z"
    expect(g.board).to eq %w(_ _ z z)
  end

  it "can record bad guesses" do
    g = Hangman.create! word: "jazz"

    g.record_guess "b"

    expect(g.lives_left).to eq 5
    expect(g.guesses).to include "b"
    expect(g.board).to eq %w(_ _ _ _)
  end

  it "can record multiple guesses" do
    g = Hangman.create! word: "jazz"

    %w( a b c ).each do |letter|
      g.record_guess letter
    end

    expect(g.letters_guessed).to eq ["a", "b", "c"]
  end

  it "doesn't count off for repeat guesses"
end
