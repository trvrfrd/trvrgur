Trvrgur::Application.routes.draw do
  resource :session, :only => [:create, :destroy, :new]
  resources :users, :except => [:index]
  resources :images #get rid of some of these: things happen on album level
  resources :albums do
    get "upvote", :on => :member
    get "downvote", :on => :member
    get "favorite", :on => :member
  end
  resources :comments, :except => [:index, :new] do
    get "upvote", :on => :member
    get "downvote", :on => :member
  end

  root :to => "albums#index"
end
