Rails.application.routes.draw do
  root to: 'top#index'
  resources :results
  resources :games do
    resources :pitchers
    resources :results
  end
  resources :pitchers
end
