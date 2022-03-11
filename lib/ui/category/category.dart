import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:haatbajar/models/categorymodel.dart';
import 'package:haatbajar/ui/category/categoryProduct.dart';
import 'package:haatbajar/ui/login/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haatbajar/api/api_service.dart';
import 'package:strings/strings.dart';

class CategoryPage extends StatefulWidget{
  @override
  State createState() => new CategoryPageState();
}
class CategoryPageState extends State<CategoryPage> {
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text("Category");
  var selectedCategory = '';
  var selectedSubCategory = '';
  int selectedCategoryIndex;
  int selectedSubCategoryIndex;
  String drawerSelected = "Category";
  ApiService service;
  List<Cat> currentSubCategory = [];
  var token;

  @override
  void initState(){
    super.initState();
    service = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      body: Container(
        child: FutureBuilder(
            future: service.getCategory(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Text(
                  'Error Found ',
                  style: TextStyle(color: Colors.white),
                );
              }
              else if (snapshot.hasData) {

                if(snapshot.data == null || snapshot.data.isEmpty){
                  return Text("No data available");
                }

                //_setStateMethod(value);
                debugPrint("value");
                return SingleChildScrollView(
                      child: Container(
                        child: new GridView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: snapshot.data.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 3.0,
                            mainAxisSpacing: 0.0,
                            childAspectRatio: (itemWidth / itemHeight)*1.5,
                          ),
                          itemBuilder: (BuildContext context, int index){
                            return new Card(
                              color: Colors.white,
                              elevation: 6.0,
                              child: new Column(
                                children: <Widget>[
                                  _buildCategoryItem(snapshot.data[index],index,snapshot.data[index].id),
                                ],
                              ),
                            );
                          },
                        ),

                      ),
                );
              }
              return Container(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  strokeWidth: 5,
                ),
                alignment: Alignment.center,
              );
            }),


      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: Icon(Icons.filter_list),
        backgroundColor: Colors.red,
      ),

    );
  }

  Widget _buildCategoryItem(Cat category, int index, int id){
    return InkWell(
      splashColor: Colors.red, onTap:(){
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) =>
              new CategoryProduct(id: id,)));
      selectCategoryOption(index);
    },
      child: AnimatedContainer(
        curve:Curves.easeIn ,
        duration:Duration(milliseconds:300),
        height:  //90.0,
           MediaQuery
            .of(context)
            .size
            .height /6,
        width: 140.0,
        color: Colors.white,
        child: Container(
          child:
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: Image.asset(
                      'lib/assets/category/food.jpg',
                      width: 75,
                      height: 75,
                      fit: BoxFit.fill),
                  /*child: Image.network(
                              "http://rijalroshan.com.np:8082/images/"+category.categoryImage,
                              width: 60,
                              height: 60,
                              fit: BoxFit.fill),*/
                ),

                Text(capitalize(category.categoryName),
                    style: TextStyle(
                        fontFamily: 'oswald',
                        fontWeight: FontWeight.w700,
                        color:  Colors.black,
                        fontSize: 13.0) ),
              ]
          ),
        ),

      ),
    );
  }


  selectCategoryOption(int index){
    setState((){
      selectedCategoryIndex = index;
    });
  }
  selectMenuOption(int index){
    setState((){
      selectedSubCategoryIndex = index;
    });
  }
}


void clearToken(BuildContext context) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  print(pref);
  pref.setString('token',null);

  Navigator.pop(context);
  Navigator.push(
      context, new MaterialPageRoute(builder: (context) => new LoginPage()));
}