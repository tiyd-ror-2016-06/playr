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
    g = game_class.start current_user

    path_helper = "games_#{params[:game]}_path"
    final_path = send path_helper, g

    respond_to do |f|
      f.html { redirect_to final_path, notice: "New game created!" }
      f.json { render json: { id: g.id } }
    end
  end
end
