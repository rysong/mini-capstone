/* global Vue, VueRouter, axios */

var HomePage = {
  template: "#home-page",
  data: function() {
    return {
      message: "Welcome to the Products Store",
      products: [],
      currentProduct: {},
      nameFilter: "",
      sortAttribute: "name",
      sortAscending: true
    };
  },
  created: function() {
    axios.get("/v1/products").then(
      function(response) {
        this.products = response.data;
      }.bind(this)
    );
  },
  methods: {
    setCurrentProduct: function(product) {
      this.currentProduct = product;
    },
    isValidProduct: function(product) {
      var lowerCaseProduct = product.name.toLowerCase();
      var lowerCaseNameFilter = this.nameFilter.toLowerCase();
      return lowerCaseProduct.includes(lowerCaseNameFilter);
    },
    setSortAttribute: function(inputSortAttribute) {
      this.sortAttribute = inputSortAttribute;
      this.sortAscending = !this.sortAscending;
    }
  },
  computed: {
    sortedProducts: function() {
      return this.products.sort(
        function(product1, product2) {
          // return recipe1.chef.localeCompare(recipe2.chef);
          var lowerAttribute1 = product1[this.sortAttribute].toLowerCase();
          var lowerAttribute2 = product2[this.sortAttribute].toLowerCase();
          if (this.sortAscending) {
            return lowerAttribute1.localeCompare(lowerAttribute2);
          } else {
            return lowerAttribute2.localeCompare(lowerAttribute1);
          }
        }.bind(this)
      );
    }
  }
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

var LogoutPage = {
  template: "<h1>Logout</h1>",
  created: function() {
    axios.defaults.headers.common["Authorization"] = undefined;
    localStorage.removeItem("jwt");
    router.push("/");
  }
};

var ProductsNewPage = {
  template: "#products-new-page",
  data: function() {
    return {
      name: "",
      price: "",
      description: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        name: this.name,
        price: this.price,
        description: this.description
      };
      axios
        .post("/v1/products", params)
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

var router = new VueRouter({
  routes: [
    { path: "/", component: HomePage },
    { path: "/sample", component: SamplePage },
    { path: "/signup", component: SignupPage },
    { path: "/login", component: LoginPage },
    { path: "/logout", component: LogoutPage },
    { path: "/products/new", component: ProductsNewPage }
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
