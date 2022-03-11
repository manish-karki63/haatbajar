import 'package:flutter/material.dart';
import 'package:haatbajar/ui/chipPage/ChipPage.dart';
import 'package:haatbajar/ui/products/productsnearyou.dart';
import 'package:haatbajar/ui/products/trendingProduct.dart';

//import 'main.dart';


class ChipPageHome extends StatefulWidget{
  
  @override
  State createState() => new ChipPageHomeState();
}

class ChipPageHomeState extends State<ChipPageHome> {
  var _choices = [
    'Trending',
    'Product near by you',
    'Food',
    'New',
    'Clothes',
    'Electronic'
  ];

   @override
   void initState(){
     super.initState();

   }

    @override
  Widget build(BuildContext context){
    return Container(
      child: SizedBox(
                      height: 60.0,
                      child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: _choices.length,
                        itemBuilder: (BuildContext context, int index) =>
                            Container(
                          padding: const EdgeInsets.all(2.0),
                          child: new Row(
                            children: <Widget>[
                              ActionChip(
                                label: Text(
                                  _choices[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Oswald',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                backgroundColor: Colors.red,
                                 elevation: 3.0,
                                onPressed: () => {
                                   if(index == 0)
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                            new TrendingProduct()))
                                  else if (index == 1)
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                new ProductsNearYou()))
                                  else
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                new ChipPage()))
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
      
                         
                                
      );
  }
}