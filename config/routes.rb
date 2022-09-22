Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  scope module: :api do
    scope module: :v1 do
      namespace :blog do
        resource :clients, only: [:create] do
          post :sign_in, on: :collection
        end

        resources :questions, only: [:index, :create, :show] do
          resources :comments, only: [:create, :index]
        end

        resources :purchases, only: [:index, :create]
        get 'smh', to: 'questions#smh'

      end
    end
  end

  scope module: :internal do
    resources :artificial, only: [:index] do
      collection do
        post :speech_to_text
      end
    end
  end
end
