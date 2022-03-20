import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quest_2/styles/size.dart';
import 'package:http/http.dart' as http;

class TestImageProfile4 extends StatefulWidget {
  TestImageProfile4({Key? key}) : super(key: key);

  @override
  State<TestImageProfile4> createState() => _TestImageProfile4State();
}

class _TestImageProfile4State extends State<TestImageProfile4> {
  File? imageFile;

  get jsonResponse => null;

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);

      setState(() => this.imageFile = imageTemporary);
    } on Exception catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future saveRecentProfile() async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/upload_image'));
    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile!.path));

    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      // imagePath = jsonResponse['imagePath'];
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Profile',
                style: TextStyle(fontSize: 32.0, color: Colors.black)),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: BackButton(
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () {
                    saveRecentProfile();
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(
                        color: Color(0xFF007AFF),
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width(context: context) / 20,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(1000),
                            child: imageFile != null
                                ? Image.file(
                                    imageFile!,
                                    height: MediaQuery.of(context).size.height /
                                        6.5,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    fit: BoxFit.cover,
                                  )
                                : SvgPicture.asset(
                                    'assets/icons/user_tem.svg',
                                    height: MediaQuery.of(context).size.height /
                                        6.5,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height(context: context) / 100,
                  ),
                  InkWell(
                    onTap: () {
                      _pickImage(ImageSource.gallery);
                      print('into gallery');
                    },
                    child: Text(
                      "Change Profile Photo",
                      style: TextStyle(
                        color: Color(0xFFAEAEB2),
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
