import 'package:haatbajar/models/ReviewModel.dart';
import 'package:haatbajar/models/categorymodel.dart';
import 'package:haatbajar/models/locationmodel.dart';
import 'package:haatbajar/models/sellermodel.dart';
import 'package:strings/strings.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:jiffy/src/enums/units.dart';

class Product {
  int id;
  String title;
  String Distance;
  String description;
  int categoryId;
  int quantity;
  String metric;
  int sellerId;
  int price;
  Location location;
  List<String> images;
  int views;
  double rating;
  bool isDeleted;
  Seller seller;
  String createdAt;
  String updatedAt;
  String dateToDisplay;
  Cat category;
  List<ReviewModel> reviews;

  Product({
    this.id,
    this.title,
    this.Distance,
    this.description,
    this.categoryId,
    this.quantity,
    this.metric,
    this.sellerId,
    this.price,
    this.location,
    this.images,
    this.views,
    this.isDeleted,
    this.seller,
    this.createdAt,
    this.updatedAt,
    this.dateToDisplay,
    this.category,
    this.rating,
    this.reviews,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _productFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['categoryId'] = this.categoryId;
    data['quantity'] = this.quantity;
    data['metric'] = this.metric;
    data['sellerId'] = this.sellerId;
    data['price'] = this.price;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['images'] = this.images;
    data['views'] = this.views;
    data['isDeleted'] = this.isDeleted;
    data['seller'] = this.seller;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

Product _productFromJson(Map<String, dynamic> json) {
  List<ReviewModel> reviews;
  if (json['reviews'] != null) {
    reviews = new List<ReviewModel>();
    json['reviews'].forEach((v) {
      reviews.add(new ReviewModel.fromJson(v));
    });
  }
  double rate = 0.0;
  var imagejson = json['images'];
  List<String> images = imagejson != null ? new List.from(imagejson) : null;
  String dateread =
      json['updatedAt'] != null ? json['updatedAt'] : json['createdAt']??"";
  if(dateread.isNotEmpty)
    dateread = Jiffy(dateread).format("MMM, dd yyyy");
  if (json['rating'] != null && json['rating'] is int) {
    rate = json['rating'].toDouble();
  } else if (json['rating'] != null && json['rating'] is double) {
    rate = json['rating'];
  }
  return Product(
    id: json['id'] != null ? json['id'] : 0,
    title: json['title'] != null ? capitalize(json['title']) : "",
    description: json['description'] != null ? json['description'] : "",
    categoryId: json['categoryId'] != null ? json['categoryId'] : 0,
    quantity: json['quantity'] != null ? json['quantity'] : 0,
    metric: json['metric'] != null ? json['metric'] : "",
    sellerId: json['sellerId'] != null ? json['sellerId'] : 0,
    price: json['price'] != null ? json['price'] : 0,
    location: json['location'] != null
        ? new Location.fromJson(json['location'])
        : null,
    images: images,
    views: json['views'] != null ? json['views'] : 0,
    isDeleted: json['isDeleted'] != null ? json['isDeleted'] : false,
    seller: json['seller'] != null ? new Seller.fromJson(json['seller']) : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] : "",
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] : "",
    rating: rate,
    category:
        json['category'] != null ? new Cat.fromJson(json['category']) : null,
    dateToDisplay:  dateread,
  );
}
