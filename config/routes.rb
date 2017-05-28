Rails.application.routes.draw do
  devise_for :users
  resources :posts do
  	member do
      put "like", to: "posts#like"
    end
    resources :comments do
      member do
        put "like", to: "comments#like"
      end
    end
  end
  root to: "home#index"
end
