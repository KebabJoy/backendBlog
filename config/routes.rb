Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  scope module: :api do
    scope module: :v1 do
      namespace :blog do
        resource :users, only: [:create, :show]
        resources :questions, only: [:index, :create, :show] do
          resources :comments, only: [:create, :index]
        end
      end
    end
  end
end
