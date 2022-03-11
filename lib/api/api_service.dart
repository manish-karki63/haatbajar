import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:haatbajar/models/ReviewModel.dart';
import 'package:haatbajar/models/categorymodel.dart';
import 'package:haatbajar/models/homepagemodel.dart';
import 'package:haatbajar/models/locationmodel.dart';
import 'package:haatbajar/models/orderModel.dart';
import 'package:haatbajar/models/productModel.dart';
import 'package:haatbajar/models/sellermodel.dart';
import 'package:haatbajar/models/usermodel.dart';
import 'package:haatbajar/utilities/utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataResponse<T> {
  bool success;
  String message;
  T data;
}

class ApiService {
  final String baseUrl = "http://rijalroshan.com.np:8082/api";
  var dio = Dio();
  ApiService() {
    dio.options
      ..baseUrl = baseUrl
      ..headers = {
        'content-type': 'application/json',
      };
  }

  Future<DataResponse<dynamic>> login(String phone, String password) async {
    DataResponse<dynamic> r = new DataResponse();
    try {
      var response = await dio
          .post('/user/login', data: {'phoneNo': phone, 'password': password});
      if (response == null) {
        r.success = false;
        r.message = "Unable to login";
      } else {
        var responsebody = response.data;
        if (response.statusCode == 200) {
          var userModel = User.fromJson(responsebody);
          var token = responsebody['token'];
          var userId = responsebody['userId'];
          var email = responsebody['email'];
          var profile = responsebody['profile'];
          var userName = responsebody['name'];
          var countryCode = responsebody['countryCode'];
          r.success = true;
          r.message = "Logged in successfully";
          r.data = userModel;
          SharedPreferences preference = await SharedPreferences.getInstance();
          await preference.setString('token', token);
          await preference.setInt("userId", userId);
          await preference.setString("email", email);
          await preference.setString("profile", profile);
          await preference.setString("userName", userName);
          await preference.setString("countryCode", countryCode);
        } else {
          r.success = false;
          r.message = responsebody["message"];
        }
      }
    } catch (e) {
      print(e.toString());
      r.success = false;
      r.message = "Unable to login";
    }
    return r;
  }

  Future<bool> orderProduct(
      int productId, int sellerId, int quantity, String message) async {
    print(productId);
    print(quantity);
    DataResponse r = new DataResponse();
    try {
      var token = await getToken();
      print(token);
      dio.options.headers["authorization"] = "Bearer " + token;
      int id = await getId();
      print(id);
      int buyerId = id;
      var response = await dio.post('/order', data: {
        "productId": productId,
        "sellerId": sellerId,
        "buyerId": buyerId,
        "quantity": quantity,
        "message": message
      });
      print(response.statusCode);
      print(response.data);
      if (response == null) {
        print("response null");
        return false;
      } else {
        var responsebody = response.data;
        r = getResponse(response.statusCode, responsebody);
        print(responsebody);
        print(r.message);
        return true;
      }
    } on DioError catch (e) {
      print(e);
      print(e.response.statusCode);
      print(e.response.data);
      if (e.response.data != null) {
        Map<String, dynamic> map = e.response.data;
        if (map.containsKey("message")) {
          r.message = map["message"];
          print(r.message);
        } else
          print("Unable to order");
      } else {
        print("unable to order");
      }
      return false;
    }
  }

  Future<bool> resetPassword(
      int userotp, String newPassword, String confirmPassword) async {
    DataResponse r = new DataResponse();
    try {
      var token = await getToken();
      dio.options.headers["authorization"] = "Bearer " + token;
      var response = await dio.post('/user/resetpassword/', data: {
        "otp": userotp,
        "new_password": newPassword,
        "confirmPassword": confirmPassword,
      });
      print(response.statusCode);
      print(response.data);
      if (response == null) {
        print("response null");
        return false;
      } else {
        var responsebody = response.data;
        r = getResponse(response.statusCode, responsebody);
        print(responsebody);
        print(r.message);
        return true;
      }
    } on DioError catch (e) {
      print(e);
      print(e.response.statusCode);
      print(e.response.data);
      if (e.response.data != null) {
        Map<String, dynamic> map = e.response.data;
        if (map.containsKey("message")) {
          r.message = map["message"];
          print(r.message);
        } else
          print("Unable to change password");
      } else {
        print("unable to change");
      }
      return false;
    }
  }

  Future<bool> changePass(String oldPassword, String newPassword) async {
    DataResponse r = new DataResponse();
    try {
      var token = await getToken();
      print(token);
      dio.options.headers["authorization"] = "Bearer " + token;
      int id = await getId();
      print(id);
      int userId = id;
      var response = await dio.post('/user/changepassword', data: {
        "userId": userId,
        "old_password": oldPassword,
        "new_password": newPassword,
      });
      print(response.statusCode);
      print(response.data);
      if (response == null) {
        return false;
      } else {
        var responsebody = response.data;
        r = getResponse(response.statusCode, responsebody);
        print(responsebody);
        print(r.message);
        return true;
      }
    } on DioError catch (e) {
      print(e);
      print(e.response.statusCode);
      print(e.response.data);
      if (e.response.data != null) {
        Map<String, dynamic> map = e.response.data;
        if (map.containsKey("message")) {
          r.message = map["message"];
          print(r.message);
        } else
          print("Unable to change password");
      } else {
        print("unable to change password");
      }
      return false;
    }
  }

  Future<bool> deleteAccount() async {
    DataResponse r = new DataResponse();
    try {
      var token = await getToken();
      print(token);
      dio.options.headers["authorization"] = "Bearer " + token;
      int id = await getId();
      var response = await dio.delete('/user/${id}');
      print(response.statusCode);
      print(response.data);
      if (response == null) {
        print("response null");
        return false;
      } else {
        var responsebody = response.data;
        r = getResponse(response.statusCode, responsebody);
        print(responsebody);
        print(r.message);
        return true;
      }
    } on DioError catch (e) {
      print(e);
      print(e.response.statusCode);
      print(e.response.data);
      if (e.response.data != null) {
        Map<String, dynamic> map = e.response.data;
        if (map.containsKey("message")) {
          r.message = map["message"];
          print(r.message);
        } else
          print("Unable to delete Account");
      } else {
        print("unable to delete account");
      }
      return false;
    }
  }

  Future<bool> reviewProduct(
      int productId, String productcomment, double ratings) async {
    print(ratings);
    print(productcomment);
    DataResponse r = new DataResponse();
    try {
      var token = await getToken();
      print(token);
      dio.options.headers["authorization"] = "Bearer " + token;
      int id = await getId();
      print(id);
      int reviewerId = id;
      var response = await dio.post('/review/product', data: {
        "reviewerId": reviewerId,
        "productId": productId,
        "review": productcomment,
        "rating": ratings
      });
      print(response.statusCode);
      print(response.data);
      if (response == null) {
        print("response null");
        return false;
      } else {
        var responsebody = response.data;
        r = getResponse(response.statusCode, responsebody);
        print(responsebody);
        print(r.message);
        return true;
      }
    } on DioError catch (e) {
      print(e);
      print(e.response.statusCode);
      print(e.response.data);
      if (e.response.data != null) {
        Map<String, dynamic> map = e.response.data;
        if (map.containsKey("message")) {
          r.message = map["message"];
          print(r.message);
        } else
          print("Unable to order");
      } else {
        print("unable to order");
      }
      return false;
    }
  }

  Future<bool> reviewSeller(
      int sellerId, String sellercomment, double ratings) async {
    debugPrint("i am from api service reviewseller method: ${sellerId}");
    debugPrint("i am from api service reviewseller method: ${sellercomment}");
    debugPrint("i am from api service reviewseller method: ${ratings}");
    print(sellercomment);
    DataResponse r = new DataResponse();
    try {
      var token = await getToken();
      //print(token);
      dio.options.headers["authorization"] = "Bearer " + token;
      int id = await getId();
      //print(id);
      var response = await dio.post('/review/seller', data: {
        "reviewerId": id,
        "sellerId": sellerId,
        "review": sellercomment,
        "rating": ratings,
      });
      debugPrint("from api service REVIEWSELLER: "+response.statusCode.toString());
      print(response.data);
      if (response == null) {
        print("response null");
        return false;
      } else {
        var responsebody = response.data;
        r = getResponse(response.statusCode, responsebody);
        print(responsebody);
        print(r.message);
        return true;
      }
    } on DioError catch (e) {
      print(e);
      print(e.response.statusCode);
      print(e.response.data);
      if (e.response.data != null) {
        Map<String, dynamic> map = e.response.data;
        if (map.containsKey("message")) {
          r.message = map["message"];
          print(r.message);
        } else
          print("Unable to order");
      } else {
        print("unable to order");
      }
      return false;
    }
  }

  Future<bool> forgetPassword(String email) async {
    DataResponse r = new DataResponse();
    try {
      var response = await dio.post('/user/forgetPassword/', data: {
        "email": email,
      });

      print(response.data);
      if (response == null) {
        print("response null");
        return false;
      } else {
        var responsebody = response.data;
        r = getResponse(response.statusCode, responsebody);
        print(responsebody);
        print(r.message);
        return true;
      }
    } on DioError catch (e) {
      print(e);
      print(e.response.statusCode);
      print(e.response.data);
      if (e.response.data != null) {
        Map<String, dynamic> map = e.response.data;
        if (map.containsKey("message")) {
          r.message = map["message"];
          print(r.message);
        } else
          print("Unable");
      } else {
        print("unable");
      }
      return false;
    }
  }

  Future<DataResponse<dynamic>> updateProduct(int id, String description,
      int quantity, int price, List<File> images) async {
    DataResponse r = new DataResponse();
    List<String> imagepath = await uploadImages(images);
    try {
      var token = await getToken();
      print(token);

      dio.options.headers["authorization"] = token;
      var response = await dio.put(
        '/product',
        data: {
          "id": id,
          "description": description,
          "quantity": quantity,
          "price": price,
          "metric": "kg",
          "images": imagepath
        },
      );
      if (response == null) {
        print("respnse null");
        r.success = false;
        r.message = "Unable to Update Product";
        r.data = null;
      } else {
        var responsebody = response.data;
        r = getResponse(response.statusCode, responsebody);
        print("response chha");
        print(responsebody);
        r.message = "Product Updated Successfully";
      }
    } on DioError catch (e) {
      print(e);
      print(e.response.statusCode);
      if (e.response.data != null) {
        Map<String, dynamic> map = e.response.data;
        if (map.containsKey("message")) {
          r.message = map["message"];
        } else
          r.message = "Unable to Update Product";
      } else {
        r.message = "Unable to Update Product";
      }
      r.success = false;

      r.data = null;
      debugPrint(r.message);
    }
    return r;
  }

  Future<DataResponse<dynamic>> deleteProduct(
    int id,
  ) async {
    int productId = id;
    DataResponse r = new DataResponse();
    try {
      print(productId);
      var token = await getToken();
      print(token);
      dio.options.headers["authorization"] = "Bearer " + token;
      var response = await dio.delete('/product/id/${productId}');
      if (response == null) {
        print("respnse null");
        r.success = false;
        r.message = "Unable to delete product";
        r.data = null;
        print(r.message);
      } else {
        var responsebody = response.data;
        r = getResponse(response.statusCode, responsebody);
        r.data = "Success";
        print("response chha");
        print(responsebody);
        print(r.message);
      }
    } on DioError catch (e) {
      print(e);
      print(e.response.statusCode);
      print(e.response.data);
      if (e.response.data != null) {
        Map<String, dynamic> map = e.response.data;
        if (map.containsKey("message")) {
          r.message = map["message"];
        } else
          r.message = "Unable to delete product";
      } else {
        r.message = "Unable to delete product";
      }
      r.success = false;
      r.data = null;
    }
    return r;
  }

  Future<DataResponse<dynamic>> register(
      String phone,
      String firstName,
      String lastName,
      String email,
      String countryCode,
      String password,
      String confirmPassword,
      File image) async {
    DataResponse r = new DataResponse();
    User u = new User();
    print(".........");
    print(image.path);
    print(image.path.split('/').last);
    print(".........");
    String imagepath = await uploadImage(image);
    dio.options.headers["content-type"] = "application/json";

    u.phoneNo = phone;
    u.firstName = firstName;
    u.lastName = lastName;
    u.email = email;

    Location loc = await locateUser();
    Location l = new Location();
    l.lat = loc.lat;
    l.long = loc.long;
    u.location = l;
    u.password = password;
    u.profilePicture = imagepath;
    u.tags = [];
    u.views = 0;
    u.countryCode = "$countryCode";
    u.isActive = true;
    u.isVerified = true;
    u.role = "user";
    print(u.toString());
    try {
      print(password);
      print(confirmPassword);
      if (password == confirmPassword) {
        debugPrint(u.toJson().toString());
        var response = await dio.post('/user', data: u.toJson());
        print(response.statusCode);
        print(response.data);

        if (response == null) {
          print("respnse null");
          r.success = false;
          r.message = "Unable to register";
          r.data = null;
          print(r.message);
        } else {
          var responsebody = response.data;
          r = getResponse(response.statusCode, responsebody);
          if (r.success) {
            var userModel = User.fromJson(responsebody);
            r.data = userModel;
          }
          print("response chha");
          print(responsebody);
          print(r.message);
        }
      } else {
        r.success = false;
        r.message = "passwords do not match";
      }
    } on DioError catch (e) {
      print(e);
      print(e.error);
      print(e.response.statusCode);
      print(e.response.data);
      if (e.response.data != null) {
        Map<String, dynamic> map = e.response.data;
        if (map.containsKey("message")) {
          r.message = map["message"];
        } else
          r.message = "Unable to register";
      } else {
        r.message = "Unable to register";
      }
      r.success = false;
      r.data = null;
    }
    return r;
  }

  Future<String> uploadImage(File image) async {
    try {
      var token = await getToken();
      dio.options.headers["authorization"] = token;
      print(".........");
      print(image.path);
      print(image.path.split('/').last);
      print(".........");
      print("Image Name:" + image.path.split('/').last);
      print("image Path:" + image.path);
      FormData formData = new FormData();
      var file = await MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last,
      );
      dio.options.headers["content-type"] = "multipart/form-data";

      formData.files.add(MapEntry('file', file));
      var response = await dio.post(
        '/media/uploadImage',
        data: formData,
      );
      dio.options.headers["content-type"] = "application/json";
      print(response);
      print("imaage uploaded successfully");
      String imagepath = response.data["image"].toString();
      return imagepath;
    } on DioError catch (e) {
      print("UPLOAD IMAGE ERROR......");
      print(e);
      print(e.message);
    }
    return "";
  }

  Future<List<String>> uploadImages(List<File> image) async {
    try {
      var token = await getToken();
      print(token);
      for (var i = 0; i < image.length; i++) {
        print(".........");
        print(image[i].path);
        print(image[i].path.split('/').last);
        print(".........");
      }
      dio.options.headers["authorization"] = "Bearer " + token;

      //FormData images = FormData.fromMap({"files": files});
      var formData = FormData();
      for (var i = 0; i < image.length; i++) {
        var file = await MultipartFile.fromFile(
          image[i].path,
          filename: image[i].path.split('/').last,
        );
        formData.files.add(MapEntry('file' + i.toString(), file));
      }
      dio.options.headers["content-type"] = "multipart/form-data";
      var response = await dio.post('/media/uploadImages', data: formData);
      print(response);
      print("imaage uploaded successfully");
      List<String> imagepath = response.data["images"].map<String>((dynamic e) {
        return e.toString();
      }).toList();
      dio.options.headers["content-type"] = "application/json";
      print("++++++++++++++++++++++++++");
      print(imagepath);
      return imagepath;
    } on DioError catch (e) {
      print("UPLOAD IMAGE ERROR......");
      print(e);
      print(e.message);
      print(e.error);
    }
  }

  Future<DataResponse<dynamic>> addProduct(String name, String description,
      int categoryId, int quantity, int price, List<File> image) async {
    int sellerId = await getId();
    DataResponse r = new DataResponse();
    Location loc = await locateUser();
    Product p = new Product();
    for (var i = 0; i < image.length; i++) {
      print(".........");
      print(image[i].path);
      print(image[i].path.split('/').last);
      print(".........");
    }
    List<String> images = await uploadImages(image);
    print(images);
    p.title = name;
    p.categoryId = categoryId;
    p.description = description;
    p.quantity = quantity;
    p.metric = "kg";
    p.sellerId = sellerId;
    Location l = new Location();
    l.lat = loc.lat;
    l.long = loc.long;
    p.location = l;
    p.price = price;
    p.images = images;
    p.views = 0;
    p.isDeleted = false;
    try {
      debugPrint(p.toJson().toString());
      var token = await getToken();
      print(token);
      dio.options.headers["authorization"] = "Bearer " + token;
      var response = await dio.post(
        '/product',
        data: p.toJson(),
      );
      print(response.statusCode);
      print(response.data);

      if (response == null) {
        print("respnse null");
        r.success = false;
        r.message = "Unable to add product";
        r.data = null;
      } else {
        var responsebody = response.data;
        r = getResponse(response.statusCode, responsebody);
        if (r.success) {
          var userModel = User.fromJson(responsebody);
          r.data = userModel;
        }
        print("response chha");
        print(responsebody);
        r.message = "Product Added Successfully";
      }
    } on DioError catch (e) {
      print(e);
      print(e.response.statusCode);
      if (e.response.data != null) {
        Map<String, dynamic> map = e.response.data;
        if (map.containsKey("message")) {
          r.message = map["message"];
        } else
          r.message = "Unable to product";
      } else {
        r.message = "Unable to add product";
      }
      r.success = false;

      r.data = null;
      debugPrint(r.message);
    }
    return r;
  }

  Future<DataResponse<dynamic>> editUser(String firstName, String lastName,
      String phone, String email, String countryCode, File image) async {
    DataResponse r = new DataResponse();
    String imagepath = await uploadImage(image);
    Location loc = await locateUser();
    Location l = new Location();
    l.lat = loc.lat;
    l.long = loc.long;
    try {
      var id = await getId();
      print(id);
      var token = await getToken();
      print(token);
      dio.options.headers["authorization"] = "Bearer " + token;
      var response = await dio.put('/user/${id.toString()}', data: {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNo": phone,
        "profilePicture": imagepath,
        "location": {"lat": loc.lat, "long": loc.long},
        "countryCode": "+$countryCode",
        "tags": [],
        "role": "user"
      });
      print(response.statusCode);
      print(response.data);

      if (response == null) {
        print("respnse null");
        r.success = false;
        r.message = "Unable to Edit Profile";
        r.data = null;
      } else {
        var responsebody = response.data;
        r = getResponse(response.statusCode, responsebody);
        if (r.success) {
          var userModel = User.fromJson(responsebody);
          r.data = userModel;
        }
        print("response chha");
        print(responsebody);
        r.message = "Profile Edited Successfully";
      }
    } on DioError catch (e) {
      print(e);
      print(e.response.statusCode);
      if (e.response.data != null) {
        Map<String, dynamic> map = e.response.data;
        if (map.containsKey("message")) {
          r.message = map["message"];
        } else
          r.message = "Unable to edit profile";
      } else {
        r.message = "Unable to edit profile";
      }
      r.success = false;

      r.data = null;
      debugPrint(r.message);
    }
    return r;
  }

  Future<User> getUserDetail(int id) async {
    DataResponse r = new DataResponse();
    try {
      debugPrint("Api service id check: ${id.toString()}");
      var token = await getToken();
      print(token);
      dio.options.headers["authorization"] = "Bearer " + token;
      print("After token");
      var response = await dio.get('/user/${id.toString()}');
      if (response.statusCode == 200) {
        debugPrint("response code 200 received");
        return User.fromJson(response.data as Map<String, dynamic>);
      } else {
        print(response.statusCode);
        return throw Exception("No data ");
      }
    } on DioError catch (e) {
      print(e);
      print(e.message);
      print(e.response.data);
      if (e.response.data != null) {
        Map<String, dynamic> map = e.response.data;
        if (map.containsKey("message")) {
          r.message = map["message"];
        } else
          r.message = "Unable to Fetch User";
      } else {
        r.message = "Unable to Fetch User";
      }
      r.success = false;
      r.data = null;
      debugPrint(r.message);
      return throw Exception("Error to fetch User");
    }
  }

  Future<User> getMyProfile() async {
    DataResponse r = new DataResponse();
    try {
      var token = await getToken();
      print(token);
      dio.options.headers["authorization"] = token;
      var response = await dio.get('/myprofile');
      print(response);
      if (response.statusCode == 200) {
        print("Responce chha");
        print(response.data);
        return User.fromJson(response.data as Map<String, dynamic>);
      } else {
        print(response.statusCode);
        return throw Exception("No data ");
      }
    } on DioError catch (e) {
      print(e);
      print(e.response.data);
      if (e.response.data != null) {
        Map<String, dynamic> map = e.response.data;
        if (map.containsKey("message")) {
          r.message = map["message"];
        } else
          r.message = "Unable to fetch Profile";
      } else {
        r.message = "Unable to fetch Profile";
      }
      r.success = false;
      r.data = null;
      debugPrint(r.message);
      return throw Exception("Error to fetch profile");
    }
  }

  Future<List<Cat>> getCategory() async {
    try {
      var response = await dio.get('/category/tree');
      if (response.statusCode == 200) {
        final List<Cat> category = (response.data as List)?.map((dynamic e) {
          print(e);
          return e == null ? null : Cat.fromJson(e as Map<String, dynamic>);
        })?.toList();
        debugPrint('$category');
        return category;
      } else {
        print(response.statusCode);
        return throw Exception("No data ");
      }
    } catch (e) {
      print(e);
      return throw Exception("Error to fetch product");
    }
  }

  Future<List<Product>> getMyProduct() async {
    DataResponse r = new DataResponse();
    try {
      var token = await getToken();
      print(token);
      dio.options.headers["authorization"] = "Bearer " + token;
      var response = await dio.get('/myproducts');
      if (response.statusCode == 200) {
        debugPrint("response code 200 received");
        final List<Product> products =
            (response.data as List)?.map((dynamic e) {
          print(e);
          return e == null ? null : Product.fromJson(e as Map<String, dynamic>);
        })?.toList();
        debugPrint('$products');
        return products;
      } else {
        print(response.statusCode);
        return throw Exception("No data ");
      }
    } on DioError catch (e) {
      print(e);
      print(e.response.data);
      if (e.response.data != null) {
        Map<String, dynamic> map = e.response.data;
        if (map.containsKey("message")) {
          r.message = map["message"];
        } else
          r.message = "Unable to Fetch Product";
      } else {
        r.message = "Unable to Fetch Product";
      }
      r.success = false;

      r.data = null;
      debugPrint(r.message);
      return throw Exception("Error to fetch product");
    }
    //return r;
  }

  Future<List<Product>> getProductsByCategoryId(int categoryId) async {
    DataResponse r = new DataResponse();
    try {
      var token = await getToken();
      print(token);
      dio.options.headers["authorization"] = "Bearer " + token;
      var response = await dio.get('/product/categoryid/${categoryId}');
      if (response.statusCode == 200) {
        debugPrint("response code 200 received");
        final List<Product> products =
            (response.data as List)?.map((dynamic e) {
          print(e);
          return e == null ? null : Product.fromJson(e as Map<String, dynamic>);
        })?.toList();
        debugPrint('$products');
        return products;
      } else {
        print(response.statusCode);
        return throw Exception("No data ");
      }
    } on DioError catch (e) {
      print(e);
      print(e.response.data);
      if (e.response.data != null) {
        Map<String, dynamic> map = e.response.data;
        if (map.containsKey("message")) {
          r.message = map["message"];
        } else
          r.message = "Unable to Fetch Product";
      } else {
        r.message = "Unable to Fetch Product";
      }
      r.success = false;

      r.data = null;
      debugPrint(r.message);
      return throw Exception("Error to fetch product");
    }
    //return r;
  }

  Future<List<Product>> getTrendingProduct() async {
    DataResponse r = new DataResponse();
    try {
      Location l = Location();
      l = await locateUser();
      var response = await dio
          .post('/product/trending', data: {"lat": l.lat, "long": l.long});
      if (response.statusCode == 200) {
        debugPrint("response code 200 received");
        final List<Product> products =
            (response.data as List)?.map((dynamic e) {
          print(e);
          return e == null ? null : Product.fromJson(e as Map<String, dynamic>);
        })?.toList();
        debugPrint('$products');
        return products;
      } else {
        print(response.statusCode);
        return throw Exception("No data ");
      }
    } on DioError catch (e) {
      print(e);
      print(e.response.data);
      if (e.response.data != null) {
        Map<String, dynamic> map = e.response.data;
        if (map.containsKey("message")) {
          r.message = map["message"];
        } else
          r.message = "Unable to Fetch Product";
      } else {
        r.message = "Unable to Fetch Product";
      }
      r.success = false;

      r.data = null;
      debugPrint(r.message);
      return throw Exception("Error to fetch product");
    }
    //return r;
  }

  Future<List<OrderModel>> getOrderedProduct() async {
    DataResponse r = new DataResponse();
    try {
      var token = await getToken();
      print(token);
      dio.options.headers["authorization"] = token;
      var response = await dio.get('/myOrders');
      if (response.statusCode == 200) {
        final List<OrderModel> order =
            (response.data as List)?.map((dynamic e) {
          print(e);
          return e == null
              ? null
              : OrderModel.fromJson(e as Map<String, dynamic>);
        })?.toList();
        debugPrint('$order');
        return order;
      } else {
        print(response.statusCode);
        return throw Exception("No data ");
      }
    } on DioError catch (e) {
      print(e);
      print(e.response.data);
      if (e.response.data != null) {
        Map<String, dynamic> map = e.response.data;
        if (map.containsKey("message")) {
          r.message = map["message"];
        } else
          r.message = "Unable to Fetch orders";
      } else {
        r.message = "Unable to Fetch orders";
      }
      r.success = false;

      r.data = null;
      debugPrint(r.message);
      return throw Exception("Error to fetch orders");
    }
    //return r;
  }

  Future<List<OrderModel>> receivedOrders() async {
    DataResponse r = new DataResponse();
    try {
      var token = await getToken();
      print(token);
      dio.options.headers["authorization"] = token;
      var response = await dio.get('/receivedOrders');
      if (response.statusCode == 200) {
        final List<OrderModel> order =
            (response.data as List)?.map((dynamic e) {
          print(e);
          return e == null
              ? null
              : OrderModel.fromJson(e as Map<String, dynamic>);
        })?.toList();
        debugPrint('$order');
        return order;
      } else {
        print(response.statusCode);
        return throw Exception("No data ");
      }
    } on DioError catch (e) {
      print(e);
      print(e.response.data);
      if (e.response.data != null) {
        Map<String, dynamic> map = e.response.data;
        if (map.containsKey("message")) {
          r.message = map["message"];
        } else
          r.message = "Unable to Fetch orders";
      } else {
        r.message = "Unable to Fetch orders";
      }
      r.success = false;

      r.data = null;
      debugPrint(r.message);
      return throw Exception("Error to fetch orders");
    }
    //return r;
  }

  Future<List<Product>> getreceivedOrders() async {
    DataResponse r = new DataResponse();
    try {
      var token = await getToken();
      print(token);
      dio.options.headers["authorization"] = token;
      var response = await dio.get('/receivedOrders');
      if (response.statusCode == 200) {
        debugPrint("response code 200 received");
        final List<Product> products =
            (response.data as List)?.map((dynamic e) {
          print(e);
          return e == null ? null : Product.fromJson(e as Map<String, dynamic>);
        })?.toList();
        debugPrint('$products');
        return products;
      } else {
        print(response.statusCode);
        return throw Exception("No data ");
      }
    } on DioError catch (e) {
      print(e);
      print(e.response.data);
      if (e.response.data != null) {
        Map<String, dynamic> map = e.response.data;
        if (map.containsKey("message")) {
          r.message = map["message"];
        } else
          r.message = "Unable to Fetch orders";
      } else {
        r.message = "Unable to Fetch orders";
      }
      r.success = false;

      r.data = null;
      debugPrint(r.message);
      return throw Exception("Error to fetch orders");
    }
    //return r;
  }

  Future<Product> getProductById(int pnumber) async {
    DataResponse r = new DataResponse();
    try {
      var token = await getToken();
      print(token);
      dio.options.headers["authorization"] = token;
      var response = await dio.get('/product/id/${pnumber.toString()}');
      if (response.statusCode == 200) {
        return Product.fromJson(response.data as Map<String, dynamic>);
      } else {
        print(response.statusCode);
        return throw Exception("No data ");
      }
    } catch (e) {
      print(e);
      print(e.response.data);
      if (e.response.data != null) {
        Map<String, dynamic> map = e.response.data;
        if (map.containsKey("message")) {
          r.message = map["message"];
        } else
          r.message = "Unable to Fetch Product";
      } else {
        r.message = "Unable to Fetch Product";
      }
      r.success = false;
      r.data = null;
      debugPrint(r.message);
      return throw Exception("Error to fetch product");
    }
    //return r;
  }

  Future<List<Product>> getSearchProduct(
    String searchValue,
  ) async {
    DataResponse r = new DataResponse();
    try {
      Location l = Location();
      l = await locateUser();
      var response = await dio.get('/product/search/' + searchValue);
      if (response.statusCode == 200) {
        final List<Product> products =
            (response.data as List)?.map((dynamic e) {
          print(e);
          return e == null ? null : Product.fromJson(e as Map<String, dynamic>);
        })?.toList();
        debugPrint('$products');
        return products;
      } else {
        print(response.statusCode);
        return throw Exception("No data ");
      }
    } on DioError catch (e) {
      print(e);
      print(e.response.data);
      if (e.response.data != null) {
        Map<String, dynamic> map = e.response.data;
        if (map.containsKey("message")) {
          r.message = map["message"];
        } else
          r.message = "Unable to Fetch Product";
      } else {
        r.message = "Unable to Fetch Product";
      }
      r.success = false;

      r.data = null;
      debugPrint(r.message);
      return throw Exception("Error to fetch product");
    }
    //return r;
  }

  Future<List<Product>> getProductsNearMe() async {
    DataResponse r = new DataResponse();
    try {
      Location l = Location();
      l = await locateUser();
      var response = await dio
          .post('/product/nearme', data: {"lat": l.lat, "long": l.long});
      if (response.statusCode == 200) {
        final List<Product> products =
            (response.data as List)?.map((dynamic e) {
          print(e);
          return e == null ? null : Product.fromJson(e as Map<String, dynamic>);
        })?.toList();
        debugPrint('$products');
        return products;
      } else {
        print(response.statusCode);
        return throw Exception("No data ");
      }
    } on DioError catch (e) {
      print(e);
      print(e.response.data);
      if (e.response.data != null) {
        Map<String, dynamic> map = e.response.data;
        if (map.containsKey("message")) {
          r.message = map["message"];
        } else
          r.message = "Unable to Fetch Product";
      } else {
        r.message = "Unable to Fetch Product";
      }
      r.success = false;
      r.data = null;
      debugPrint(r.message);
      return throw Exception("Error to fetch product");
    }
    //return r;
  }

  Future<List<Product>> getProducts() async {
    try {
      var response = await dio.get('/products?page=1&per_page=10');
      if (response.statusCode == 200) {
        //var jsondata = json.decode(response.data['data']);
        //response.data['data']['images'] = json.decode(response.data['data']['images']);
        final List<Product> products =
            (response.data['data'] as List)?.map((dynamic e) {
          print(e);
          return e == null ? null : Product.fromJson(e as Map<String, dynamic>);
        })?.toList();
        debugPrint('$products');
        return products;
      } else {
        print(response.statusCode);
        return throw Exception("No data ");
      }
    } catch (e) {
      print(e);
      //log(e);
      return throw Exception("Error to fetch product");
    }
  }

  Future<List<ReviewModel>> getProductReview(int pnumber) async {
    try {
      var token = await getToken();
      print(token);
      dio.options.headers["authorization"] = token;
      var response = await dio.get('/review/product/id/${pnumber.toString()}');
      if (response.statusCode == 200) {
        final List<ReviewModel> reviews =
            (response.data as List)?.map((dynamic e) {
          print(e);
          return e == null
              ? null
              : ReviewModel.fromJson(e as Map<String, dynamic>);
        })?.toList();
        return reviews;
      } else {
        print(response.statusCode);
        return throw Exception("No data ");
      }
    } catch (e) {
      print(e);
      return throw Exception("Error to fetch Reviews");
    }
  }

  Future<HomePageModel> getHomePageData() async {
    try {
      Location l;
      l = await locateUser();
      var response = await dio.post('/homepage?page=1&per_page=5',
          data: {'lat': l.lat, 'long': l.long});
      if (response.statusCode == 200) {
        return HomePageModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        print(response.statusCode);
        return throw Exception("No data ");
      }
    } catch (e) {
      print(e);
      return throw Exception("Error to fetch product");
    }
  }
}

DataResponse<dynamic> getResponse(int status, Map<String, dynamic> response) {
  DataResponse res = DataResponse();

  switch (status) {
    case 200:
    case 201:
      res.success = true;
      break;
    case 400:
    case 422:
      res.message = "Invalid request";
      break;
    case 401:
    case 403:
      res.message = "Unauthorized";
      break;
    default:
      res.success = false;
  }
  if (response.containsKey("message")) {
    res.message = response["message"];
  }
  return res;
}
