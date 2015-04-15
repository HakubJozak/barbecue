Barbecue::Engine.routes.draw do
  resource :upload, only: [:show]
  resources :users
  resources :tags
  resources :media_items
  resources :media_placements, except: [:create, :edit,:new] do
    post 'insert_at', on: :member
  end
end
