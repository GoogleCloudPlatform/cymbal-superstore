app.get("/newproducts", async (req: Request, res: Response) => {
  const products = await firestore
    .collection("inventory")
    .where("timestamp", ">", new Date(Date.now() - 604800000))
    .where("quantity", ">", 0)
    .limit(30)
    .get();
  const productsArray: any[] = [];
  products.forEach((product) => {
    const p: Product = {
      id: product.id,
      name: product.data().name,
      price: product.data().price,
      quantity: product.data().quantity,
      imgfile: product.data().imgfile,
      timestamp: product.data().timestamp,
      actualdateadded: product.data().actualdateadded,
    };
      productsArray.push(p);
  });
  res.send(productsArray);
});