import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImgProvider with ChangeNotifier {
  XFile? _image;
  XFile? get image => _image;

  void getImg(XFile? getImg) {
    _image = getImg;
    notifyListeners();
  }

  void clearImg() {
    _image = null;
    notifyListeners();
  }
}
