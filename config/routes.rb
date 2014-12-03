Rails.application.routes.draw do
  root to: 'top#index'
  resources :results
  resources :games do
    patch :update_reflection, on: :member
    resources :pitchers
    resources :results
  end
  resources :pitchers
  resource :new_email, only: [ :new, :create ] do
    get :thanks, on: :collection
  end
  resources :users do
    get :edit_image, :thumbnail, :cover, on: :member
    patch :update_image, on: :member
    post :step2, on: :collection
    post :step3, on: :collection
    put :update_ability, on: :member
    resources :characters do
      post :create_and_links, on: :collection
    end
    resources :breaking_ball_user_links do
      post :create_breaking_ball, on: :collection
    end
  end
  resource :session, only: [ :new, :create, :destroy ]
  
  get 'auth/facebook/callback', to: "sessions#callback"
  get "auth/failure", to: "sessions#failure"
end
