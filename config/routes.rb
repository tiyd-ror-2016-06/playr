Rails.application.routes.draw do
  devise_for :users

  post "/start" => "pages#start", as: :start_game
  post "/slack/hangman" => "hangman#slack"

  resource :games, only: [] do
    resources :hangman, except: [:destroy]
  end

  root to: "pages#home"
end
