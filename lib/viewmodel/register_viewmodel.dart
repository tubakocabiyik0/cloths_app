import 'package:bitirme_projesi/controller/db_controller.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum UsersViewState { Idle, Busy }

class RegisterViewModel with ChangeNotifier {
  UsersViewState _userViewState = UsersViewState.Idle;
  bool userRegisterFuture = false;
  String userLoginFuture = '';
  bool isUserLoggedIn;

  RegisterViewModel() {
    userLoggedIn();
  }

  UsersViewState get userViewState => _userViewState;

  set userViewState(UsersViewState value) {
    _userViewState = value;
    notifyListeners();
  }

  Future<bool> userRegister(
      String mail, String password, String name, String location) async {
    try {
      _userViewState = UsersViewState.Busy;
      userRegisterFuture =
          await DbConnection().registerUser(mail, password, name, location);
      return userRegisterFuture;
    } finally {
      _userViewState = UsersViewState.Idle;
    }
  }

  Future<String> userLogIn(String mail, String password) async {
    try {
      _userViewState = UsersViewState.Busy;
      userLoginFuture = await DbConnection().loginUser(mail, password);
      return userLoginFuture;
    } finally {
      _userViewState = UsersViewState.Idle;
    }
  }

  Future<bool> userLoggedIn() async {
    _userViewState = UsersViewState.Busy;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      isUserLoggedIn = await prefs.getBool('isLoggedIn') ?? false;
      return isUserLoggedIn;
    } catch (e) {
      print(e);
    } finally {
      _userViewState = UsersViewState.Idle;
    }
  }

  Future userLogOut() async {
    try {
      SharedPreferences sharedP = await SharedPreferences.getInstance();
      await sharedP.remove('isLoggedIn');
      await sharedP.remove('userMail');
      await sharedP.remove('user_location');
      return Future.value(true);
    } finally {
      _userViewState = UsersViewState.Idle;
    }
  }

  getLocation () async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String location = sharedPreferences.getString("user_location");
    return location;
  }

  deleteAccount(int id)async{
      bool result=await DbConnection().deleteAccoount(id);

  }

}
