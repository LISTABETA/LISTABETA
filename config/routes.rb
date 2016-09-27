Listabeta::Application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  devise_for :admin_users
  ActiveAdmin.routes(self)

  root 'pages#home'

  get 'dashboard', to: 'pages#dashboard', as: :dashboard
  get 'mercados/(:tag)', to: 'pages#markets', as: :markets

  resources :startups
end
