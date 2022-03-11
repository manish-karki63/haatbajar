import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haatbajar/api/api_service.dart';
import 'package:haatbajar/models/productModel.dart';
import 'package:haatbajar/ui/products/filterProduct/filterConstants.dart';
import 'package:haatbajar/ui/products/productWidget.dart';
import 'package:haatbajar/ui/products/searchProduct.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsNearYou extends StatefulWidget {
  @override
  State createState() => new ProductsNearYouState();
}

class ProductsNearYouState extends State<ProductsNearYou> {
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text("Product near me");
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
  void initState() {
    super.initState();
    getValue();
    service = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
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
        title: cusSearchBar,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchProductWidget(),
              );
            },
            icon: cusIcon,
          ),
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
      body: new Container(
        child: FutureBuilder(
          future: service.getProductsNearMe(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text(
                "Error Found",
                style: TextStyle(color: Colors.white),
              );
            } else if (snapshot.hasData) {
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
                ),
                itemBuilder: (BuildContext context, int index){
                  print("GridLayout");
                  return new Container(
                    child: Card(
                      margin: EdgeInsets.all(5.0),
                      color: Colors.white,
                      elevation: 6.0,
                      child: ProductWidget(product: list[index],token: token,),
                    ),
                  );
                },
              );
            } else if (!snapshot.hasData) {
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
