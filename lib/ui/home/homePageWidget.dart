import 'package:flutter/material.dart';
import 'package:haatbajar/ui/products/productWidget.dart';

class HomePageWidget extends StatelessWidget {
  final List product;
  var token;
  int length;
  HomePageWidget({Key key, this.product, this.length,this.token}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        height: 195.0,
        child: ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: length,
          itemBuilder: (BuildContext context, int index) => Card(
            elevation: 6.0,
            margin: EdgeInsets.all(8),
            child: new Container(
              width: 190,
              height: 190,
              child: new Center(
                child: ProductWidget(product: product[index],token: token,),
              ),
            ),
          ),
        ),
      ),
    );
  }

}
