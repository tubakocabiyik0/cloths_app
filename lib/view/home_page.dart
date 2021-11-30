
import 'package:bitirme_projesi/view/pages.dart';
import 'package:bitirme_projesi/view/weatherPages.dart';
import 'package:bitirme_projesi/view/weather_page.dart';
import 'package:bitirme_projesi/widgets/bottomNavigationItems.dart';
import 'package:bitirme_projesi/widgets/colors.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../icons_icons.dart';
import '../my_icons2_icons.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex=0;
  final _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor,
      body: homePageBody(),
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(itemWidth: 55,
          showSelectedItemShadow: false,
          barBackgroundColor: lightColor,
          selectedItemBorderColor: light,
          selectedItemBackgroundColor: darkGreen,
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.black,
        ),
        selectedIndex: selectedIndex,
        onSelectTab: (index) {
          setState(() {
            selectedIndex = index;
            print(selectedIndex);
          });
        },
        items: [
          BottomNavigation(MyIcons2.home_3, "Home").bottomNavigation(),
          BottomNavigation(MyIcons2.socks, "Wardrobe").bottomNavigation(),
          BottomNavigation(MyIcons.camera, "Add Photo").bottomNavigation(),
          BottomNavigation(MyIcons.cog_1, "Settings").bottomNavigation(),
        ],
      ),
    );
  }

  homePageBody() {
    return selectedIndex ==0 ?  homePage() : null;

  }

  homePage() {
       return Column(
         children: [
           weather(),
           smoothPage(),
         ],
       );
  }

  weather() {
    return Padding(
      padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.13),
      child: SizedBox(
        height: 200,
        child: PageView(
           controller: _controller,
           children: [
             Padding(
               padding:  EdgeInsets.only(right: MediaQuery.of(context).size.height*0.04,left:MediaQuery.of(context).size.height*0.04),
               child: WeatherPages(),
             ),
             Padding(
               padding:  EdgeInsets.only(right: MediaQuery.of(context).size.height*0.04,left:MediaQuery.of(context).size.height*0.04),
               child: WeatherPagesTwo(),
             ),
             Padding(
               padding:  EdgeInsets.only(right: MediaQuery.of(context).size.height*0.04,left:MediaQuery.of(context).size.height*0.04),
               child: WeatherPagesThree(),
             ),
           ],
        ),
      ),
    );
  }

  smoothPage() {
    return Padding(
      padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.03),
      child: SmoothPageIndicator(controller: _controller, count: 3,effect:WormEffect(
        activeDotColor: champagnePink,
        dotWidth: 13,
        dotHeight: 13
      )),
    );
  }
}
