Rails.application.routes.draw do
  root to: 'top#index'
  get 'internal_server_error', to: 'top#internal_server_error'
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
    get :edit_password, on: :member
    patch :update_password, on: :member
    resources :characters do
      post :create_and_links, on: :collection
    end
    resources :breaking_ball_user_links do
      post :create_breaking_ball, on: :collection
    end
    resources :emails, only: [ :destroy ] do
      get :main, on: :member
    end
    resources :new_emails, only: [ :new, :create ]
  end
  resource :session, only: [ :new, :create, :destroy ]
  resources :passwords, only: [ :new, :create ]
  resources :emails, only: [] do
    post :forgot_send_mail, on: :collection
    get :forgot_password, on: :collection
    get :thanks, on: :collection
    get :add, on: :collection
  end
  resources :schedules, only: [ :index, :show ] do
    get :still, on: :collection
    resources :plan_details do
      post :add_or_delete, on: :member
    end
  end
  resources :posts, except: [ :show ] do
    resources :comments, except: [ :show ] do
      post :create_image, :like_add_or_delete, on: :collection
    end
  end
  resources :comment_images, only: [ :show ]
  resources :votes do
    post :update_count, on: :member
  end
  resources :administrators, only: [ :index, :create ]

  get 'auth/facebook/callback', to: "sessions#callback"
  get "auth/failure", to: "sessions#failure"
end
