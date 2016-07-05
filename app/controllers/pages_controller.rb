class PagesController < ApplicationController
  def home
    @games = [Hangman, Battleship]
  end

  def start
    # game_class = {
    #   "hangman"    => Hangman,
    #   "battleship" => Battleship
    # }[ params[:game] ]
    game_class = params[:game].capitalize.constantize
    g = game_class.create!

    path_helper = "games_#{params[:game]}_path"
    final_path = send path_helper, 123

    redirect_to final_path, notice: "New game created!"
  end
end
