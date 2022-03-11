import 'package:flutter/material.dart';
import 'package:haatbajar/ui/deactivation/deactivateList.dart';
import 'package:haatbajar/ui/deactivation/deactivateReason.dart';
//import 'main.dart';


class DeactivatePage extends StatefulWidget{
  
  @override
  State createState() => new DeactivatePageState();
}

class DeactivatePageState extends State<DeactivatePage> {

    @override
  Widget build(BuildContext context){

     return Scaffold(
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
         title: Text('Deactivate Account'),
       ),
       body: Center(
         child: Container(
           child: Column(
             children: <Widget>[
               Padding(
                 padding: EdgeInsets.all(15.0),
               ),
               Padding(
                 padding: const EdgeInsets.all(5.0),
                 child: Text(
                   "Are you sure you want to deactivate this account?",
                   style: TextStyle(
                     color: Colors.black,
                     fontSize: 18.0,
                   ),
                 ),
               ),
               Padding(
                 padding: EdgeInsets.all(8.0),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: <Widget>[
                     new MaterialButton(
                         height: 40,
                         minWidth: 100,
                         color: Colors.lightBlue[900],
                         textColor: Colors.white,
                         child: new Text("Yes"),
                         onPressed: () {
                           Navigator.push(
                               context,
                               new MaterialPageRoute(
                                   builder: (context) =>
                                   new DeactivateReason()));
                         }),
                   ],
                 ),
               ),
               Padding(
                 padding: EdgeInsets.all(8.0),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: <Widget>[
                     new MaterialButton(
                         height: 40,
                         minWidth: 100,
                         color: Colors.red,
                         textColor: Colors.white,
                         child: new Text("No"),
                         onPressed: () {
                           Navigator.pop(context);
                         }),
                   ],
                 ),
               ),
             ],
           ),
         ),
       ),
     );
    
   /*
                        return new Scaffold(
      backgroundColor: Colors.black,
      
      body:  SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
            ),
           Container(
             color: Colors.white,
             child:Column(
               children:<Widget>[
             Text('Are you sure you want to deactivate your account ?',
                          style: TextStyle(
                              fontFamily: 'Oswald',
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
              Text('Reason for leaving:',
                          style: TextStyle(
                             fontSize: 18.0,
                              color: Colors.black)),
            //    SizedBox(
            //  // height: 60.0,
            //   child: ListView.builder(
            //     physics: ClampingScrollPhysics(),
            //     shrinkWrap: true,
            //     scrollDirection: Axis.vertical,
            //     itemCount: _list.length,
            //     itemBuilder: (BuildContext context, int index) =>
            //     Row(
            //      children: <Widget>[
            //        Radio(value: itemCount,
            //         groupValue: selectedRadio,
            //          onChanged: (val){
                   
            //        print('Radio pressed $val');
            //        setSelectedRadio(val);
            //      },),
            //      Text("${data.reasons}",
            //               style: TextStyle(
            //                  fontSize: 16.0,
            //                   color: Colors.black)),
                 
            //      ],
            //     ),
            //     ),
            //     ),
            // Padding(
            // padding : EdgeInsets.all(14.0),
            // child: Text('$radioItem', style: TextStyle(fontSize: 23))
            //   ),
               Expanded(
            child: Container(
           // height: 350.0,
            child: Column(
              children: 
                _list.map((data) => RadioListTile(
                  title: Text("${data.reasons}",
                  style: TextStyle(
                              fontSize: 16.0,
                               color: Colors.black)
                  ),
                  groupValue: id,
                  value: data.index,
                  onChanged: (val) {
                    setState(() {
                      radioItem = data.reasons ;
                      id = data.index;
                    });
                  },
                )).toList(),
            ),
          )),
               ],
             ),
           ),
          
          ],
        ),
      ),
      
                         
                                
      );*/
  }
}