import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class WishlistPage extends StatefulWidget {
  @override
  WishlistPageState createState() => new WishlistPageState();
}

class WishlistPageState extends State<WishlistPage> with TickerProviderStateMixin {
  TabController tabController;

  @override
  void initState(){
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {

    var tabBarItem = new TabBar(

      tabs: [
        new Tab(
          icon: new Icon(Icons.list),
        ),
        new Tab(
          icon: new Icon(Icons.grid_on),
        ),
      ],
      controller: tabController,
      indicatorColor: Colors.white,
    );

    var listItem = new ListView.builder(
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: new Card(
            elevation: 5.0,
            shadowColor: Colors.white,
            child: new Container(
              width: 200,
              height: 195,
              alignment: Alignment.center,
              margin: new EdgeInsets.only(top: 10.0, bottom: 10.0),
              // child: new Text("ListItem $index"),
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
          onTap: () {
            showDialog(
                builder: (context) => new CupertinoAlertDialog(
                  title: new Column(
                    children: <Widget>[
                      new Text("ListView"),
                      new Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    ],
                  ),
                  content: new Text("Selected Item $index"),
                  actions: <Widget>[
                    new FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: new Text("OK"))
                  ],
                ), barrierDismissible: false,
                context: context);
          },
        );
      },
    );

    var gridView = new GridView.builder(

        itemCount: 20,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
            child:SizedBox(
              height: 280.0,
              child: new Card(

                elevation: 5.0,
                shadowColor: Colors.white,
                child:new Container(
                  // alignment: Alignment.center,
                  // child: new Text('Item $index'),
                  width: 200,
                  height: 230,
                  child: new Center(
                    child:Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[

                            new Row(
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



                            Image.asset(
                                'lib/assets/vegetable/potatoes.jpg',
                                width: 130,
                                height: 130,
                                fit: BoxFit.fill),
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
                          left: 5.0,
                          right: 5.0,
                          bottom: 1.0,
                          child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                new Text("Potatoes 150",style: TextStyle(
                                    fontFamily: 'Oswald',
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color:Colors.white )),
                                new Text("\u2764️ 20",style: TextStyle(
                                    fontFamily: 'Oswald',
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color:Colors.white ))
                              ]
                          ),
                        ),


                      ],
                    ),
                  ),

                ),
              ),
            ),
            onTap: () {
              showDialog(
                builder: (context) => new CupertinoAlertDialog(
                  title: new Column(
                    children: <Widget>[
                      new Text("GridView"),
                      new Icon(
                        Icons.favorite,
                        color: Colors.green,
                      ),
                    ],
                  ),
                  content: new Text("Selected Item $index"),
                  actions: <Widget>[
                    new FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: new Text("OK"))
                  ],
                ), barrierDismissible: false,
                context: context,
              );
            },
          );
        });

    return new DefaultTabController(
      length: 2,
      child: new Scaffold(
        backgroundColor: Colors.blue,
        appBar: tabBarItem,
        body: new Container(
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: new TabBarView(
            controller: tabController,
            children: [
              listItem,
              gridView,
            ],
          ),
        ),
        floatingActionButton:FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
          },
          child: Icon(Icons.filter_list),
          backgroundColor: Colors.green,
        ),
    ),
    );
  }
}