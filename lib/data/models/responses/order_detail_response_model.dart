import 'dart:convert';

class OrderDetailResponseModel {
  final Data data;
  final Meta meta;

  OrderDetailResponseModel({
    required this.data,
    required this.meta,
  });

  factory OrderDetailResponseModel.fromJson(String str) =>
      OrderDetailResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderDetailResponseModel.fromMap(Map<String, dynamic> json) =>
      OrderDetailResponseModel(
        data: Data.fromMap(json["data"]),
        meta: Meta.fromMap(json["meta"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data.toMap(),
        "meta": meta.toMap(),
      };
}

class Data {
  final int id;
  final Attributes attributes;

  Data({
    required this.id,
    required this.attributes,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        attributes: Attributes.fromMap(json["attributes"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "attributes": attributes.toMap(),
      };
}

class Attributes {
  final List<Item> items;
  final int totalPrice;
  final String deliveryAddress;
  final String courierName;
  final int courierCost;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime publishedAt;
  final String statusOrder;

  Attributes({
    required this.items,
    required this.totalPrice,
    required this.deliveryAddress,
    required this.courierName,
    required this.courierCost,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.statusOrder,
  });

  factory Attributes.fromJson(String str) =>
      Attributes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Attributes.fromMap(Map<String, dynamic> json) => Attributes(
        items: List<Item>.from(json["items"].map((x) => Item.fromMap(x))),
        totalPrice: json["totalPrice"],
        deliveryAddress: json["deliveryAddress"],
        courierName: json["courierName"],
        courierCost: json["courierCost"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        publishedAt: DateTime.parse(json["publishedAt"]),
        statusOrder: json["statusOrder"],
      );

  Map<String, dynamic> toMap() => {
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
        "totalPrice": totalPrice,
        "deliveryAddress": deliveryAddress,
        "courierName": courierName,
        "courierCost": courierCost,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "publishedAt": publishedAt.toIso8601String(),
        "statusOrder": statusOrder,
      };
}

class Item {
  final int id;
  final int qty;
  final int price;
  final String productName;

  Item({
    required this.id,
    required this.qty,
    required this.price,
    required this.productName,
  });

  factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        id: json["id"],
        qty: json["qty"],
        price: json["price"],
        productName: json["productName"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "qty": qty,
        "price": price,
        "productName": productName,
      };
}

class Meta {
  Meta();

  factory Meta.fromJson(String str) => Meta.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Meta.fromMap(Map<String, dynamic> json) => Meta();

  Map<String, dynamic> toMap() => {};
}
