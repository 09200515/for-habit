Rails.application.routes.draw do
  devise_for :users,
    controllers: { registrations: 'registrations' }

  root to: "records#index"

  resources :objectives do
    collection do
      get 'step1'
      get 'step2'
      get 'step3'
    end
    resources :records, only: [:index, :new, :create, :show] do
      collection do
        get 'time'
        get 'time_save'
      end
    end
  end

  resources :users, only: [:show]
  
end
