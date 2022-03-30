import 'package:bitirme_projesi/controller/db_controller.dart';
import 'package:bitirme_projesi/models/images.dart';
import 'package:bitirme_projesi/service/api_service.dart';
import 'package:bitirme_projesi/screens/photo_add_page.dart';
import 'package:bitirme_projesi/screens/settings_page.dart';
import 'package:bitirme_projesi/screens/sign%C4%B1n_page.dart';
import 'package:bitirme_projesi/screens/wardrobe_page.dart';
import 'package:bitirme_projesi/screens/weatherPages.dart';
import 'package:bitirme_projesi/viewmodel/images_viewmodel.dart';
import 'package:bitirme_projesi/viewmodel/register_viewmodel.dart';
import 'package:bitirme_projesi/viewmodel/settings_viewmodel.dart';
import 'package:bitirme_projesi/widgets/bottomNavigationItems.dart';
import 'package:bitirme_projesi/widgets/colors.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../icons_icons.dart';
import '../my_icons2_icons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  String location;
  String degree;
  String weatherStatus;
  final _controller = PageController();
  List<Images> imagesList = List<Images>();
  SettingsViewModel _settingsViewModel = SettingsViewModel();
  ImagesViewModel _imagesViewModel = ImagesViewModel();
  Images images;

  @override
  void initState() {
    // TODO: implement initState
    getClothsSuggestion();
    super.initState();
  }

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
        SizedBox(
          height: 80,
        ),
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: clothes(),
        ),
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

  GridView clothes() {
    return GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
        itemBuilder: (buildContext, index) {
          return Image.network(
            "https://www.halkkitabevi.com/u/halkkitabevi/img/b/r/i/rick-and-morty-391caf49221bac4a590be167868c42184a.jpg",
          );
        });
  }

  getClothsSuggestion() async {
    await getDegree();
    int id = await _settingsViewModel.getCurrentId();
    if (double.parse(degree) < 7) {
      imagesList.add(await _imagesViewModel.getImagesForSuggest(id, "kazak"));
      imagesList
          .add(await _imagesViewModel.getImagesForSuggest(id, "pantalon"));
      imagesList.add(await _imagesViewModel.getImagesForSuggest(id, "mont"));
      imagesList.add(await _imagesViewModel.getImagesForSuggest(id, "çizme"));
    }
    if (double.parse(degree) > 7.01 && double.parse(degree) < 11.99) {
      imagesList.add(await _imagesViewModel.getImagesForSuggest(id, "kazak"));
      imagesList
          .add(await _imagesViewModel.getImagesForSuggest(id, "pantalon"));
      imagesList.add(await _imagesViewModel.getImagesForSuggest(id, "mont"));
      imagesList.add(await _imagesViewModel.getImagesForSuggest(id, "bot"));
    }

    if (double.parse(degree) > 12.01 && double.parse(degree) < 15.99) {
      imagesList.add(await _imagesViewModel.getImagesForSuggest(id, "tişört"));
      imagesList.add(await _imagesViewModel.getImagesForSuggest(id, "hırka"));
      imagesList.add(await _imagesViewModel.getImagesForSuggest(id, "ceket"));
      imagesList
          .add(await _imagesViewModel.getImagesForSuggest(id, "pantalon"));
      imagesList
          .add(await _imagesViewModel.getImagesForSuggest(id, "ayakkabı"));
    }
    if (double.parse(degree) > 16 && double.parse(degree) < 25.99) {
      imagesList.add(await _imagesViewModel.getImagesForSuggest(id, "tişört"));
      imagesList.add(await _imagesViewModel.getImagesForSuggest(id, "ceket"));
      imagesList.add(await _imagesViewModel.getImagesForSuggest(id, "etek"));
      imagesList
          .add(await _imagesViewModel.getImagesForSuggest(id, "ayakkabı"));
    }
    if (double.parse(degree) > 25 && double.parse(degree) < 35) {
      imagesList.add(await _imagesViewModel.getImagesForSuggest(id, "tişört"));
      imagesList.add(await _imagesViewModel.getImagesForSuggest(id, "şort"));
      imagesList
          .add(await _imagesViewModel.getImagesForSuggest(id, "ayakkabı"));
    }
  }

  Future getDegree() async {
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    location = _sharedPref.getString("user_location");
    degree = await ApiService().getWeather(location).then((value) {
      return value.result[1].degree;
    });
    weatherStatus = await ApiService().getWeather(location).then((value) {
      return value.result[1].status;
    });
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
