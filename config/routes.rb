Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :v1 do
    get "/recipes" => "recipes#index"
    get "/one_recipe_url" => "recipes#one_recipe_method"
  end
end
