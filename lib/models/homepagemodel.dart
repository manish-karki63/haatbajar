import 'package:haatbajar/models/categorymodel.dart';
import 'package:haatbajar/models/productModel.dart';

class HomePageModel {
  String name;
  String version;
  String versionName;
  String timestamp;
  List<Product> newProduct;
  List<Product> trendingProduct;
  List<Cat> allCategory;
  List<Product> nearMeProduct;

  HomePageModel(
      {this.name,
      this.version,
      this.versionName,
      this.timestamp,
      this.newProduct,
      this.trendingProduct,
      this.allCategory,
      this.nearMeProduct});

  HomePageModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? json['name'] : "";
    version = json['version'] != null ? json['version'] : "";
    versionName = json['version_name'] != null ? json['version_name'] : "";
    timestamp = json['timestamp'] != null ? json['timestamp'] : "";
    if (json['new_product'] != null) {
      newProduct = new List<Product>();
      json['new_product'].forEach((v) {
        newProduct.add(new Product.fromJson(v));
      });
    }
    if (json['trending_product'] != null) {
      trendingProduct = new List<Product>();
      json['trending_product'].forEach((v) {
        trendingProduct.add(new Product.fromJson(v));
      });
    }
    if (json['all_category'] != null) {
      allCategory = new List<Cat>();
      json['all_category'].forEach((v) {
        allCategory.add(new Cat.fromJson(v));
      });
    }
    if (json['near_me_product'] != null) {
      nearMeProduct = new List<Product>();
      json['near_me_product'].forEach((v) {
        nearMeProduct.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['version'] = this.version;
    data['version_name'] = this.versionName;
    data['timestamp'] = this.timestamp;
    if (this.newProduct != null) {
      data['new_product'] = this.newProduct.map((v) => v.toJson()).toList();
    }
    if (this.trendingProduct != null) {
      data['trending_product'] =
          this.trendingProduct.map((v) => v.toJson()).toList();
    }
    if (this.allCategory != null) {
      data['all_category'] = this.allCategory.map((v) => v.toJson()).toList();
    }
    if (this.nearMeProduct != null) {
      data['near_me_product'] =
          this.nearMeProduct.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
