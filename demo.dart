return myProduct?.name;

return myProduct??Product();

myProduct??= Product();

//The old way
List<Product> productList=List<Product>.from(this.myProducts);
productList.add(Product);
return productList;

//Easier way
return List<Product>.from(this.myProducts)..add(Product());

