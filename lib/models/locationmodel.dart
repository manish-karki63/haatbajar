class Location {
  double lat;
  double long;
  Location({this.lat, this.long});

  factory Location.fromJson(Map<String, dynamic> json) {
    double lat = 0.0;
    if (json['lat'] != null && json['lat'] is int) {
      lat = json['lat'].toDouble();
    } else if (json['lat'] != null && json['lat'] is double) {
      lat = json['lat'];
    }
    double long = 0.0;
    if (json['long'] != null && json['long'] is int) {
      long = json['long'].toDouble();
    } else if (json['long'] != null && json['long'] is double) {
      long = json['long'];
    }
    return Location(
      lat: lat,
      long: long,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}
