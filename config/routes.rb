Trvrgur::Application.routes.draw do
  resource :session, :only => [:create, :destroy, :new]
  resources :users, :except => [:index]
  resources :images

  root :to => "images#index"
end
