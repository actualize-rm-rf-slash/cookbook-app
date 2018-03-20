class V1::RecipesController < ApplicationController
  def index
    if current_user
      # recipes = Recipe.all.order(:id => :asc)
      # recipes = only the current users's recipes
      recipes = current_user.recipes.order(:id => :asc)

      search_terms = params["input_search_terms"]
      if search_terms
        recipes = recipes.where("title ILIKE ?", "%#{search_terms}%")
      end

      render json: recipes.as_json
    else
      render json: []
    end
  end

  def create
    recipe = Recipe.new(
      title: params["input_title"],
      chef: params["input_chef"],
      ingredients: params["input_ingredients"],
      directions: params["input_directions"]
    )
    recipe.save
    render json: recipe.as_json
  end

  def show
    recipe_id = params["id"]
    recipe = Recipe.find_by(id: recipe_id)
    render json: recipe.as_json
  end

  def update
    recipe_id = params["id"]
    recipe = Recipe.find_by(id: recipe_id)
    recipe.title = params["input_title"] || recipe.title
    recipe.chef = params["input_chef"] || recipe.chef
    recipe.ingredients = params["input_ingredients"] || recipe.ingredients
    recipe.directions = params["input_directions"] || recipe.directions
    recipe.save
    render json: recipe.as_json
  end

  def destroy
    recipe_id = params["id"]
    recipe = Recipe.find_by(id: recipe_id)
    recipe.destroy
    render json: {message: "Recipe successfully destroyed!"}
  end
end
