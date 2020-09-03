// To parse this JSON data, do
//
//     final product = productFromMap(jsonString);

import 'dart:convert';

List<Product> productFromMap(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromMap(x)));

String productToMap(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Product {
  Product({
    this.id,
    this.shopId,
    this.name,
    this.itemCode,
    this.brandId,
    this.price,
    this.sizeMin,
    this.sizeMax,
    this.fabricStructure,
    this.seasonality,
    this.sizeOnFashionModel,
    this.fashionModelParams,
    this.fashionModelHeight,
    this.length,
    this.sleeveLength,
    this.inStock,
    this.createdAt,
    this.updatedAt,
    this.picture,
    this.thumbnailPicture,
  });

  int id;
  int shopId;
  String name;
  String itemCode;
  int brandId;
  String price;
  int sizeMin;
  int sizeMax;
  String fabricStructure;
  int seasonality;
  int sizeOnFashionModel;
  String fashionModelParams;
  int fashionModelHeight;
  int length;
  int sleeveLength;
  int inStock;
  int createdAt;
  int updatedAt;
  String picture;
  String thumbnailPicture;

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        shopId: json["shop_id"],
        name: json["name"],
        itemCode: json["item_code"],
        brandId: json["brand_id"],
        price: json["price"],
        sizeMin: json["size_min"],
        sizeMax: json["size_max"],
        fabricStructure: json["fabric_structure"],
        seasonality: json["seasonality"],
        sizeOnFashionModel: json["size_on_fashion_model"],
        fashionModelParams: json["fashion_model_params"],
        fashionModelHeight: json["fashion_model_height"],
        length: json["length"],
        sleeveLength: json["sleeve_length"],
        inStock: json["in_stock"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        picture: json["picture"],
        thumbnailPicture: json["thumbnailPicture"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "shop_id": shopId,
        "name": name,
        "item_code": itemCode,
        "brand_id": brandId,
        "price": price,
        "size_min": sizeMin,
        "size_max": sizeMax,
        "fabric_structure": fabricStructure,
        "seasonality": seasonality,
        "size_on_fashion_model": sizeOnFashionModel,
        "fashion_model_params": fashionModelParams,
        "fashion_model_height": fashionModelHeight,
        "length": length,
        "sleeve_length": sleeveLength,
        "in_stock": inStock,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "picture": picture,
        "thumbnailPicture": thumbnailPicture,
      };
}
