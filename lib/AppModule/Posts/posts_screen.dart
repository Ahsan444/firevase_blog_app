import 'package:blog_app/AppModule/Posts/Controller/posts_provider.dart';
import 'package:blog_app/AppModule/Utils/round_btn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Widgets/pick_image_bottom_sheet.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Post'),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        child: Consumer<PostProvider>(builder: (context, provider, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                Center(
                  child: SizedBox(
                    width: width,
                    height: height * 0.2,
                    child: provider.image != null
                        ? ClipRect(
                            child: Image.file(
                              provider.image!.absolute,
                              width: 100,
                              height: 100,
                              fit: BoxFit.fill,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: 100,
                            height: 30,
                            child: IconButton(
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.orangeAccent,
                                size: 50,
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext bc) {
                                      return PickImageBottomSheet(height: height);
                                    });
                                // provider.getImage(context);
                              },
                            ),
                          ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Form(
                  key: provider.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: provider.titleController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          hintText: 'Enter post title',
                          hintStyle: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal),
                          labelStyle: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal),
                          border: OutlineInputBorder(

                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter title';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        controller: provider.descriptionController,
                        keyboardType: TextInputType.text,
                        minLines: 1,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          hintText: 'Enter post description',
                          hintStyle: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal),
                          labelStyle: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal),
                          border: OutlineInputBorder(

                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter description';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      RoundBtn(title: 'Upload', onPressed: () {
                        if (provider.formKey.currentState!.validate()) {
                          provider.uploadPost(context);
                          //provider.uploadPost(context);
                        }
                      }),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}


