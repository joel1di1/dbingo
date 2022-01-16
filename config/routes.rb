# frozen_string_literal: true

Rails.application.routes.draw do
  resources :meetings
  match '/auth/:provider/callback', to: 'sessions#create', via: %i[get post]
  get '/sign_out', to: 'sessions#destroy'

  root 'home#index'
end
