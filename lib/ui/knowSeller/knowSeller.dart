
import 'package:flutter/material.dart';


class KnowSellerPage extends StatefulWidget{
  
  @override
  State createState() => new KnowSellerPageState();
}

class KnowSellerPageState extends State<KnowSellerPage> {
  var _choices = ['All','Trending','Product near by you', 'Food','New','Clothes','Electronic'];
  
bool visibilityTag = false;
  bool visibilityObs = false;
   void _changed(bool visibility, String field) {
    setState(() {
      if (field == "tag"){
        visibilityTag = visibility;
      }
      if (field == "obs"){
        visibilityObs = visibility;
      }
    });
  }
   @override
   void initState(){
     super.initState();

   }

    @override
  Widget build(BuildContext context){
    return new Scaffold(
       backgroundColor: Colors.black,
      appBar: new AppBar(
        title: new Text("Seller"),
       
        ),
        
      body:SingleChildScrollView(
        child:  Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
             // height:260,
           child:Column(
             children: <Widget>[
               Center(
               child: new CircleAvatar(
                   radius: 90.0,
                   backgroundColor: Colors.transparent,
                  backgroundImage: ExactAssetImage('lib/assets/HomeImg/avatar00.png'),
                ),
               ),
               Center(
                 child: Text('Seller Name',style: TextStyle(
                                fontFamily: 'Oswald',
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),),
               ),
                new Container(
            margin: new EdgeInsets.only(left: 16.0, right: 16.0),
            child: new Column(
              children: <Widget>[
                visibilityObs ? new Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    new Expanded(
                      flex: 11,
                      child:new Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Row(
                               children: <Widget>[
                                 Icon(Icons.location_on,
                              color: Colors.redAccent,
                              size: 30,
                              ),
                               new Text("Location",style: TextStyle(
                                fontFamily: 'Oswald',
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color:Colors.white ))
                               ],
                             ),
                               Row(
                               children: <Widget>[
                                 Icon(Icons.phone,
                              color: Colors.teal,
                              size: 30,
                              ),
                               new Text("0123456789",style: TextStyle(
                                fontFamily: 'Oswald',
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color:Colors.white ))
                               ],
                             ),
                             Row(
                               children: <Widget>[
                                 Icon(Icons.email,
                              color: Colors.yellow.shade900,
                              size: 30,
                              ),
                               new Text("seller@example.com",style: TextStyle(
                                fontFamily: 'Oswald',
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color:Colors.white ))
                               ],
                             ),
                              Row(
                               children: <Widget>[
                                 Icon(Icons.calendar_today,
                              color: Colors.indigoAccent,
                              size: 30,
                              ),
                               new Text("Since : 1st Jan 2020",style: TextStyle(
                                fontFamily: 'Oswald',
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color:Colors.white ))
                               ],
                             ),
                            ],
                         ),
                    ),
                    new Expanded(
                      flex: 1,
                      child: new IconButton(
                        color: Colors.grey[400],
                        icon: const Icon(Icons.cancel, size: 22.0,),
                        onPressed: () {
                          _changed(false, "obs");
                        },
                      ),
                    ),
                  ],
                ) : new Container(),

                
              ],
            )
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new InkWell(
                onTap: () {
                  visibilityObs ? null : _changed(true, "obs");
                },
                child: new Container(
                  margin: new EdgeInsets.only(top: 10.0),
                  child: new Column(
                    children: <Widget>[
                      Positioned(
                 left: 20.0,
                 right: 20.0,
                 bottom: 1.0,
                 child:
                      Row(
                        children: <Widget>[
                      new Icon(Icons.info_outline,size: 30, color: visibilityObs ? Colors.grey[600] : Colors.blue),
                      new Container(
                        margin: const EdgeInsets.only(top: 8.0),
                        child: new Text(
                          "Info of seller",
                          style: new TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: visibilityObs ? Colors.grey[600] : Colors.white,
                          ),
                        ),
                      ),
                        ],
                      ),
                      
                      ),
                    ],
                  ),
                ),
              ),
           Text( 'Followers \u2764️ 20',style: TextStyle(
                                fontSize: 16.0,fontWeight: FontWeight.bold, color: Colors.white.withOpacity(0.8),
                                 ),
                              ),
            
                  ],
          ),
             ],
                ),
           
            ),
            Padding(
                  padding: const EdgeInsets.all(5.0),
                  ),
                
                Container(
                  color: Colors.white,
              padding: const EdgeInsets.all(2.0),
               
              child:Column( 
                children: <Widget>[
                  Padding(
                  padding: const EdgeInsets.all(2.0),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                      padding: const EdgeInsets.all(2.0),
                      ),
                  Text('Seller product line:', style:TextStyle(
                                 fontFamily: 'Oswald',
                                 fontSize: 16.0,
                                 fontWeight: FontWeight.bold,
                                 color:Colors.black ),
                  ),
                    ],
                  ),
                   SizedBox(
              height: 60.0,
                  child: ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: _choices.length,
                itemBuilder: (BuildContext context, int index) => Container(
                   padding: const EdgeInsets.all(2.0),
               child: new Row(
                 children: <Widget>[
                      ActionChip(
                         label: Text(_choices[index], textAlign: TextAlign.center,style:TextStyle(
                                 fontFamily: 'Oswald',
                                 fontSize: 16.0,
                                 fontWeight: FontWeight.bold,
                                 color:Colors.black ),
                         
                                ),
                         backgroundColor: Colors.teal,
                         onPressed: ()=> {
                               // Navigator.push(context, new MaterialPageRoute(builder: (context) => new ChipPage() ))
                             },
                       ),
                  ],
                 ),
                ),
                  ),
                   ),

// GridView.count(
//               crossAxisCount: 2,
//               children: List.generate(10, (index) {
//                  Center(
//                    child: Text(
//                 'Item $index',
//                 style: Theme.of(context).textTheme.headline5,
//               ),
//                  );
//               }),
//             ),
  // OrientationBuilder(builder: (context,orientation){
  //   return GridView.count(
  //     crossAxisCount: orientation==Orientation.portrait?2:3,
  //     crossAxisSpacing: 2.0,
  //     children: List.generate(6, (index) { 
  //     return Image.asset('lib/assets/images/image$index.jpg',
  //     width: 200.0,
  //     height: 200.0,
  //     );
       
  //     }),
  //   );
  // }),
                ],
              ),
             ),
            
            
               
               ],
              ),
            ),
            
    );
  }
}