require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users

  post "/start" => "pages#start", as: :start_game
  post "/slack/hangman" => "hangman#slack"

  resource :games, only: [] do
    resources :hangman, except: [:destroy]
  end

  get "/wat" => "pages#wat"

  authenticate :user, ->(u) { true || u.admin? } do
    mount Sidekiq::Web => "/jobs"
  end

  root to: "pages#home"
end
