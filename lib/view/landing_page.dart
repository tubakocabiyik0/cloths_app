import 'package:bitirme_projesi/view/sign%C4%B1n_page.dart';
import 'package:bitirme_projesi/viewmodel/register_viewmodel.dart';
import 'package:bitirme_projesi/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegisterViewModel>(context,listen: false);
    if (provider.userViewState == UsersViewState.Idle) {
      if (provider.isUserLoggedIn == true) {
        return HomePage();
      } else {
        return SignInPage();
      }
    } else if (provider.userViewState == UsersViewState.Busy) {
      return Center(
        child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(darkGreen)),
      );
    }
  }
}
