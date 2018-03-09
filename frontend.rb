require "unirest"

system "clear"
puts "Welcome to Recipe app! Choose an option:"
puts "[1] See all recipes"
puts "[2] See one recipe"
puts "[3] Create a recipe"

input_option = gets.chomp
if input_option == "1"
  response = Unirest.get("http://localhost:3000/v1/recipes")
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
end