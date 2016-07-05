class HangmanController < ApplicationController
  def show
    @game = Hangman.where(player: current_user).find params[:id]
  end

  def update
    g = Hangman.where(player: current_user).find params[:id]
    g.record_guess params[:guess]
    redirect_to :back
  end
end
