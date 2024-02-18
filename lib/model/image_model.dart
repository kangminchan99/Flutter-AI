import 'package:tflite_flutter/tflite_flutter.dart';

class ImageModel {
  Interpreter? interpreter;
  IsolateInterpreter? isolateInterpreter;

  // 모델 불러오기
  Future<void> loadModel() async {
    try {
      interpreter =
          await Interpreter.fromAsset('assets/model/model_unquant.tflite');
      final inputShape = interpreter!.getInputTensor(0).shape;
      print('###################$inputShape##########');
      isolateInterpreter =
          await IsolateInterpreter.create(address: interpreter!.address);

      print('#####$isolateInterpreter');
    } catch (e) {
      print(e.toString());
    }
  }

  void dispose() {
    interpreter!.close();
  }
}
