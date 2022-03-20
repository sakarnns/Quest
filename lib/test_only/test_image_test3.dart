import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quest_2/styles/size.dart';

class TestImageProfile extends StatefulWidget {
  TestImageProfile({Key? key}) : super(key: key);

  @override
  State<TestImageProfile> createState() => _TestImageProfileState();
}

class _TestImageProfileState extends State<TestImageProfile> {
  File? imageFile;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      // final imagePermanent = await saveImagePermanently(image.path);
      // setState(() => this.image = imagePermanent);
      setState(() => this.imageFile = imageTemporary);
    } on Exception catch (e) {
      print('Failed to pick image: $e');
    }
  }

  //  static Future<String> postImage(String path) async {
  //   try {
  //     FormData formData = FormData.fromMap({
  //       'image_file': await MultipartFile.fromFile(
  //         path,
  //       ),
  //     });
  //     Response response = await Dio().post(
  //       '${apiService.url}/upload-image',
  //       options: Options(
  //         contentType: 'multipart/form-data',
  //       ),
  //       data: formData,
  //     );
  //     return response.data["responseData"]["data"]["imageCode"];
  //   } catch (e) {
  //     return "";
  //   }
  // }

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
                      pickImage(ImageSource.gallery);
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
