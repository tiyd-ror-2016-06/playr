class PagesController < ApplicationController
  def home
    @games = [Hangman, Battleship]
  end

  def start
    g = Hangman.create!
    redirect_to games_hangman_path(g)
  end
end
