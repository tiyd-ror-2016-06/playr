class HangmanController < ApplicationController
  def show
    @game = Hangman.where(player: current_user).find params[:id]
  end

  def update
    @game = Hangman.where(player: current_user).find params[:id]
    @game.record_guess params[:guess]

    respond_to do |f|
      f.html { redirect_to :back }
      f.json { render :show }
    end
  end
end
