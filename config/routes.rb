Rails.application.routes.draw do

  resources :lists do
    post :complete
    delete :all_del_completed
  end
  devise_for :users
  root "home#index"
end
