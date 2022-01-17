# frozen_string_literal: true

Rails.application.routes.draw do
  resources :meetings, only: [:create, :show, :update, :new, :edit, :destroy] do
    resources :meeting_members, only: [:create, :destroy]
  end
  get '/my_meetings', to: 'meetings#index'

  match '/auth/:provider/callback', to: 'sessions#create', via: %i[get post]
  get '/sign_out', to: 'sessions#destroy'

  root 'home#index'
end
