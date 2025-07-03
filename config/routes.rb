Rails.application.routes.draw do
  devise_for :users
  resources :galleries
  resources :articles


  # This line mounts Active Storage routes so image blobs can be served
  # It's required for Active Storage to deliver images
  # Add it **above** root or anywhere inside the block
  # Usually, it looks like this:
  #
  # mount ActiveStorage::Engine => '/rails/active_storage'

  mount ActiveStorage::Engine => "/rails/active_storage"

  root "home#index"
end
