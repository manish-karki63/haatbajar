import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haatbajar/api/api_service.dart';
import 'package:haatbajar/models/productModel.dart';
import 'package:haatbajar/ui/home/HomePage.dart';
import 'package:image_picker/image_picker.dart';

class EditProduct extends StatefulWidget {
  final Product product;
  EditProduct({Key key, this.product}) : super(key: key);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  List<File> _image = [];
  final _formKey = GlobalKey<FormState>();
  TextEditingController descriptionController;
  TextEditingController quantityController;
  TextEditingController priceController;
  bool isLoading = false;
  ApiService service;
  int id;
  String description;
  int quantity;
  int price;

  @override
  void initState() {
    super.initState();
    service = ApiService();
    setState(() {
      descriptionController =
          new TextEditingController(text: widget.product.description);
      quantityController =
          new TextEditingController(text: widget.product.quantity.toString());
      priceController =
          new TextEditingController(text: widget.product.price.toString());
    });
  }

  void openCamera() async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      _image.add(image);
      print(image.path);
    }
    setState(() {});
  }

  void openGallery() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _image.add(image);
      print(image.path);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[900],
        textTheme: TextTheme(
            title: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        )),
        centerTitle: true,
        title: new Text("Edit Product"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Form(
              key: _formKey,
              child: new Theme(
                data: new ThemeData(
                    primaryColor: Colors.lightBlue[900],
                    accentColor: Colors.red,
                    inputDecorationTheme: new InputDecorationTheme(
                        labelStyle: new TextStyle(
                            fontSize: 18.0, color: Colors.lightBlue[900]))),
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      // Stack(
                      //   children: [
                      //     // new Container(
                      //     //     height: 290,
                      //     //     child: _image == null
                      //     //         ? Image.asset("lib/assets/category/food.jpg")
                      //     //         //: Image.file(_image[0]),
                      //     //         : Image.asset(
                      //     //             "lib/assets/category/food.jpg")),
                      //     new Positioned(
                      //       top: 1,
                      //       right: 1,
                      //       child: Container(
                      //         height: 50,
                      //         width: 50,
                      //         child: Column(
                      //           children: [
                      //             //getImagePicker(),
                      //             IconButton(
                      //                 icon: Icon(Icons.add),
                      //                 onPressed: () {
                      //                   AlertDialog alert = AlertDialog(
                      //                     title: Text("AlertDialog"),
                      //                     content: Column(
                      //                       children: [
                      //                         FlatButton(
                      //                             onPressed: () {
                      //                               openCamera();
                      //                             },
                      //                             child: Row(
                      //                               children: [
                      //                                 Icon(Icons.add_a_photo),
                      //                                 Text("open Camera")
                      //                               ],
                      //                             )),
                      //                         FlatButton(
                      //                             onPressed: () {
                      //                               openGallery();
                      //                             },
                      //                             child: Row(
                      //                               children: [
                      //                                 Icon(Icons.photo_library),
                      //                                 Text("open gallery")
                      //                               ],
                      //                             )),
                      //                       ],
                      //                     ),
                      //                     actions: [
                      //                       FlatButton(
                      //                           onPressed: () {
                      //                             Navigator.pop(context);
                      //                           },
                      //                           child: Text("cancel")),
                      //                     ],
                      //                   );

                      //                   // show the dialog
                      //                   showDialog(
                      //                     context: context,
                      //                     builder: (BuildContext context) {
                      //                       return alert;
                      //                     },
                      //                   );
                      //                 }),
                      //           ],
                      //         ),
                      //         decoration: BoxDecoration(
                      //           color: Colors.deepOrange,
                      //           borderRadius:
                      //               BorderRadius.all(Radius.circular(30.0)),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      new TextFormField(
                        controller: descriptionController,
                        decoration: new InputDecoration(
                            icon: Icon(
                              Icons.description,
                              color: Colors.lightBlue[900],
                            ),
                            labelText: "Description",
                            labelStyle: TextStyle(
                              color: Colors.lightBlue[900],
                              fontSize: 18.0,
                              fontFamily: "oswald",
                            )),
                        keyboardType: TextInputType.text,
                      ),
                      new TextFormField(
                        controller: quantityController,
                        decoration: new InputDecoration(
                            icon: Icon(
                              Icons.description,
                              color: Colors.lightBlue[900],
                            ),
                            labelText: "Quantity",
                            labelStyle: TextStyle(
                              color: Colors.lightBlue[900],
                              fontSize: 18.0,
                              fontFamily: "oswald",
                            )),
                        keyboardType: TextInputType.number,
                      ),
                      new TextFormField(
                        controller: priceController,
                        decoration: new InputDecoration(
                            icon: Icon(
                              Icons.attach_money,
                              color: Colors.lightBlue[900],
                            ),
                            labelText: "Price",
                            labelStyle: TextStyle(
                              color: Colors.lightBlue[900],
                              fontSize: 18.0,
                              fontFamily: "oswald",
                            )),
                        keyboardType: TextInputType.number,
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                      ),
                      getImagePicker(),
                      IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            AlertDialog alert = AlertDialog(
                              title: Text("AlertDialog"),
                              content: Column(
                                children: [
                                  FlatButton(
                                      onPressed: () {
                                        openCamera();
                                      },
                                      child: Row(
                                        children: [
                                          Icon(Icons.add_a_photo),
                                          Text("open Camera")
                                        ],
                                      )),
                                  FlatButton(
                                      onPressed: () {
                                        openGallery();
                                      },
                                      child: Row(
                                        children: [
                                          Icon(Icons.photo_library),
                                          Text("open gallery")
                                        ],
                                      )),
                                ],
                              ),
                              actions: [
                                FlatButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("cancel")),
                              ],
                            );

                            // show the dialog
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                          }),
                      new MaterialButton(
                        onPressed: () {
                          id = widget.product.id;
                          description = descriptionController.text;
                          quantity = int.parse(quantityController.text);
                          price = int.parse(priceController.text);
                          setState(() {
                            isLoading = true;
                          });

                          service
                              .updateProduct(
                                  id, description, quantity, price, _image)
                              .then(
                            (value) {
                              print(value.data);
                              if (!value.success) {
                                Fluttertoast.showToast(
                                    msg: value.message,
                                    textColor: Colors.black,
                                    backgroundColor: Colors.amber);
                                setState(() {
                                  isLoading = false;
                                });
                              } else {
                                Fluttertoast.showToast(
                                    msg: value.message,
                                    textColor: Colors.black,
                                    backgroundColor: Colors.amber);
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => new HomePage()));
                              }
                            },
                          );
                        },
                        height: 40,
                        minWidth: 100,
                        color: Colors.teal,
                        textColor: Colors.white,
                        child: Text(
                          "Confirm Edit",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getImagePicker() {
    return new GridView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: _image.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 0.0,
        mainAxisSpacing: 0.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        print("GridLayout");
        return new Container(child: Image.file(_image[index]));
      },
    );
  }
}
