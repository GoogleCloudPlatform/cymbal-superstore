import React, { useState, useEffect } from "react";

// get env var, INVENTORY_API_URL
const INVENTORY_API_URL = process.env.REACT_APP_INVENTORY_API_URL;
console.log("INVENTORY_API_URL: ", INVENTORY_API_URL);

const NewProducts = () => {
  const [products, setProducts] = useState([]);

  useEffect(() => {
    const getProducts = async () => {
      const response = await fetch(`${INVENTORY_API_URL}/newproducts`);
      const data = await response.json();
      console.log(data);
      setProducts(data);
    };

    getProducts();
    // if products is empty, return a mock list 
    if (products.length === 0) {
      console.log("products is empty, returning mock list")
      setProducts([
        {
          id: 1,
          name: "Test Product",
          price: 1.99,
          imgfile: "/product-images/placeholder.png",
        },
        {
          id: 2,
          name: "Test Product",
          price: 1.99,
          imgfile: "/product-images/placeholder.png",
        },
        {
          id: 3,
          name: "Test Product",
          price: 1.99,
          imgfile: "/product-images/placeholder.png",
        },
        {
          id: 4,
          name: "Test Product",
          price: 1.99,
          imgfile: "/product-images/placeholder.png",
        },
        {
          id: 5,
          name: "Test Product",
          price: 1.99,
          imgfile: "/product-images/placeholder.png",
        },
        {
          id: 6,
          name: "Test Product",
          price: 1.99,
          imgfile: "/product-images/placeholder.png",
        },
      ]);
    }
  }, []);

  return (
    <div class="container pt-6">
      <h3 class="pb-3">New Arrivals</h3>
      <div>
        <p><em>Cymbal Superstore brings you exciting new products each week!</em></p>
      </div>
      <div class="row pb-3">

        {products.map((product) => (
          <div key={product.id} className="col-md-3">
            <div className="card">
              <img
                class="card-img-top"
                src={product.imgfile}
                alt="Product"
                style={{ objectFit: "cover", height: "200px" }}
              />
              <div className="card-body">
                <h6 className="card-title"><a href="/newproducts">{product.name}</a></h6>
                <div>
                <span className="card-text">${product.price} </span>
                <button type="button" className="btn btn-primary ml-2 p-1">
                  <i className="bi bi-cart-plus"></i>                  
                </button>
                </div>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default NewProducts;
