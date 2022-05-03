Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  scope module: :api do
    scope module: :v1 do
      namespace :blog do
        resource :users, only: [:create, :show]
      end
    end
  end
end
