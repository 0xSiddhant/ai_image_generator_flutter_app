import 'dart:typed_data';

import 'package:ai_image_generator_app/home_repo.dart';
import 'package:ai_image_generator_app/widgets/prompt_box.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String prompt = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Image Generator",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: prompt.isNotEmpty
                    ? FutureBuilder(
                        future: HomeRepo.fetchGeneratedImageFrom(prompt),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,
                              ),
                            );
                          } else if (snapshot.hasError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Something went wrong")));
                          } else if (snapshot.hasData) {
                            return GestureDetector(
                                onLongPress: () {
                                  _saveImageLocally(snapshot.data!, context);
                                },
                                child: Image.memory(snapshot.data!));
                          }
                          return Container();
                        },
                      )
                    : Container(
                        color: Colors.grey.shade900,
                      )),
            PromptBox(
              getPrompt: (p0) {
                setState(() {
                  prompt = p0;
                });
              },
            )
          ],
        ),
      ),
    );
  }

  _saveImageLocally(Uint8List imageData, BuildContext myContext) async {
    final result = await ImageGallerySaver.saveImage(imageData, quality: 80);
    if (result["isSuccess"] == true) {
      ScaffoldMessenger.of(myContext).showSnackBar(
          const SnackBar(content: Text("Image Saved in Gallery")));
    }
  }
}
