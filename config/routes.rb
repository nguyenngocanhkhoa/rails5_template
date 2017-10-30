Rails.application.routes.draw do
  devise_for :users

  match '/contacts', to: 'contacts#new', via: 'get'
  resources :contacts, only: [:new, :create]
  authenticate :user, lambda { |user| user.admin? } do
    mount Blazer::Engine, at: "monitoring"
  end

  mount RailsDb::Engine => '/db', :as => 'db'
  root 'home#import'
  get '/import', to: 'home#import'
  post 'export_data', to: 'home#export_data'
end
