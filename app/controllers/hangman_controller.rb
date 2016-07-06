class HangmanController < ApplicationController
  skip_before_action :authenticate_user!, only: [:slack]

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

  def slack
    user_from_slack = User.first

    if params[:text] == "start"
      game = Hangman.start user_from_slack
    else
      letter = params[:text]
      game   = Hangman.where(player: user_from_slack).last
      game.record_guess letter
    end

    board = game.board.join(" ")
    render text: "`#{board}`"
  end
end
