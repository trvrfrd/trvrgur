Trvrgur::Application.routes.draw do
  resource :session, :only => [:create, :destroy, :new]
  resources :users, :except => [:index]
  resources :images #get rid of some of these: things happen on album level
  resources :albums do
    post "upvote", :on => :member
    post "downvote", :on => :member
    post "favorite", :on => :member
    resources :comments, :only => [:index]
  end
  resources :comments, :except => [:index, :new] do
    post "upvote", :on => :member
    post "downvote", :on => :member
  end

  root :to => "albums#index"
end
