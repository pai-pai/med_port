MedPort::Application.routes.draw do
  get "organizations/show"

    root :to => "pages#home"

    devise_for :users

    resources :users, :only => [ :show, :index ]
    resources :categories
    resources :healthcats do
        resources :healthcats, :path => "/subcats" do
            resources :articles, :only => [ :show, :index ]
        end
    end
    resources :articles
    resources :bodyparts
    resources :tags
    resources :organizations

    match "home" => "pages#home", :as => "home"

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
        resources :organizations do
            collection do
                delete 'destroy'
            end
        end
    end
end
