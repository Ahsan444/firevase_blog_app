import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Controller/posts_provider.dart';

class PickImageBottomSheet extends StatelessWidget {
  const PickImageBottomSheet({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PostProvider>(context);
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Camera',
                style: TextStyle(fontFamily: 'Helvetica',fontSize: 18,
                    fontWeight: FontWeight.normal),),
              onTap: () async {
                provider.getImageCamera();
                Navigator.of(context).pop();
              },
            ),
            ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery',
                  style: TextStyle(fontFamily: 'Helvetica',fontSize: 18,
                      fontWeight: FontWeight.normal),),
                onTap: () async {
                  provider.getImageGallery();
                  Navigator.of(context).pop();
                }),
            SizedBox(
              height: height * 0.1,
            )
          ],
        ),
      ),
    );
  }
}
