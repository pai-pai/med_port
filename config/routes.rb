MedPort::Application.routes.draw do
    devise_for :users

    root :to => "pages#home"

    resources :categories
    resources :healthcats

    resources :users, :only => [:show, :index]
end
