Rails.application.routes.draw do

authenticated :user do
  root 'lists#index', as: :authenticated_root
end
  resources :projects
  resources :abouts
  resources :lists do
    post :complete
    delete :del_completed
    delete :all_del_completed
    post :completed_restore
  end
  devise_for :users
  root "home#index"
end
