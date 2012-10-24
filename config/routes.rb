MedPort::Application.routes.draw do
  get "organizations/show"

    root :to => "pages#home"

    devise_for :users

    resources :users, :only => [:show, :index]
    resources :categories
    resources :healthcats, :path => "/zabolevaniya/categories"
    resources :bodyparts
    resources :articles
    resources :tags
    resources :organizations

    match "home" => "pages#home", :as => "home"
    match '/zabolevaniya/categories(/:parent_healthcat_id-:parent_translated_name)/:id-:translated_name' => 'healthcats#show', :as => :show
    match '/zabolevaniya/categories(/:parent_healthcat_id-:parent_translated_name)/:healthcat_id-:healthcat_translated_name/:id-:translated_name' => 'articles#show', :as => :article_show

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
