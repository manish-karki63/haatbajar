import 'dart:core';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:haatbajar/models/locationmodel.dart';
import 'package:haatbajar/ui/login/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoder/geocoder.dart';

Future<String> getToken() async {
  final preference = await SharedPreferences.getInstance();
  final token = preference.getString('token');
  return token;
}

Future<int> getId() async {
  final preference = await SharedPreferences.getInstance();
  int id = preference.getInt('userId');
  return id;
}

Future<Location> locateUser() async {
  Position currentLocation;
  Location l = new Location();
  currentLocation = await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  l.lat = currentLocation.latitude;
  l.long = currentLocation.longitude;
  return l;
}

void clearToken(BuildContext context) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  print(pref);
  pref.setString('token', null);
  pref.setInt("userId", null);
  pref.setString("email", null);
  pref.setString("profile", null);
  pref.setString("userName", null);
  pref.setString("countryCode", null);
  Navigator.of(context).pop(context);
  Navigator.push(
      context, new MaterialPageRoute(builder: (context) => new LoginPage()));
}

Future<String> getDistance(latitude, longitude) async {
  //SharedPreferences preference = await SharedPreferences.getInstance();
  String dummy = "";
  String km = "KM";
  String m = "M";
  Location l;
  l = await locateUser();
  var distanceInMeters = await Geolocator().distanceBetween(
    latitude,
    longitude,
    l.lat,
    l.long,
  );
  if (distanceInMeters >= 1000.0) {
    distanceInMeters /= 1000.0;

    dummy = distanceInMeters.toStringAsFixed(0);
    dummy = dummy + " " + km;
  } else {
    dummy = distanceInMeters.toStringAsFixed(0);
    dummy = dummy + " " + m;
  }
  return dummy;
}

void updatePreference(
    String userName, String email, String phone, String countryCode) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString("userName", userName);
  preferences.setString('email', email);
  print(email);
  preferences.setString('phone', phone);
  preferences.setString('countryCode', countryCode);
}

void getAddress() async {
  print("i am from get address ");
  SharedPreferences preference = await SharedPreferences.getInstance();
  Location l;
  l = await locateUser();
  print("i am from get address ${l.lat}");
  final coordinates = new Coordinates(l.lat, l.long);
  var addresses =
      await Geocoder.local.findAddressesFromCoordinates(coordinates);
  var adddata = addresses.first;
  log('data: $addresses.first');
  //print("i am from get address ${adddata.subLocality}");
  String address =
      "${adddata.subLocality != null ? adddata.subLocality + "," : ""} ${adddata.locality}, ${adddata.countryName}";
  await preference.setString("address", address);
}

Future<String> getsellerAddress(double latitude, double longitude) async {
  //SharedPreferences preference = await SharedPreferences.getInstance();
  print("i am from get seller address ");
  // print("i am from get seller address ${l.lat}");
  final coordinates = new Coordinates(latitude, longitude);
  var addresses =
      await Geocoder.local.findAddressesFromCoordinates(coordinates);
  var adddata = addresses.first;
  log('data: $addresses.first');
  //print("i am from get address ${adddata.subLocality}");

  String address =
      "${adddata.subLocality != null ? adddata.subLocality + "," : ""} ${adddata.locality}, ${adddata.countryName}";
  //await preference.setString("selleraddress",address);
  return address;
}
