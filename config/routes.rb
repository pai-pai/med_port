MedPort::Application.routes.draw do
    devise_for :users

    root :to => "pages#home"

    resources :categories

    resources :healthcats, :path => "/zabolevaniya/categories"
    match '/zabolevaniya/categories(/:parent_healthcat_id-:parent_translated_name)/:id-:translated_name' => 'healthcats#show', :as => :show

    resources :users, :only => [:show, :index]

    match "home" => "pages#home", :as => "home"
    namespace :admin do
        match "home" => "pages#home", :as => "home"
    end
end
