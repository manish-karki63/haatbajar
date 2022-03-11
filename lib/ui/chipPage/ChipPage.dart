
import 'package:flutter/material.dart';

//import 'main.dart';


class ChipPage extends StatefulWidget{
  
  @override
  State createState() => new ChipPageState();
}

class ChipPageState extends State<ChipPage> {
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text("Trending");
   @override
   void initState(){
     super.initState();

   }

    @override
  Widget build(BuildContext context){
    var _choicesTrending = ['All','Product near by you', 'Food','New','Clothes','Electronic'];
    return new Scaffold(
      backgroundColor: Colors.black,
      appBar: new AppBar(
        
        title: cusSearchBar,
        actions:<Widget>[
        IconButton(
          onPressed: (){
            setState((){
              if(this.cusIcon.icon == Icons.search){
                this.cusIcon = Icon(Icons.cancel);
                this.cusSearchBar = TextField(
                  textInputAction: TextInputAction.go,
                  decoration: InputDecoration(
                   border: InputBorder.none ,
                   hintText: "Search product here ..",
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                );
              }
              else{
                 this.cusIcon = Icon(Icons.search);
                 this.cusSearchBar = Text("Trending");
              }
            });
          },
          icon: cusIcon,
        ),
             IconButton(
          onPressed: (){},
          icon: Icon(Icons.filter_list),
        ),
        ],
        ),
      
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
       SizedBox(
               height: 50.0,
               child: ListView.builder(
                 physics: ClampingScrollPhysics(),
                 shrinkWrap: true,
                 scrollDirection: Axis.horizontal,
                 itemCount: _choicesTrending.length,
                 itemBuilder: (BuildContext context, int index) => Container(
                    padding: const EdgeInsets.all(2.0),
               child: new Row(
                  children: <Widget>[
                       ActionChip(
                          label: Text(_choicesTrending[index], textAlign: TextAlign.center,style:TextStyle(
                                  fontFamily: 'Oswald',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color:Colors.black ),
                          
                                 ),
                          backgroundColor: Colors.teal,
                          onPressed: ()=> {
                            //setState((){}),
      //                           //Navigator.push(context, new MaterialPageRoute(builder: (context) => new ChipPage() ))
                             },
                        ),
                    ],
                   ),
                  ),
                ),
             ),
      
       SizedBox(
              //height: 280.0,
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) => Card(
                  margin: EdgeInsets.all(8),
                  
                  child:   new Container(
                    width: 200,
                    height: 195,
                    
                    child:Stack(
                      children: <Widget>[ 
                        Column(
                      children: <Widget>[
                        new Padding(
                           padding: const EdgeInsets.all(2.0),
                           child: new Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Row(
                               children: <Widget>[
                             new CircleAvatar(
                               radius: 20.0,
                    child:Image.asset ('lib/assets/HomeImg/avatar00.png'),
                    backgroundColor: Colors.transparent,
                         ),
                            new Text('Seller Name'),
                               ],
                             ),
                             new Text("3 May"),
                            ],
                         ),
                        ),

                        Image.asset(
                            'lib/assets/vegetable/potatoes.jpg',
                            height:150,
                            width: 400,
                          fit: BoxFit.fitWidth,
                          ),
                         
                        
                         
                      ],
                    ),
                    Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.black54,
              ],
              stops: [0.5, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.repeated,
            ),
          ),
        ),
                    Positioned(
          left: 16.0,
          right: 16.0,
          bottom: 1.0,
          child: new Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                              Text( 'Potatoes: 150 KG',style: TextStyle(
                                fontSize: 20.0,fontWeight: FontWeight.bold, color: Colors.white.withOpacity(0.8),
                                 ),
                              ),
                            Text( 'Followers \u2764️ 20',style: TextStyle(
                                fontSize: 14.0,fontWeight: FontWeight.bold, color: Colors.white.withOpacity(0.8),
                                 ),
                              ),
                            ]
                         ),
                        ),
                      ],
                   
                  ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
                         
                                
      );
  }
}