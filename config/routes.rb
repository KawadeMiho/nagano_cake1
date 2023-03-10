Rails.application.routes.draw do
  root to:"public/homes#top"
  devise_for :admin, skip: [:registrations, :passwords] ,controllers:{
    sessions: "admin/sessions"
  }
  devise_for :customers,skip: [:passwords],controllers:{
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

get 'customers/my_page' => 'public/customers#show'
patch 'customers/information' => 'public/customers#update'
get 'customers/information/edit' => 'public/customers#edit'
get  '/home/about' => 'public/homes#about',as: "about"
delete  '/cart_items/destroy_all' => 'public/cart_items#destroy_all',as: "destroy_all"
get  'customers/unsubscribe' => 'public/customers#unsubscribe'
patch 'customers/withdraw' => 'public/customers#withdraw'
scope module: :public do
resources :items
resources :cart_items
resources :orders
resources :addresses
post '/confirm' => 'orders#confirm',as: "confirm"
get  '/complete' => 'orders#complete',as: "complete"
end

# get '/items/:id' => 'public/items#show'
# get '/items' => 'public/items#index'


get  '/admin' => 'admin/homes#top'
patch '/admin/customers/:id' => 'admin/customers#update'
namespace  :admin do
resources :items
resources :customers
resources :orders,only:[:show,:update]
resources :genres
resources :order_details
end
end