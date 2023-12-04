import React from "react";
import { Link } from "react-router-dom";

const Homepage = () => {
  return (
    <div class="container pt-6">
      <div class="row">
        <div class="col-md-6">
          <div class="card">
            <img
              class="card-img-top"
              src="/images/cooking.avif"
              alt="New Arrivals"
            />
            <div class="card-body">
              <h5 class="card-title">
                {" "}
                <Link to="/newproducts">🫑 New Arrivals!</Link>
              </h5>
              <p class="card-text">
                Cymbal Superstore brings you exciting new and local products
                each week.
              </p>
            </div>
          </div>
        </div>
        <div class="col-md-6">
          <h5>Popular Aisles</h5>
          <div class="row">
            <div class="col-md-4">
              <div class="card">
                <div class="card-body pb-2">
                  <img
                    src="/images/cereal.png"
                    class="card-img-top"
                    alt="Cereal"
                  />
                  <p class="card-text">
                    <a href="/">Breakfast</a>
                  </p>
                </div>
              </div>
            </div>
            <div class="col-md-4">
              <div class="card">
                <div class="card-body pb-2">
                  <img
                    src="/images/popsicles.png"
                    class="card-img-top"
                    alt="Frozen"
                  />
                  <p class="card-text">
                    <a href="/">Frozen</a>
                  </p>
                </div>
              </div>
            </div>
            <div class="col-md-4">
              <div class="card">
                <div class="card-body pb-2">
                  <img
                    src="/images/strawberries.png"
                    class="card-img-top"
                    alt="Fruit"
                  />
                  <p class="card-text">
                    <a href="/">Fruit</a>
                  </p>
                </div>
              </div>
            </div>
          </div>
          <div class="row pt-2">
            <div class="col-md-4">
              <div class="card">
                <div class="card-body pb-2">
                  <img
                    src="/images/cheese.png"
                    class="card-img-top"
                    alt="Cereal"
                  />
                  <p class="card-text">
                    <a href="/">Dairy</a>
                  </p>
                </div>
              </div>
            </div>
            <div class="col-md-4">
              <div class="card">
                <div class="card-body pb-2">
                  <img
                    src="/images/pasta.png"
                    class="card-img-top"
                    alt="Frozen"
                  />
                  <p class="card-text">
                    <a href="/">Pantry</a>
                  </p>
                </div>
              </div>
            </div>
            <div class="col-md-4">
              <div class="card">
                <div class="card-body pb-2">
                  <img
                    src="/images/lettuce.png"
                    class="card-img-top"
                    alt="Vegetables"
                  />
                  <p class="card-text">
                    <a href="/">Vegetables</a>
                  </p>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="card-body">
              <p>
                🎒 <strong>Back to School:</strong> We're here for you and your
                family's end of summer needs. <a href="">Shop now</a> for back
                to school supplies including <a href="">20% off backpacks</a>{" "}
                and <a href="">30% off snack multipacks.</a>
                <p class="pt-1">
                  🌽 <strong>New to grilling?</strong> Check out{" "}
                  <a href="">the August edition of Superstore Today</a> for a
                  step by step guide!
                </p>
              </p>{" "}
            </div>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-md-6">
          <h5>
            <a href="">Shop Deals!</a>
          </h5>
          <div class="row">
            <div class="col-md-6">
              <div class="card">
                <div class="card-body pb-2">
                  <img
                    src="/images/apple-pie.jpg"
                    class="list-group-item-img img-fluid"
                    alt="30% off select bakery items!"
                    height="50%"
                  />
                  <button type="button" class="btn btn-primary mt-1">
                    <span class="small">
                      <i class="bi bi-scissors"></i> 30% off bakery
                    </span>
                  </button>
                </div>
              </div>
            </div>
            <div class="col-md-6">
              <div class="card">
                <div class="card-body pb-2">
                  <img
                    src="/images/marshmallow.png"
                    class="list-group-item-img img-fluid"
                    alt="40% off end of summer snacks!"
                  />

                  <button type="button" class="btn btn-primary mt-1">
                    <span class="small">
                      <i class="bi bi-scissors"></i> 20% off s'mores
                    </span>
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="col-md-6">
          <h5>
            <a href="">📍 My Cymbal</a>
          </h5>
          <div class="row">
            <div class="col-md-5">
              <p class="card-text small">
                <a href="">465 Turret Avenue, Columbus, OH 43201</a>
              </p>
              <p class="small"><strong>Store Hours:</strong></p>
              <ul class="small">
                <li>Sunday: 9AM-9PM</li>
                <li>Monday: 7AM-11PM</li>
                <li>Tuesday: 7AM-11PM</li>
                <li>Wednesday: 7AM-11PM</li>
                <li>Thursday: 7AM-11PM</li>
                <li>Friday: 7AM-11PM</li>
                <li>Saturday: 7AM-9PM</li>
              </ul>
            </div>
            <div class="col-md-7">
                <div class="card-body pb-6">
                  <img
                    src="/images/map.png"
                    class="card-img-top img-fluid"
                    alt="Map of My Cymbal"
                    width="200px"
                  />
                </div>
         
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Homepage;
