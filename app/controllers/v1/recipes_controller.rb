class V1::RecipesController < ApplicationController
  def index
    recipes = Recipe.all
    render json: recipes.as_json
  end

  def show
    recipe_id = params["id"]
    recipe = Recipe.find_by(id: recipe_id)
    render json: recipe.as_json
  end

  def create
    recipe = Recipe.new(
      title: "Mud Pie",
      chef: "Peter Jang",
      ingredients: "Mud",
      directions: "Bake the mud. Enjoy!"
    )
    recipe.save
    render json: recipe.as_json
  end
end
