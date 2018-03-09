class V1::RecipesController < ApplicationController
  def index
    recipes = Recipe.all
    render json: recipes.as_json
  end

  def one_recipe_method
    recipe = Recipe.first
    render json: {
      title: recipe.title,
      chef: recipe.chef,
      ingredients: recipe.ingredients,
      directions: recipe.directions
    }
  end
end
