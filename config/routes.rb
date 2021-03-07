Rails.application.routes.draw do
  devise_for :users
  root to: "records#index"

  resources :objectives, only: [:index, :new, :create] do
    collection do
      get 'step1'
      get 'step2'
      get 'step3'
    end
    resources :records, only: [:index, :new, :create] do
      collection do
        get 'time'
      end
    end
  end

  resources :users, only: [:show]
  
end
