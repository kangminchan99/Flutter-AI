import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
                onPressed: () {},
                child: const Icon(
                  Icons.image,
                ),
              ),
              const SizedBox(width: 20),
              FloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.camera),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
