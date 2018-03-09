Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :v1 do
    get "/recipes" => "recipes#index"
    post "/recipes" => "recipes#create"
    get "/recipes/:id" => "recipes#show"
  end
end
