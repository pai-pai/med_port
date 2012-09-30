MedPort::Application.routes.draw do
    devise_for :users

    root :to => "pages#home"

    resources :categories
    resources :healthcats
    resources :users, :only => [:show, :index]

    match "home" => "pages#home", :as => "home"

    match "zabolevaniya/categories" => "healthcats#index", :as => "sprav_health_cats"
end
