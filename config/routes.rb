MedPort::Application.routes.draw do
    root :to => "pages#home"

    devise_for :users

    resources :users, :only => [:show, :index]
    resources :categories
    resources :healthcats, :path => "/zabolevaniya/categories"
    resources :bodyparts
    resources :articles
    resources :tags

    match "home" => "pages#home", :as => "home"
    match '/zabolevaniya/categories(/:parent_healthcat_id-:parent_translated_name)/:id-:translated_name' => 'healthcats#show', :as => :show

    namespace :admin do
        match "home" => "pages#home", :as => "home"
        match "canvas" => "pages#canvas", :as => "canvas" #remove this path (canvas test page)

        resources :healthcats, :path => "zabolevaniya/categories" do
            collection do
                delete 'destroy'
                post 'move'
            end
        end
        resources :bodyparts do
            collection do
                delete 'destroy'
            end
        end
        resources :articles do
            collection do
                delete 'destroy'
            end
        end
        resources :tags do
            collection do
                delete 'destroy'
            end
        end
    end
end
