Rails.application.routes.draw do
  devise_for :users,
    controllers: { registrations: 'registrations' }

  root to: "records#index"

  resources :objectives, only: [:index, :new, :create, :edit, :update, :destroy] do
    collection do
      get 'step1'
      get 'step2'
      get 'step3'
    end
    resources :records, only: [:index, :new, :create] do
      collection do
        get 'time'
        get 'time_save'
      end
    end
  end

  resources :users, only: [:show]
  
end
