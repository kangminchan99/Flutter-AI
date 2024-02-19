import 'dart:io';

import 'package:fltterai/model/image_model.dart';
import 'package:fltterai/provider/img_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void update() => setState(() {});
  late ImageModel _imageModel;
  bool nextImg = true;

  var output = List.filled(1 * 2, 0).reshape([1, 2]);

  // var result;

  @override
  void initState() {
    super.initState();
    _imageModel = ImageModel();
    // .then((value) { ... }) : loadModel()함수의 결과가 사용 가능해지면 실행되는 콜백함수
    _imageModel.loadModel().then((value) {
      update();
    });
  }

  @override
  void dispose() {
    _imageModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imgProvider = Provider.of<ImgProvider>(context);
    ImagePicker imgPicker = ImagePicker();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Cat vs Dog',
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: 30),
        ),
        leading: IconButton(
          onPressed: () async {
            if (imgProvider.image != null) {
              _imageModel.isolateInterpreter!
                  .run(imgProvider.changeImg!, output);

              print('output${output}');
              imgProvider.getResult(output[0][0].toDouble());
              print(imgProvider.result);
            }
          },
          icon: const Icon(Icons.search),
        ),
        actions: [
          IconButton(
              onPressed: imgProvider.clearImg, icon: const Icon(Icons.refresh))
        ],
      ),
      body: Column(
        children: [
          imgProvider.image == null
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/images/cat_and_dog.jpeg',
                      ),
                    ),
                  ),
                )
              : Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width,
                      child: Image.file(
                        File(imgProvider.image!.path),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (nextImg = true && imgProvider.animal != null) ...[
                      Text(
                        '${imgProvider.animal}',
                        style: const TextStyle(fontSize: 40),
                      ),
                    ] else ...[
                      const Text(
                        '검색 아이콘을 눌러 강아지인지 고양이인지 확인하세요!!',
                        style: TextStyle(fontSize: 30),
                      )
                    ]
                  ],
                )
        ],
      ),
      floatingActionButton: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: () async {
                  try {
                    final XFile? img = await imgPicker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (img != null) {
                      update();
                      imgProvider.getImg(XFile(img.path));
                      imgProvider.change(imgProvider.image);
                      nextImg = !nextImg;
                    }
                  } catch (e) {
                    print(e.toString());
                  }
                },
                child: const Icon(
                  Icons.image,
                ),
              ),
              const SizedBox(width: 20),
              FloatingActionButton(
                onPressed: () async {
                  try {
                    final XFile? img =
                        await imgPicker.pickImage(source: ImageSource.camera);
                    if (img != null) {
                      update();
                      imgProvider.getImg(XFile(img.path));
                      imgProvider.change(imgProvider.image);

                      nextImg = !nextImg;
                    }
                  } catch (e) {
                    print(e.toString());
                  }
                },
                child: const Icon(Icons.camera),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
