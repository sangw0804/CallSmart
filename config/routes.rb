Rails.application.routes.draw do

  devise_for :users

  get 'home/show' => 'home#show' , as: "show"

  get 'home/get_list' => 'home#get_list', as: "get_list"

  post 'home/get_list' => 'home#get_list', as: "post_list"

  get 'home/paginate_list/:page' => 'home#paginate_list', as: "paginate_list"

  root 'home#index'
end
