Rails.application.routes.draw do
  root to: 'top#index'
  resources :results
  resources :games do
    patch :update_reflection, on: :member
    resources :pitchers
    resources :results
  end
  resources :pitchers
  resources :users do
    put :update_ability, on: :member
    resources :characters do
      post :create_and_links, on: :collection
    end
    resources :breaking_ball_user_links do
      post :create_breaking_ball, on: :collection
    end
  end
end
