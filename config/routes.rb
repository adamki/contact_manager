Rails.application.routes.draw do

  root 'people#index'

  resources :phone_numbers

  resources :people
end
