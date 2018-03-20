require "unirest"

# Login and set jwt as part of Unirest requests
response = Unirest.post(
  "http://localhost:3000/user_token",
  parameters: {
    auth: {
      email: "peter@email.com",
      password: "password"
    }
  }
)
jwt = response.body["jwt"]
Unirest.default_header("Authorization", "Bearer #{jwt}")


system "clear"
puts "Your jwt is #{jwt}"
puts "Welcome to Recipe app! Choose an option:"
puts "[1] See all recipes"
puts "  [1.1] Search recipes that have the letter s"
puts "[2] See one recipe"
puts "[3] Create a recipe"
puts "[4] Update a recipe"
puts "[5] Delete a recipe"
puts "[signup] Signup (create a user)"

input_option = gets.chomp
if input_option == "1"
  response = Unirest.get("http://localhost:3000/v1/recipes")
  recipes = response.body
  puts JSON.pretty_generate(recipes)
elsif input_option == "1.1"
  response = Unirest.get("http://localhost:3000/v1/recipes?input_search_terms=s")
  recipes = response.body
  puts JSON.pretty_generate(recipes)
elsif input_option == "2"
  print "Enter a recipe id: "
  recipe_id = gets.chomp
  response = Unirest.get("http://localhost:3000/v1/recipes/#{recipe_id}")
  recipe = response.body
  puts JSON.pretty_generate(recipe)
elsif input_option == "3"
  params = {}
  print "Title: "
  params["input_title"] = gets.chomp
  print "Chef: "
  params["input_chef"] = gets.chomp
  print "Ingredients: "
  params["input_ingredients"] = gets.chomp
  print "Directions: "
  params["input_directions"] = gets.chomp
  response = Unirest.post("http://localhost:3000/v1/recipes", parameters: params)
  recipe = response.body
  puts JSON.pretty_generate(recipe)
elsif input_option == "4"
  print "Enter a recipe id: "
  recipe_id = gets.chomp
  response = Unirest.get("http://localhost:3000/v1/recipes/#{recipe_id}")
  recipe = response.body
  params = {}
  print "Title (#{recipe["title"]}): "
  params["input_title"] = gets.chomp
  print "Chef (#{recipe["chef"]}): "
  params["input_chef"] = gets.chomp
  print "Ingredients (#{recipe["ingredients"]}): "
  params["input_ingredients"] = gets.chomp
  print "Directions (#{recipe["directions"]}): "
  params["input_directions"] = gets.chomp
  params.delete_if { |_key, value| value.empty? }
  response = Unirest.patch("http://localhost:3000/v1/recipes/#{recipe_id}", parameters: params)
  recipe = response.body
  puts JSON.pretty_generate(recipe)
elsif input_option == "5"
  print "Enter a recipe id: "
  recipe_id = gets.chomp
  response = Unirest.delete("http://localhost:3000/v1/recipes/#{recipe_id}")
  body = response.body
  puts JSON.pretty_generate(body)
elsif input_option == "signup"
  params = {
    name: "Peter",
    email: "peter@email.com",
    password: "password",
    password_confirmation: "password"
  }
  response = Unirest.post("http://localhost:3000/v1/users", parameters: params)
  p response.body
end
