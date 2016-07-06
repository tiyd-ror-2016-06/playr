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
    handler = SlackCommandHandler.new(
      slack_id:   params[:user_id],
      slack_name: params[:user_name],
      message:    params[:text]
    )
    if handler.allowed? params[:token]
      render text: handler.response
    else
      render text: "No!", status: 401
    end
  end
end
