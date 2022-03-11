import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haatbajar/api/api_service.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<File> _image = [];
  var _value;
  TextEditingController itemnameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  ApiService service;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    service = ApiService();
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
        title: new Text("Add New Product"),
      ),
      body:  isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          :  new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          /*new Image(
            image: new AssetImage("lib/assets/login/login2.jpg"),
            fit: BoxFit.cover,
            color: Colors.black87,
            colorBlendMode: BlendMode.darken,
          ),*/
          SingleChildScrollView(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Form(
                  child: new Theme(
                    data: new ThemeData(
                        primaryColor: Colors.lightBlue[900],
                        accentColor: Colors.red,
                        inputDecorationTheme: new InputDecorationTheme(
                            labelStyle: new TextStyle(fontSize: 24.0))),
                    child: new Container(
                      padding: const EdgeInsets.all(15.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Padding(
                              padding: const EdgeInsets.only(top: 15.0)),
                          /* new Padding(
                              padding: const EdgeInsets.only(top: 20.0)),*/
                          new TextFormField(
                            controller: itemnameController,
                            decoration: new InputDecoration(
                                labelText: "Item Name",
                                labelStyle: TextStyle(
                                  color: Colors.lightBlue[900],
                                  fontSize: 20.0,
                                )),
                            keyboardType: TextInputType.text,
                          ),
                          new Padding(
                              padding: const EdgeInsets.only(top: 15.0)),
                          new TextFormField(
                            controller: descriptionController,
                            decoration: new InputDecoration(
                                labelText: "Item Description",
                                labelStyle: TextStyle(
                                  color: Colors.lightBlue[900],
                                  fontSize: 20.0,
                                )),
                            keyboardType: TextInputType.text,
                          ),
                          Padding(padding: const EdgeInsets.only(top: 15.0)),
                          Row(
                            children: [
                              new Container(
                                width: 280,
                                child: FutureBuilder(
                                  future: service.getCategory(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasError) {
                                      return Text(
                                        'Error Found ',
                                      );
                                    } else if (snapshot.hasData) {
                                      return DropdownButton<String>(
                                        value: _value,
                                        hint: Text(
                                          "Select Category",
                                          style: TextStyle(
                                            color: Colors.lightBlue[900],
                                            fontSize: 18.0,
                                            fontFamily: "oswald",
                                          ),
                                        ),
                                        style: TextStyle(
                                          fontSize: 20.0,
                                        ),
                                        onChanged: (String value) {
                                          print(value);
                                          setState(() {
                                            _value = value;
                                          });
                                        },
                                        items: snapshot.data
                                            .map<
                                                DropdownMenuItem<
                                                    String>>((gc) =>
                                                new DropdownMenuItem<String>(
                                                  child: new Text(
                                                    gc.categoryName,
                                                    style: TextStyle(
                                                        fontSize: 20.0,
                                                        color: Colors
                                                            .lightBlue[900]),
                                                  ),
                                                  value: gc.id.toString(),
                                                ))
                                            .toList(),
                                      );
                                    }
                                    return Container(
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.white,
                                        strokeWidth: 5,
                                      ),
                                      alignment: Alignment.center,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          new Padding(
                              padding: const EdgeInsets.only(top: 15.0)),
                          new TextFormField(
                            controller: quantityController,
                            decoration: new InputDecoration(
                                labelText: "Quantity",
                                labelStyle: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.lightBlue[900])),
                            keyboardType: TextInputType.number,
                          ),
                          new Padding(
                              padding: const EdgeInsets.only(top: 15.0)),
                          new TextFormField(
                            controller: priceController,
                            decoration: new InputDecoration(
                                labelText: "Price",
                                labelStyle: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.lightBlue[900])),
                            keyboardType: TextInputType.number,
                          ),
                          new Padding(
                              padding: const EdgeInsets.only(top: 15.0)),
                          Text(
                            "Add item image",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                           Padding(padding: const EdgeInsets.all(5.0)),
                          getImagePicker(),
                          IconButton(
                              icon: Icon(Icons.add),
                              iconSize: 30,
                              color: Colors.lightBlue[900],
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
                          new Padding(
                              padding: const EdgeInsets.only(top: 30.0)),
                          new MaterialButton(
                              height: 40,
                              minWidth: 100,
                              color: Colors.lightBlue[900],
                              textColor: Colors.white,
                              child: new Text("Continue"),
                              onPressed: () {
                                //String category = categoryController.int;
                                String description = descriptionController.text;
                                String name = itemnameController.text;
                                int categoryId = int.parse(_value);
                                int quantity =
                                    int.parse(quantityController.text);
                                int price = int.parse(priceController.text);
                                setState(() {
                                  isLoading = true;
                                });
                                service
                                    .addProduct(name, description, categoryId,
                                        quantity, price, _image)
                                    .then(
                                  (value) {
                                    print(value.data);
                                    if (!value.success) {
                                      Fluttertoast.showToast(
                                          msg: value.message,
                                          textColor: Colors.white,
                                          backgroundColor: Colors.red);
                                      setState(() {
                                        isLoading = false;
                                      });
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: value.message,
                                          textColor: Colors.white,
                                          backgroundColor: Colors.red);
                                      Navigator.pop(context);
                                    }
                                  },
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
