
import 'package:haatbajar/models/productModel.dart';
import 'package:haatbajar/models/sellermodel.dart';

class OrderModel {
  int id;
  int productId;
  int buyerId;
  String status;
  int sellerId;
  int quantity;
  String message;
  String createdAt;
  String updatedAt;
  Seller buyer;
  Seller seller;
  Product product;

  OrderModel(
      {this.id,
      this.productId,
      this.buyerId,
      this.status,
      this.sellerId,
      this.quantity,
      this.message,
      this.createdAt,
      this.updatedAt,
      this.buyer,
      this.seller,
      this.product});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    buyerId = json['buyerId'];
    status = json['status'];
    sellerId = json['sellerId'];
    quantity = json['quantity'];
    message = json['message'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    buyer =
        json['buyer'] != null ? new Seller.fromJson(json['buyer']) : null;
    seller = json['seller'] != null
        ? new Seller.fromJson(json['seller'])
        : null;
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productId'] = this.productId;
    data['buyerId'] = this.buyerId;
    data['status'] = this.status;
    data['sellerId'] = this.sellerId;
    data['quantity'] = this.quantity;
    data['message'] = this.message;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.buyer != null) {
      data['buyer'] = this.buyer.toJson();
    }
    if (this.seller != null) {
      data['seller'] = this.seller.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    return data;
  }
}
