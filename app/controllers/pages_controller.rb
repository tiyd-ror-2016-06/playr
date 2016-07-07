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

  def wat
    params[:count].to_i.times do
      voice = `say -v '?' | grep en_`.split("\n").sample.split.first
      word  = params[:word] || Word.offset(rand 1 .. Word.count).first.word
      CreepyJob.perform_later voice, word
    end
    render text: "Okay ..."
  end
end
