Trvrgur::Application.routes.draw do
  resource :session, :only => [:create, :destroy, :new]
  resources :users, :except => [:index]
  resources :images #get rid of some of these: things happen on album level
  resources :albums
  resources :comments, :except => [:index, :new]

  root :to => "albums#index"
end
