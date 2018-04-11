/* global axios */

var recipeTemplate = document.querySelector("#recipe-card");
var recipeContainer = document.querySelector(".row");

// IN RUBY: response = Unirest.get("http://localhost:3000/v1/recipes")
axios.get("/v1/recipes").then(function(response) {
  var recipes = response.data;
  console.log(recipes);

  recipes.forEach(function(recipe) {
    var recipeClone = recipeTemplate.content.cloneNode(true);
    recipeClone.querySelector(".card-title").innerText = recipe.title;
    recipeClone.querySelector(".ingredients").innerText = recipe.ingredients;
    recipeClone.querySelector(".directions").innerText = recipe.directions;
    recipeClone.querySelector(".card-img-top").src = recipe.image;
    recipeContainer.appendChild(recipeClone);
  });
});
