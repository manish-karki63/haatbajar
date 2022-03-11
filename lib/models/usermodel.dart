import 'package:haatbajar/models/ReviewModel.dart';
import 'locationmodel.dart';

class User {
  int id;
  String firstName;
  double rating;
  String lastName;
  String email;
  String password;
  String phoneNo;
  String profilePicture;
  Location location;
  List<ReviewModel> reviewModel;
  String countryCode;
  List<String> tags;
  bool isVerified;
  bool isActive;
  int views;
  String role;
  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.phoneNo,
      this.profilePicture,
      this.location,
      this.reviewModel,
        this.rating,
      this.countryCode,
      this.tags,
      this.isVerified,
      this.isActive,
      this.views,
      this.role});
  factory User.fromJson(Map<String, dynamic> json) {
    List<ReviewModel> reviews;
    if (json['reviews'] != null) {
      reviews = new List<ReviewModel>();
    json['reviews'].forEach((v) {
    reviews.add(new ReviewModel.fromJson(v));
    });
    }
    double rate = 0.0;
    if (json['rating'] != null && json['rating'] is int) {
      rate = json['rating'].toDouble();
    } else if (json['rating'] != null && json['rating'] is double) {
      rate = json['rating'];
    }
    return User(
      id : json['id'] != null ? json['id'] : 0,
      firstName : json['firstName'] != null ? json['firstName'] : "",
      lastName : json['lastName'] != null ? json['lastName'] : "",
      email : json['email'] != null ? json['email'] : "",
      password : json['password'] != null ? json['password'] : "",
      phoneNo : json['phoneNo'] != null ? json['phoneNo'] : "",
      profilePicture :
      json['profilePicture'] != null ? json['profilePicture'] : "",
      location : json['location'] != null
          ? new Location.fromJson(json['location'])
          : null,
      countryCode : json['countryCode'] != null ? json['countryCode'] : "",
      //tags = json['tags'] != null ? json['tags'].cast<String>() : [];
      isVerified : json['isVerified'] != null ? json['isVerified'] : false,
      isActive : json['isActive'] != null ? json['isActive'] : false,
      views : json['views'] != null ? json['views'] : 0,
      role : json['role'] != null ? json['role'] : "",
      rating: rate,
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phoneNo'] = this.phoneNo;
    data['profilePicture'] = this.profilePicture;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['countryCode'] = this.countryCode;
    data['tags'] = this.tags;
    data['isVerified'] = this.isVerified;
    data['isActive'] = this.isActive;
    data['views'] = this.views;
    data['role'] = this.role;
    return data;
  }
}
