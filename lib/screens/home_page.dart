import 'package:bitirme_projesi/service/api_service.dart';
import 'package:bitirme_projesi/screens/photo_add_page.dart';
import 'package:bitirme_projesi/screens/settings_page.dart';
import 'package:bitirme_projesi/screens/sign%C4%B1n_page.dart';
import 'package:bitirme_projesi/screens/wardrobe_page.dart';
import 'package:bitirme_projesi/screens/weatherPages.dart';
import 'package:bitirme_projesi/viewmodel/register_viewmodel.dart';
import 'package:bitirme_projesi/widgets/bottomNavigationItems.dart';
import 'package:bitirme_projesi/widgets/colors.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../icons_icons.dart';
import '../my_icons2_icons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor,
      body: homePageBody(),
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          itemWidth: 55,
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
    if (selectedIndex == 0) {
      return homePage();
    } else if (selectedIndex == 1) {
      return WardrobePage();
    } else if (selectedIndex == 2) {
      return PhotoAddPage();
    } else if (selectedIndex == 3) {
      {
        return SettingsPage();
      }
    }
  }

  homePage() {
    // ApiService().getWeather('İstanbul');
    final userViewModel = Provider.of<RegisterViewModel>(context);
    return Column(
      children: [
        //weather(),
        smoothPage(),
        MaterialButton(
            child: Text("çıkış"),
            onPressed: () async {
              bool result = await userViewModel.userLogOut();
              if (result == true) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SignInPage()));
              }
            })
      ],
    );
  }

  weather() {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.13),
      child: SizedBox(
        height: 200,
        child: PageView(
          controller: _controller,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.height * 0.04,
                  left: MediaQuery.of(context).size.height * 0.04),
              child: WeatherPages(),
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.height * 0.04,
                  left: MediaQuery.of(context).size.height * 0.04),
              child: WeatherPagesTwo(),
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.height * 0.04,
                  left: MediaQuery.of(context).size.height * 0.04),
              child: WeatherPagesThree(),
            ),
          ],
        ),
      ),
    );
  }

  smoothPage() {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
      child: SmoothPageIndicator(
          controller: _controller,
          count: 3,
          effect: WormEffect(
              activeDotColor: champagnePink, dotWidth: 13, dotHeight: 13)),
    );
  }
}
