Listabeta::Application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions",
                                    registrations: "users/registrations" }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'pages#home'

  get 'dashboard',        to: 'pages#dashboard',  as: :dashboard
  get 'sobre',            to: 'pages#about',      as: :about
  get 'mercados/(:tag)',  to: 'pages#markets',    as: :markets

  resources :startups do
    get 'autocomplete_startup_markets', on: :collection
    put 'submit', to: 'startups#submit', as: :submit
  end
end
