MedPort::Application.routes.draw do
    root :to => "pages#home"

    resources :categories
    resources :healthcats
end
