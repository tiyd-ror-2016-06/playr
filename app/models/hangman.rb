class Hangman < ActiveRecord::Base
  belongs_to :player, class_name: "User"

  @word_list = ["test", "example", "thing"]

  def self.start user
    word = @word_list.sample
    create! word: word, lives_left: 6, player: user
  end

  def self.word_list= l
    @word_list = l
  end

  def record_guess letter
    unless word.include? letter
      self.lives_left -= 1
    end
    self.guesses += letter
    self.save!
  end

  def board
    word.split("").map do |l|
      guesses.include?(l) ? l : "_"
    end
  end

  def letters_guessed
    guesses.split ""
  end

  def missed_guesses
    letters_guessed - board
  end
end
