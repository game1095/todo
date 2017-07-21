Rails.application.routes.draw do

  # get 'abouts/index'
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
