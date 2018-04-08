/* global axios */

var productTemplate = document.querySelector("#product-card");
var productContainer = document.querySelector(".row");

axios.get("http://localhost:3000/v1/products").then(function(response) {
  var products = response.data;
  console.log(products);

  products.forEach(function(product) {
    var productClone = productTemplate.content.cloneNode(true);
    productClone.querySelector(".card-title").innerText = product.name;
    productClone.querySelector(".card-text").innerText = product.description;
    productClone.querySelector(".list-group-item").innerText =
      "price: $" + product.price;
    productClone.querySelector(".card-img-top").src = product.images[0];
    productContainer.appendChild(productClone);
  });
});
