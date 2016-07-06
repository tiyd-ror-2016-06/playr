class SlackCommandHandler
  def initialize slack_id:, slack_name:, message:
    @slack_id, @slack_name, @message =
      slack_id, slack_name, message.strip
  end

  def allowed? given_token
    given_token == ENV["SLACK_SLASH_TOKEN"]
  end

  def response
    if @message == "start"
      game = Hangman.start user
    elsif @message == "show"
      game = Hangman.where(player: user).last
    elsif @message.start_with? "solve"
      solution = @message.split(" ").last
      game = Hangman.where(player: user).last
      if game.word == solution
        return "You got it!"
      else
        return "Nope, that wasn't it"
      end
    else
      game = Hangman.where(player: user).last
      game.record_guess @message
    end

    format_board game
  end

  def user
    @user ||= User.where(slack_id: @slack_id).first_or_create! do |u|
      u.email    = "#{@slack_name}+slack@example.com"
      u.password = SecureRandom.hex 32
      u.slack_id = @slack_id
    end
  end

  private

  def format_board game
    board = game.board.join(" ")
    "```
#{board}
Lives left: #{game.lives_left}
```"
  end
end
