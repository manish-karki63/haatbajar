import 'package:haatbajar/models/locationmodel.dart';

class Seller {
  int id;
  String firstName;
  String lastName;
  String phoneNo;
  String email;
  String profilePicture;
  Location location;
  double rating;

  Seller(
      {this.id,
      this.firstName,
      this.lastName,
      this.phoneNo,
      this.email,
      this.profilePicture,
        this.rating,
      this.location});

  factory Seller.fromJson(Map<String, dynamic> json) {
    double rate = 0.0;
    if (json['rating'] != null && json['rating'] is int) {
      rate = json['rating'].toDouble();
    } else if (json['rating'] != null && json['rating'] is double) {
      rate = json['rating'];
    }
    return Seller(
      id: json['id'] != null ? json['id'] : 0,
      firstName: json['firstName'] != null ? json['firstName'] : "",
      lastName: json['lastName'] != null ? json['lastName'] : "",
      phoneNo: json['phoneNo'] != null ? json['phoneNo'] : "",
      email: json['email'] != null ? json['email'] : "",
      profilePicture: json['profilePicture'] != null ? json['profilePicture'] : "",
      location: json['location'] != null
          ? new Location.fromJson(json['location'])
          : null,
      rating: rate,
    );

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['phoneNo'] = this.phoneNo;
    data['email'] = this.email;
    data['profilePicture'] = this.profilePicture;
    return data;
  }
}
