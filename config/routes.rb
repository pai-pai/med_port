MedPort::Application.routes.draw do
    match "spravochnik_zabolevaniy" => "pages#sprav_health", :as => "sprav_health"

    root :to => "pages#sprav_health"

    resources :categories
    resources :healthcats
end
