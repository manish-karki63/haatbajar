import 'package:flutter/material.dart';
import 'package:haatbajar/ui/home/HomePage.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:shared_preferences/shared_preferences.dart';


class IntroScreenPage extends StatefulWidget {
  IntroScreenPage({Key key}) : super(key: key);

  @override
  IntroScreenPageState createState() => new IntroScreenPageState();
}

class IntroScreenPageState extends State<IntroScreenPage> {
  List<Slide> slides = new List();

  void setPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("introScreen", true);
  }


  @override
  void initState() {
    super.initState();
    slides.add(
      new Slide(
        title: "Home Page",
        styleTitle: TextStyle(
            color: Colors.lightBlue[900],
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'oswald'),
        description:
        "This is the home page.",
        styleDescription: TextStyle(
            color: Colors.red,
            fontSize: 18.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'oswald'),
        pathImage: "lib/assets/introScreen/homeScreen.PNG",
      ),
    );
    slides.add(
      new Slide(
        title: "Products near Me Page",
        styleTitle: TextStyle(
            color: Colors.lightBlue[900],
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'oswald'),
        description:
        "You can find nearby products in this page",
        styleDescription: TextStyle(
            color: Colors.red,
            fontSize: 18.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'oswald'),
        pathImage: "lib/assets/introScreen/nearMeProduct.PNG",
      ),
    );
    slides.add(
      new Slide(
        title: "Product Detail Page",
        styleTitle: TextStyle(
            color: Colors.lightBlue[900],
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'oswald'),
        description: "You can see details of product in this page",
        styleDescription: TextStyle(
            color: Colors.red,
            fontSize: 18.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'oswald'),
        pathImage: "lib/assets/introScreen/productDetail.PNG",
      ),
    );
    slides.add(
      new Slide(
        title: "Order Received Page",
        styleTitle: TextStyle(
            color: Colors.lightBlue[900],
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'oswald'),
        description: "You can see list of order received in this page",
        styleDescription: TextStyle(
            color: Colors.red,
            fontSize: 18.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'oswald'),
        pathImage: "lib/assets/introScreen/orderReceived.PNG",
      ),
    );
  }

  void onDonePress() {
    setPref();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => HomePage(),
        )
    );
  }

  void onTabChangeCompleted(index) {
    // Index of current tab is focused
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Colors.white,
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Colors.white,
    );
  }

  Widget renderSkipBtn() {
    return IconButton(

      onPressed: (){
        setPref();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => HomePage(),
            )
        );
      },
      icon: Icon(
        Icons.skip_next,
        color: Colors.white,
      ),
    );
  }

    List<Widget> renderListCustomTabs() {
      List<Widget> tabs = new List();
      for (int i = 0; i < slides.length; i++) {
        Slide currentSlide = slides[i];
        tabs.add(Container(
          width: double.infinity,
          height: double.infinity,
          child: Container(
            margin: EdgeInsets.only(bottom: 60.0, top: 15.0),
            child: ListView(
              children: <Widget>[
                Container(
                  child: Text(
                    currentSlide.title,
                    style: currentSlide.styleTitle,
                    textAlign: TextAlign.center,
                  ),
                  margin: EdgeInsets.only(top: 15.0,bottom: 15.0),
                ),
                GestureDetector(
                    child: Image.asset(
                      currentSlide.pathImage,
                      //width: 200.0,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 1.5,
                      fit: BoxFit.contain,
                    )),

                Container(
                  child: Text(
                    currentSlide.description,
                    style: currentSlide.styleDescription,
                    textAlign: TextAlign.center,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                  margin: EdgeInsets.all(12.0),
                ),
              ],
            ),
          ),
        ));
      }
      return tabs;
    }
  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      // List slides
      slides: this.slides,
      isShowSkipBtn: true,

      // Skip button
      renderSkipBtn: this.renderSkipBtn(),
      colorSkipBtn: Colors.lightBlue[900],
      highlightColorSkipBtn: Colors.red,

      // Next button
      renderNextBtn: this.renderNextBtn(),

      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      colorDoneBtn: Colors.lightBlue[900],
      highlightColorDoneBtn: Colors.red,

      // Dot indicator
      colorDot: Colors.lightBlue[900],
      sizeDot: 13.0,
      typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,

      // Tabs
      listCustomTabs: this.renderListCustomTabs(),
      backgroundColorAllSlides: Colors.white,

      // Show or hide status bar
      shouldHideStatusBar: true,

      // On tab change completed
      onTabChangeCompleted: this.onTabChangeCompleted,
    );}
  }
