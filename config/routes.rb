LinoEscalera::Application.routes.draw do
  root :to => "front/collections#show", :defaults => { :id => Item::COLLECTIONS[:home] }

  namespace :front do
    resource :about, :only => [:show]
    resources :items, :only => [:show]
    resources :collections, :only => [:show]
  end

  namespace :admin do
    root :to => "items#index"

    resource :about, :only => [:edit, :update]
    resources :items, :only => [:index, :new, :edit, :update, :create, :destroy] do
      post :reorder, :on => :collection
      resources :pics, :only => [:index, :create, :destroy] do
        post :reorder, :on => :collection
      end
    end
  end
end
