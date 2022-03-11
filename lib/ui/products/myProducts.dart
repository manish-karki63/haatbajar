import 'package:flutter/material.dart';
import 'package:haatbajar/api/api_service.dart';
import 'package:haatbajar/models/productModel.dart';
import 'package:haatbajar/ui/products/filterProduct/filterConstants.dart';
import 'package:haatbajar/ui/products/productWidget.dart';
import 'package:haatbajar/ui/products/searchProduct.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProducts extends StatefulWidget {
  @override
  _MyProductsState createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  ApiService service;
  bool filter = false;
  List<Product> list;
  var token;
  void getValue() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString("token") != null) {
      print(pref.getString("token"));
      setState(() {
        token = pref.getString("token");
      });
    }
  }
  @override
  void initState(){
    super.initState();
    service = ApiService();
    getValue();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[900],
        textTheme: TextTheme(
            title: TextStyle(
              color: Colors.white,
              fontSize:20.0,
              fontWeight: FontWeight.w600,
            )),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,),
        title: Text("My Products"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context){
              return FilterConstants.choices.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
            icon: Icon(Icons.filter_list),
          ),
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: service.getMyProduct(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.hasError){
              return Text(
                "Error Found",
                style: TextStyle(color: Colors.white),
              );
            } else if(snapshot.hasData){
              if(!filter){
                list = snapshot.data;
              }
              return new GridView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: list.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 0.0,
                  childAspectRatio: (itemWidth / itemHeight)*1.3,
                ),
                itemBuilder: (BuildContext context, int index){
                  print("GridLayout");
                  return new Container(
                    child: Card(
                      margin: EdgeInsets.all(5.0),
                      color: Colors.white,
                      elevation: 6.0,
                      child: ProductWidget(product: list[index], token: token,),
                    ),
                  );
                },
              );
            }else if (!snapshot.hasData) {
              return Container(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  strokeWidth: 5,
                ),
                alignment: Alignment.center,
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
    );
  }
  void choiceAction(String choice) async {
    print(list);
    setState(() {
      filter = true;
    });
    if(choice == FilterConstants.name) {
      setState(() {
        list.sort((dynamic a, dynamic b) =>
            a.title.toLowerCase().compareTo(b.title.toLowerCase()));
      });
    } else if(choice == FilterConstants.price){
      setState(() {
        list.sort((dynamic a, dynamic b) =>
            a.price.compareTo(b.price));
      });
    } else if(choice == FilterConstants.quantity){
      setState(() {
        list.sort((dynamic a, dynamic b) =>
            a.quantity.compareTo(b.quantity));
      });
    } else if(choice == FilterConstants.views){
      setState(() {
        list.sort((dynamic a, dynamic b) =>
            a.views.compareTo(b.views));
      });
    }
  }
}
