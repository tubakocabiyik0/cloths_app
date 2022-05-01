import 'dart:io';

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
import 'package:bitirme_projesi/widgets/button.dart';
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
  //InterstitialAd _interstitialAd;
  bool _isInterstialAdReady = false;

  @override
  void initState() {
    // TODO: implement initState
    getClothsSuggestion();
    super.initState();
    /*InterstitialAd(
        adUnitId: AdHelper().interstitialAdUnitId,
        listener: AdListener(onAdLoaded: (ad) {
          this._interstitialAd = ad;
          _isInterstialAdReady = true;
        }, onAdFailedToLoad: (ad, error) {
          print(error.message);
        }),
        request: AdRequest());*/
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
   // _interstitialAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Theme.of(context).backgroundColor,
      body: homePageBody(),
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          itemWidth: 53,
          showSelectedItemShadow: false,
          barBackgroundColor: Theme.of(context).backgroundColor,
          selectedItemBorderColor: Theme.of(context).accentColor,
          selectedItemBackgroundColor: Theme.of(context).primaryColor,
          selectedItemIconColor: Theme.of(context).cardColor,
          selectedItemLabelColor: Theme.of(context).dividerColor,
        ),
        selectedIndex: selectedIndex,
        onSelectTab: (index) {
          setState(() {
            selectedIndex = index;
            print(selectedIndex);
          });
        },
        items: [
          BottomNavigation(MyIcons2.home_3, "Ana Sayfa").bottomNavigation(),
          BottomNavigation(MyIcons2.socks, "Dolap").bottomNavigation(),
          BottomNavigation(MyIcons.camera, "Kıyafet Ekle").bottomNavigation(),
          BottomNavigation(MyIcons.cog_1, "Ayarlar").bottomNavigation(),
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
    final userViewModel = Provider.of<RegisterViewModel>(context);
    return Column(
      children: [
        weather(),
        smoothPage(),
        SizedBox(
          height: 55,
        ),
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: imagesList.isEmpty ? Container() : clothes(),
        ),
        SizedBox(
          height: 20,
        ),
        imagesList.isEmpty
            ? Container()
            : MyButton(
                () {
                 // getAd();
                  imagesList.clear();
                  getClothsSuggestion();
                },
                "Değiştir",
                260,
                colors: Theme.of(context).primaryColor,
                textColor: Theme.of(context).cardColor,
              ),
      ],
    );
  }

  GridView clothes() {
    return GridView.builder(
        itemCount: imagesList.length != 0 ? imagesList.length : 0,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
        itemBuilder: (buildContext, index) {
          File image = imagesList[index].image_url == null
              ? null
              : File(imagesList[index].image_url);
          return image != null ? Image.file(image) : Container();
        });
  }

  getClothsSuggestion() async {
    await getDegree();
    List<Images> createList = List<Images>();
    int id = await _settingsViewModel.getCurrentId();
    if (double.parse(degree) < 7) {
      createList.add(await _imagesViewModel.getImagesForSuggest(id, "kazak"));
      createList
          .add(await _imagesViewModel.getImagesForSuggest(id, "pantalon"));
      createList.add(await _imagesViewModel.getImagesForSuggest(id, "mont"));
      createList.add(await _imagesViewModel.getImagesForSuggest(id, "çizme"));
      setState(() {
        imagesList.addAll(createList);
      });
    }
    if (double.parse(degree) > 7.01 && double.parse(degree) < 11.99) {
      createList.add(await _imagesViewModel.getImagesForSuggest(id, "kazak"));
      createList
          .add(await _imagesViewModel.getImagesForSuggest(id, "pantalon"));
      createList.add(await _imagesViewModel.getImagesForSuggest(id, "mont"));
      createList.add(await _imagesViewModel.getImagesForSuggest(id, "bot"));
      setState(() {
        imagesList.addAll(createList);
      });
    }

    if (double.parse(degree) > 12.01 && double.parse(degree) < 15.99) {
      await _imagesViewModel.getImagesForSuggest(id, "tişört") != null
          ? createList
              .add(await _imagesViewModel.getImagesForSuggest(id, "tişört"))
          : null;
      await _imagesViewModel.getImagesForSuggest(id, "hırka") != null
          ? createList
              .add(await _imagesViewModel.getImagesForSuggest(id, "hırka"))
          : null;
      await _imagesViewModel.getImagesForSuggest(id, "pantalon") != null
          ? createList
              .add(await _imagesViewModel.getImagesForSuggest(id, "pantalon"))
          : null;
      await _imagesViewModel.getImagesForSuggest(id, "ayakkabı") != null
          ? createList
              .add(await _imagesViewModel.getImagesForSuggest(id, "ayakkabı"))
          : null;
      setState(() {
        print(createList);
        createList.isEmpty ? print("n") : imagesList.addAll(createList);
      });
    }
    if (double.parse(degree) > 16 && double.parse(degree) < 25.99) {
      await _imagesViewModel.getImagesForSuggest(id, "tişört") != null
          ? createList
              .add(await _imagesViewModel.getImagesForSuggest(id, "tişört"))
          : null;
      await _imagesViewModel.getImagesForSuggest(id, "ceket") != null
          ? createList
              .add(await _imagesViewModel.getImagesForSuggest(id, "ceket"))
          : null;
      await _imagesViewModel.getImagesForSuggest(id, "etek") != null
          ? createList
              .add(await _imagesViewModel.getImagesForSuggest(id, "etek"))
          : null;
      await _imagesViewModel.getImagesForSuggest(id, "ayakkabı") != null
          ? createList
              .add(await _imagesViewModel.getImagesForSuggest(id, "ayakkabı"))
          : null;
      setState(() {
        print(createList);
        createList.isEmpty ? print("n") : imagesList.addAll(createList);
      });
    }
    if (double.parse(degree) > 25 && double.parse(degree) < 35) {
      createList.add(await _imagesViewModel.getImagesForSuggest(id, "tişört"));
      createList.add(await _imagesViewModel.getImagesForSuggest(id, "şort"));
      createList
          .add(await _imagesViewModel.getImagesForSuggest(id, "ayakkabı"));
      setState(() {
        imagesList.addAll(createList);
      });
    }
  }

  Future getDegree() async {
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    location = _sharedPref.getString("user_location");
    degree = await ApiService().getWeather(location).then((value) {
      return value.result[0].degree;
    });
    weatherStatus = await ApiService().getWeather(location).then((value) {
      return value.result[1].status;
    });
  }

  weather() {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.13),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color(0xff4E576A).withOpacity(.12),
                offset: Offset(0, 0),
                blurRadius: 97,
                spreadRadius: 9)
          ],
        ),
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
              dotColor: Colors.grey.shade300,
              activeDotColor: Theme.of(context).hoverColor,
              dotWidth: 13,
              dotHeight: 13)),
    );
  }

  void getAd() {
    if (_isInterstialAdReady == true) {
      print("ytr");
    //  _interstitialAd.show();
    } else {
      print("dds");
    }
  }
}
