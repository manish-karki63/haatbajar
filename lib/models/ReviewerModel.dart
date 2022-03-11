class Reviewer {
  int id;
  String firstName;
  String lastName;
  String phoneNo;
  String email;
  String profilePicture;

  Reviewer(
      {this.id,
        this.firstName,
        this.lastName,
        this.phoneNo,
        this.email,
        this.profilePicture});

  factory Reviewer.fromJson(Map<String, dynamic> json) {
    return Reviewer(
    id : json['id']!= null? json['id']:0,
    firstName : json['firstName']!= null? json['firstName']:"",
    lastName : json['lastName']!= null? json['lastName']:"",
    phoneNo : json['phoneNo']!= null? json['phoneNo']:0,
    email : json['email']!= null? json['email']:"",
    profilePicture : json['profilePicture']!= null? json['profilePicture']:null,
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