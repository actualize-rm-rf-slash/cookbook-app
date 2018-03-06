class RecipesController < ApplicationController
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
