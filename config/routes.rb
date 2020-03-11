Rails.application.routes.draw do
  devise_for :users
  resources :posts
  get "/search_post" => "search_post#index"
end
