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
    this.colors,
    this.pictures,
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
  List<ProdColor> colors;
  List<Picture> pictures;

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
        picture: 'https://khanbuyer.ml' + json["picture"],
        thumbnailPicture: 'https://khanbuyer.ml' + json["thumbnailPicture"],
        colors: getColor(json),
        pictures: getPic(json),
      );

  static List<ProdColor> getColor(Map<String, dynamic> json) {
    if (json.containsKey('colors')) {
      return List<ProdColor>.from(
          json["colors"].map((x) => ProdColor.fromMap(x)));
    }
    return null;
  }

  static List<Picture> getPic(Map<String, dynamic> json) {
    if (json.containsKey('pictures')) {
      return List<Picture>.from(
          json["pictures"].map((x) => Picture.fromMap(x)));
    }
    return null;
  }

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
        "colors": List<dynamic>.from(colors.map((x) => x.toMap())),
        "pictures": List<dynamic>.from(pictures.map((x) => x.toMap())),
      };
}

class ProdColor {
  ProdColor({
    this.id,
    this.name,
    this.code,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String code;
  int createdAt;
  int updatedAt;

  factory ProdColor.fromMap(Map<String, dynamic> json) => ProdColor(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "code": code,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Picture {
  Picture({
    this.picture,
    this.thumbnailPicture,
    this.isMain,
  });

  String picture;
  String thumbnailPicture;
  int isMain;

  factory Picture.fromMap(Map<String, dynamic> json) => Picture(
        picture: 'https://khanbuyer.ml' + json["picture"],
        thumbnailPicture: 'https://khanbuyer.ml' + json["thumbnailPicture"],
        isMain: json["isMain"] == null ? null : json["isMain"],
      );

  Map<String, dynamic> toMap() => {
        "picture": picture,
        "thumbnailPicture": thumbnailPicture,
        "isMain": isMain == null ? null : isMain,
      };
}
