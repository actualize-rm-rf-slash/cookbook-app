/* global Vue, VueRouter, axios */

var HomePage = {
  template: "#home-page",
  data: function() {
    return {
      message: "Welcome to Vue.js!",
      recipes: [],
      // anythingFilter: "",
      titleFilter: "",
      chefFilter: "",
      sortAttribute: "chef",
      currentRecipe: {
        title: "title goes here",
        ingredients: "ingredients goes here"
      }
    };
  },
  created: function() {
    axios.get("/v1/recipes").then(
      function(response) {
        this.recipes = response.data;
      }.bind(this)
    );
  },
  methods: {
    setCurrentRecipe: function(inputRecipe) {
      this.currentRecipe = inputRecipe;
    },
    isValidRecipeTitle: function(inputRecipe) {
      var lowerInputTitle = inputRecipe.title.toLowerCase();
      var lowerTitleFilter = this.titleFilter.toLowerCase();
      return lowerInputTitle.includes(lowerTitleFilter);
    },
    isValidRecipeChef: function(inputRecipe) {
      var lowerInputChef = inputRecipe.chef.toLowerCase();
      var lowerChefFilter = this.chefFilter.toLowerCase();
      return lowerInputChef.includes(lowerChefFilter);
    },
    isValidRecipe: function(inputRecipe) {
      return (
        this.isValidRecipeTitle(inputRecipe) &&
        this.isValidRecipeChef(inputRecipe)
      );
    }
    // isValidRecipe: function(inputRecipe) {
    //   // check if title matches
    //   var lowerInputTitle = inputRecipe.title.toLowerCase();
    //   var lowerTitleFilter = this.anythingFilter.toLowerCase();
    //   var titleMatches = lowerInputTitle.includes(lowerTitleFilter);
    //   // check if chef matches
    //   var lowerInputChef = inputRecipe.chef.toLowerCase();
    //   var lowerChefFilter = this.anythingFilter.toLowerCase();
    //   var chefMatches = lowerInputChef.includes(lowerChefFilter);
    //   // return true if either matches, false otherwise
    //   return titleMatches || chefMatches;
    // }
  },
  computed: {
    sortedRecipes: function() {
      return this.recipes.sort(
        function(recipe1, recipe2) {
          // return recipe1.chef.localeCompare(recipe2.chef);
          var lowerAttribute1 = recipe1[this.sortAttribute].toLowerCase();
          var lowerAttribute2 = recipe2[this.sortAttribute].toLowerCase();
          return lowerAttribute1.localeCompare(lowerAttribute2);
        }.bind(this)
      );
    }
  }
};

var RecipesShowPage = {
  template: "#recipes-show-page",
  data: function() {
    return {
      recipe: {
        title: "Title goes here",
        ingredients: ["first ingredient", "second ingredient"],
        directions: ["first direction", "second direction"]
      }
    };
  },
  created: function() {
    console.log("what is this weird $route thing", this.$route);
    axios.get("v1/recipes/" + this.$route.params.id).then(
      function(response) {
        this.recipe = response.data;
      }.bind(this)
    );
  },
  methods: {},
  computed: {}
};

var SamplePage = {
  template: "#sample-page",
  data: function() {
    return {
      message: "Welcome to Vue.js (sample page)!"
    };
  },
  created: function() {},
  methods: {},
  computed: {}
};

var SignupPage = {
  template: "#signup-page",
  data: function() {
    return {
      name: "",
      email: "",
      password: "",
      passwordConfirmation: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        name: this.name,
        email: this.email,
        password: this.password,
        password_confirmation: this.passwordConfirmation
      };
      axios
        .post("/v1/users", params)
        .then(function(response) {
          router.push("/login");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
};

var LoginPage = {
  template: "#login-page",
  data: function() {
    return {
      email: "",
      password: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        auth: { email: this.email, password: this.password }
      };
      axios
        .post("/user_token", params)
        .then(function(response) {
          axios.defaults.headers.common["Authorization"] =
            "Bearer " + response.data.jwt;
          localStorage.setItem("jwt", response.data.jwt);
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = ["Invalid email or password."];
            this.email = "";
            this.password = "";
          }.bind(this)
        );
    }
  }
};

var RecipesNewPage = {
  template: "#recipes-new-page",
  data: function() {
    return {
      title: "",
      chef: "",
      ingredients: "",
      directions: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        input_title: this.title,
        input_chef: this.chef,
        input_ingredients: this.ingredients,
        input_directions: this.directions
      };
      axios
        .post("/v1/recipes", params)
        .then(function(response) {
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
};

var LogoutPage = {
  template: "<h1>Logout</h1>",
  created: function() {
    axios.defaults.headers.common["Authorization"] = undefined;
    localStorage.removeItem("jwt");
    router.push("/");
  }
};

var router = new VueRouter({
  routes: [
    { path: "/", component: HomePage },
    { path: "/sample", component: SamplePage },
    { path: "/signup", component: SignupPage },
    { path: "/login", component: LoginPage },
    { path: "/logout", component: LogoutPage },
    { path: "/recipes/new", component: RecipesNewPage },
    { path: "/recipes/:id", component: RecipesShowPage }
  ],
  scrollBehavior: function(to, from, savedPosition) {
    return { x: 0, y: 0 };
  }
});

var app = new Vue({
  el: "#vue-app",
  router: router,
  created: function() {
    var jwt = localStorage.getItem("jwt");
    if (jwt) {
      axios.defaults.headers.common["Authorization"] = jwt;
    }
  }
});
