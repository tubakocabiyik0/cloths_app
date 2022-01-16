
import 'package:bitirme_projesi/controller/db_controller.dart';
import 'package:flutter/cupertino.dart';

enum ImageViewState { Idle, Busy }

class ImagesViewModel with ChangeNotifier {
  ImageViewState _imageViewState = ImageViewState.Idle;

  set imageViewState(ImageViewState value) {
    _imageViewState = value;
    notifyListeners();
  }

  Future<bool> imageSave(String image, String userMail) async {
    try {
      _imageViewState = ImageViewState.Busy;
       bool saved=await DbConnection().saveImages(image, userMail);
       if(saved =true){
         return true;
       }else{
         return false;
       }
    } finally {
      _imageViewState = ImageViewState.Idle;
    }
  }
}
