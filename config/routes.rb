Rails.application.routes.draw do
  root to: "welcome#index"
  get "terms-of-service", to: "welcome#terms_of_service"
  get "privacy-policy", to: "welcome#privacy_policy"
  get "robots", to: "welcome#robots", defaults: { format: "txt" }

  resources :sessions, only: [:create]
  resources :users, only: %i[create show destroy] do
    resource :profile, only: [:show], module: :users
  end
  resources :surveys, only: [], module: :surveys do
    resources :profiles, only: [:index]
    resources :tasks, only: [:index]

    resources :answers, only: [:create]
    resources :questions, only: [] do
      member do
        post :next
        post :back
      end
    end
    resources :approvals, only: [:create]
    resources :issuances, only: [:create]
  end
  resources :tasks, only: [:update]
end
