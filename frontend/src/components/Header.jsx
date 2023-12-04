import React from "react";
// import bootstrap icons
import "bootstrap-icons/font/bootstrap-icons.css";

const Header = () => {
  return (
    <nav class="navbar fixed-top navbar-expand-lg navbar-light bg-light">
      <div class="container-fluid">
        <a class="navbar-brand" href="/">
          <img
            src="/images/logo.png"
            alt="Cymbal Superstore"
            height="50px"
            class="d-inline-block align-text-top"
          />
        </a>
        <button
          class="navbar-toggler"
          type="button"
          data-bs-toggle="collapse"
          data-bs-target="#navbarNav"
          aria-controls="navbarNav"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav">
            <li class="nav-item">
              <a class="nav-link" href="#">
                🍎 Shop
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">
                💊 Pharmacy
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">
                📍 My Store
              </a>
            </li>
          </ul>
          <form class="d-flex pl-2">
            <input
              class="form-control me-4 w-200"
              type="search"
              placeholder="Find a product"
              aria-label="Search"
            />
            <button class="btn btn-outline" type="submit">
              🔎
            </button>
          </form>

          <ul class="navbar-nav ml-auto">
            <li class="nav-item">
              <a class="nav-link" href="#">
                <i class="bi bi-cart"></i> Cart (2)
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">
                <i class="bi bi-person"></i> Sign In
              </a>
            </li>
          </ul>
        </div>
      </div>
    </nav>
  );
};

export default Header;
