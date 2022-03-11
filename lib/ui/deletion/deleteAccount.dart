import 'package:flutter/material.dart';

//import 'main.dart';


class DeleteAccountPage extends StatefulWidget{
  
  @override
  State createState() => new DeleteAccountPageState();
}

class DeleteAccountPageState extends State<DeleteAccountPage> {
int selectedRadio;
   @override
   void initState(){
     super.initState();
     selectedRadio = 0;
   }
setSelectedRadio(int val){
     setState((){
       selectedRadio = val;
     });
   }
    @override
  Widget build(BuildContext context){
    return new Scaffold(
      backgroundColor: Colors.black,
      appBar: new AppBar(
        
        title: Text('Delete Account'),
        actions:<Widget>[
          IconButton(
          onPressed: (){},
          icon: Icon(Icons.cancel,),
        ),
        ],
        ),
      
      body:  SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          padding: const EdgeInsets.all(10.0),
       child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
           Padding(padding: const EdgeInsets.all(10.0),),
           Text('Are you sure you want to delete your account permanenetly ?',
                          style: TextStyle(
                              fontFamily: 'Oswald',
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
            Padding(padding: const EdgeInsets.all(20.0),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  color: Colors.white24,
                  padding: const EdgeInsets.all(5.0),
                 child:Row(
                  children: <Widget>[
                    Radio(value: 1,
                     groupValue: selectedRadio,
                     activeColor: Colors.redAccent,
                     hoverColor: Colors.teal,
                      onChanged: (val){
                   
                   print('Radio pressed $val');
                   setSelectedRadio(val);
                 },),
                 Text("Yes",
                          style: TextStyle(
                             fontSize: 16.0,
                              color: Colors.white)),
                              Padding(padding: const EdgeInsets.all(5.0),),
                  ], 
                 ),
                ),
                 Container(
                  color: Colors.white24,
                  padding: const EdgeInsets.all(5.0),
                 child:Row(
                  children: <Widget>[
                    Radio(value: 2,
                     groupValue: selectedRadio,
                     activeColor: Colors.redAccent,
                      onChanged: (val){
                   
                   print('Radio pressed $val');
                   setSelectedRadio(val);
                 },),
                 Text("No",
                          style: TextStyle(
                             fontSize: 16.0,
                              color: Colors.white)),
                              Padding(padding: const EdgeInsets.all(5.0),),
                  ], 
                 ), 
                 ),
              ],
            ),
            Padding(padding: const EdgeInsets.all(20.0),),
            new MaterialButton(
                            height: 40,
                            minWidth: 100,
                            color: Colors.teal,
                            textColor: Colors.white,
                            child: new Text("Delete Account"),
                            onPressed: ()=> {
                               // Navigator.push(context, new MaterialPageRoute(builder: (context) => new HomePage() ))
                             },
                            splashColor: Colors.redAccent,
                          ),
          ],
        ),
        ),
      ),
      
                         
                                
      );
  }
}