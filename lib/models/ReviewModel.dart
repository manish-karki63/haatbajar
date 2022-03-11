import 'package:haatbajar/models/ReviewerModel.dart';
import 'package:haatbajar/models/productModel.dart';

class ReviewModel {
  int id;
  String reviewType;
  int reviewerId;
  int productId;
  int sellerId;
  String review;
  double rating;
  bool isDeleted;
  String createdAt;
  String updatedAt;
  Reviewer reviewer;
  Product product;
  String dateToDisplay;

  ReviewModel(
      {this.id,
        this.reviewType,
        this.reviewerId,
        this.productId,
        this.sellerId,
        this.review,
        this.rating,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.dateToDisplay,
        this.reviewer,
        this.product});

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    String dateread = json['updatedAt'] !=null ? json['updatedAt'] : json['createdAt'];
    if (dateread != null){dateread = dateread.substring(0,10);}else{dateread="";}
    return ReviewModel(
    id : json['id'] != null ? json['id'] : 0,
    reviewType: json['reviewType']!= null ? json['reviewType'] : "",
    reviewerId : json['reviewerId']!= null ? json['reviewerId'] : 0,
    productId : json['productId']!= null ? json['productId'] : 0,
    sellerId : json['sellerId']!= null ? json['sellerId'] : 0,
    review : json['review']!= null ? json['review'] : "",
    rating : json['rating']!= null ? json['rating'].toDouble() : 0.0,
    isDeleted : json['isDeleted']!= null ? json['isDeleted'] : false,
    createdAt : json['createdAt']!= null ? json['createdAt'] : "",
    updatedAt : json['updatedAt']!= null ? json['updateAt'] : "",
    reviewer : json['reviewer'] != null
        ? new Reviewer.fromJson(json['reviewer'])
        : null,
    product :
    json['product'] != null ? new Product.fromJson(json['product']) : null,
      dateToDisplay: dateread,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reviewType'] = this.reviewType;
    data['reviewerId'] = this.reviewerId;
    data['productId'] = this.productId;
    data['sellerId'] = this.sellerId;
    data['review'] = this.review;
    data['rating'] = this.rating;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.reviewer != null) {
      data['reviewer'] = this.reviewer.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    return data;
  }
}

