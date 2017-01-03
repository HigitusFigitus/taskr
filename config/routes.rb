Rails.application.routes.draw do

  devise_for :users

  resources :tasks do
    member do
      put :update_attributes
    end
  end

  root 'pages#home'

  get 'about' => 'pages#about'
end
