class Cat {
  int id;
  String categoryName;
  String categoryImage;
  int head;
  bool isActive;
  List<Cat> subcategory;
  Cat(
      {this.id,
      this.categoryName,
      this.categoryImage,
      this.head,
      this.isActive,
      this.subcategory});

  factory Cat.fromJson(Map<String, dynamic> json) {
    var subCategory = json['subcategory'];
    final List<Cat> subCategories = (subCategory as List)?.map((dynamic e) {
      print(e);
      return e == null ? null : Cat.fromJson(e as Map<String, dynamic>);
    })?.toList();

    return Cat(
      id: json['id'] != null ? json['id'] : 0,
      categoryName: json['categoryName'] != null ? json['categoryName'] : "",
      categoryImage: json['categoryImage'] != null ? json['categoryImage'] : "",
      head: json['head'] != null ? json['head'] : 0,
      isActive: json['isActive'] != null ? json['isActive'] : true,
      subcategory: subCategories,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryName'] = this.categoryName;
    data['categoryImage'] = this.categoryImage;
    data['head'] = this.head;
    data['isActive'] = this.isActive;
    data['subcategory'] = this.subcategory;
    return data;
  }
}
