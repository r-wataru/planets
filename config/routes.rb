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
    resources :characters
    resources :breaking_balls
    resources :breaking_ball_user_links
  end
end
