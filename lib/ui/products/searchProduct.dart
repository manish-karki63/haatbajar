import 'package:flutter/material.dart';
import 'package:haatbajar/api/api_service.dart';
import 'package:haatbajar/ui/products/productWidget.dart';
class SearchProductWidget extends SearchDelegate<String>{
  var token;
  SearchProductWidget({Key key, this.token});
  ApiService service;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(
      icon: Icon(Icons.cancel),
      onPressed: (){
        query = "";
      },
    )];
  }

  @override
  Widget buildLeading(BuildContext context) {
   return IconButton(
     onPressed: (){
       close(context, null);
     },
     icon: Icon(Icons.arrow_back),
   );
  }

  @override
  Widget buildResults(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    print(query);
    service = ApiService();
    return new Container(
      child: FutureBuilder(
        future: service.getSearchProduct(query),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasError){
            return Text(
              "Error Found",
              style: TextStyle(color: Colors.white),
            );
          } else if(snapshot.hasData){
            return new GridView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: snapshot.data.length,
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
                    child: ProductWidget(product: snapshot.data[index],token: token,),
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
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

}
