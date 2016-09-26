Listabeta::Application.routes.draw do
  devise_for :startups, controllers: { registrations: "startups/registrations" }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'pages#home'

  get 'mercados/(:tag)' => 'pages#markets', as: :markets
  get 'dashboard' => 'pages#dashboard', as: :dashboard

  resources :startups
end
