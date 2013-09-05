Trvrgur::Application.routes.draw do
  resource :session, :only => [:create, :destroy, :new]
  resources :users, :except => [:index]
  resources :images
  resources :albums
  resources :comments, :except => [:index, :new]

  root :to => "albums#index"
end
