Rails.application.routes.draw do
  devise_for :users
  resources :posts
  mount API => '/'
  get "/search_post" => "search_post#index"
end
