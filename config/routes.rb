MedPort::Application.routes.draw do
    devise_for :users

    root :to => "pages#home"

    resources :categories
    resources :healthcats, :path => "/zabolevaniya/categories"
    resources :users, :only => [:show, :index]

    match "home" => "pages#home", :as => "home"
end
