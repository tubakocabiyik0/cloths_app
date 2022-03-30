import 'package:bitirme_projesi/controller/db_controller.dart';
import 'package:bitirme_projesi/models/images.dart';
import 'package:flutter/cupertino.dart';

enum ImageViewState { Idle, Busy }

class ImagesViewModel with ChangeNotifier {
  String location;
  ImageViewState _imageViewState = ImageViewState.Idle;
  DbConnection _dbConnection = DbConnection();

  set imageViewState(ImageViewState value) {
    _imageViewState = value;
    notifyListeners();
  }

  Future<bool> imageSave(
    String image,
    int user_id,
    String userMail,
    String selectedCategory,
    String selectedSeason,
    String selectedColor,
  ) async {
    try {
      _imageViewState = ImageViewState.Busy;
      bool saved = await DbConnection().saveImages(image, user_id, userMail,
          selectedCategory, selectedSeason, selectedColor);
      if (saved = true) {
        return true;
      } else {
        return false;
      }
    } finally {
      _imageViewState = ImageViewState.Idle;
    }
  }

  Future<Images> getImagesForSuggest(int id, String category) async {
    try {
      Images image = await _dbConnection.getImagesForSuggest(id, category);
      return image;
    } catch (e) {
      print("error" + e);
    }

  }


}
