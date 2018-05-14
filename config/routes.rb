Rails.application.routes.draw do

  root :to =>'accounts#manage'
  get 'accounts/manage'
  post 'accounts/manage'

  post 'accounts/check'

  get 'accounts/create'
  post 'accounts/create'

  get 'accounts/update'
  post 'accounts/update'

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    get '/sign_in' => 'devise/sessions#new'
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => {
   :registrations => 'users/registrations'
  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
