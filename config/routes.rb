Rails.application.routes.draw do

authenticated :user do
  root 'projects#index', as: :authenticated_root
end
  resources :projects do
      resources :lists do
        post :complete
        delete :del_completed
        delete :all_del_completed
        post :completed_restore
      end
  end
  resources :abouts
  # resources :lists do
  #   post :complete
  #   delete :del_completed
  #   delete :all_del_completed
  #   post :completed_restore
  # end
  devise_for :users
  root "home#index"
end
