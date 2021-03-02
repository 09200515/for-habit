Rails.application.routes.draw do
  devise_for :users
  root to: "users#show"

  resources :objectives, only: [:new, :create] do
    collection do
      get 'step1'
      get 'step2'
      get 'step3'
    end
  end
  
end
