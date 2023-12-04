// # Copyright 2023 Google LLC
// #
// # Licensed under the Apache License, Version 2.0 (the "License");
// # you may not use this file except in compliance with the License.
// # You may obtain a copy of the License at
// #
// #      http://www.apache.org/licenses/LICENSE-2.0
// #
// # Unless required by applicable law or agreed to in writing, software
// # distributed under the License is distributed on an "AS IS" BASIS,
// # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// # See the License for the specific language governing permissions and
// # limitations under the License.
import "./index.css";
import React from "react";
import NewProducts from "./components/NewProducts.jsx";
import Homepage from "./components/Homepage.jsx";
import Footer from "./components/Footer.jsx";
import Header from "./components/Header.jsx";
import { useLocation } from "react-router-dom";

function App() {
  const location = useLocation();
  return (
    <div>
      <Header />
      <body>
        <main>
        {location.pathname === "/newproducts" ? <NewProducts/> : <Homepage/>}<br/>
        </main>
      </body>
      <Footer />
    </div>
  );
}

export default App;
