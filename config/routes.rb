Rails.application.routes.draw do
  devise_for :users

  post "/start" => "pages#start", as: :start_game

  resource :games, only: [] do
    resources :hangman, except: [:destroy]
  end

  root to: "pages#home"
end
