import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart';
import 'package:image_picker/image_picker.dart';

class ImgProvider with ChangeNotifier {
  // 이미지 저장
  XFile? _image;
  XFile? get image => _image;

  // 이미지 변환
  List<List<List<List<double>>>>? _changeImg;
  List<List<List<List<double>>>>? get changeImg => _changeImg;

  // 결과 저장
  double? _result;
  double? get result => _result;

  // 개 고양이 판별
  String? _animal;
  String? get animal => _animal;

  //  setter설정
  void getResult(double? result) {
    _result = result;
    if (result! >= 0.5) {
      _animal = '강아지';
    } else {
      _animal = '고양이';
    }
    notifyListeners();
  }

  void getName() {}

  var batchSize = 1;
  var height = 224;
  var width = 224;
  var channels = 3; // RGB 채널

  Future<void> change(XFile? img) async {
    try {
      Uint8List imageBytes = await img!.readAsBytes();
      var input = preprocessImage(imageBytes);
      _changeImg = input;
      notifyListeners();

      // 출력 확인
    } catch (e) {
      print('Error preprocessing image: $e');
    }
  }

  List<List<List<List<double>>>> preprocessImage(Uint8List imageBytes) {
    // 이미지를 텐서 입력 형식에 맞게 전처리하여 반환
    // 예시: 이미지를 픽셀 값으로 변환하여 4차원 리스트로 저장
    // 전처리 과정은 모델에 따라 다를 수 있음
    // 여기서는 단순히 각 픽셀 값을 [0, 255] 범위에서 [0.0, 1.0] 범위로 정규화
    var image = decodeImage(imageBytes);
    var resizedImage = copyResize(image!, width: 224, height: 224);
    var height = resizedImage.height;
    var width = resizedImage.width;
    var channels = 3; // RGB 채널
    List<List<List<List<double>>>> input = [];

    // 이미지 데이터를 4차원 리스트로 변환
    List<List<List<double>>> imageList = [];
    for (var y = 0; y < height; y++) {
      List<List<double>> row = [];
      for (var x = 0; x < width; x++) {
        List<double> pixel = [];
        for (var c = 0; c < channels; c++) {
          var value = resizedImage.getPixel(x, y)[c] / 255.0; // 정규화
          pixel.add(value);
        }
        row.add(pixel);
      }
      imageList.add(row);
    }
    input.add(imageList);

    return input;
  }

  void getImg(XFile? getImg) {
    _image = getImg;
    notifyListeners();
  }

  void clearImg() {
    _image = null;
    notifyListeners();
  }
}
