Trvrgur::Application.routes.draw do
  resource :session, :only => [:create, :destroy, :new]
  resources :users
end
