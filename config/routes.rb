Trvrgur::Application.routes.draw do
  resource :session, :only => [:create, :destroy, :new]
  resources :users, :except => [:index]
  resources :images
  resources :albums

  root :to => "albums#index"
end
