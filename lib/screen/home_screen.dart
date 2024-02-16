import 'package:fltterai/provider/img_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void update() => setState(() {});
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
      ),
      body: Column(
        children: [
          Container(
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
                  final XFile? img = await imgPicker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (img != null) {
                    update();
                    imgProvider.getImg(XFile(img.path));
                  }
                },
                child: const Icon(
                  Icons.image,
                ),
              ),
              const SizedBox(width: 20),
              FloatingActionButton(
                onPressed: () async {
                  final XFile? img =
                      await imgPicker.pickImage(source: ImageSource.camera);
                  if (img != null) {
                    update();
                    imgProvider.getImg(XFile(img.path));
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
