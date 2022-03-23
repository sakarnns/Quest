import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quest_2/data/userdata.dart';
import 'package:quest_2/models/user.dart';
import 'package:quest_2/styles/size.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../timeout.dart';

bool isLoading = true;
int? tokenexpire;
bool saved = false;

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? imageFile;

  get jsonResponse => null;

  Future setuserStatus() async {
    print("set user status activated!");
    final prefs = await SharedPreferences.getInstance();

    final val = prefs.getString('token');
    String urlProfile =
        "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/profile";
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': (val) as String
    };
    var resProfile = await http.get(
      Uri.parse(urlProfile),
      headers: requestHeaders,
    );
    tokenexpire = resProfile.statusCode;

    if (resProfile.statusCode == 200) {
      // print(json.decode(resProfile.body));
      UserData.userProfile = UserProfile.fromJson(json.decode(resProfile.body));
      // print(UserData.userProfile!.image);
    }
  }

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);

      setState(() {
        this.imageFile = imageTemporary;
        saved = false;
      });
    } on Exception catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future saveRecentProfile() async {
    final prefs = await SharedPreferences.getInstance();

    final val = prefs.getString('token');
    var requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': (val) as String
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/change_avatar'));
    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile!.path));
    request.headers.addAll(requestHeaders);

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
  void initState() {
    fectc();
    super.initState();
  }

  void fectc() async {
    isLoading = true;
    print("fetch 1 ");
    await setuserStatus();
    if (tokenexpire == 401) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => TimeOutPage()),
          (Route<dynamic> route) => false);
    }
    isLoading = false;
    print("fetch 2 ");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            'Profile',
            style: TextStyle(
              fontSize: 24.0,
              color: Color(0xFF6F2DA8),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
          backgroundColor: Colors.white.withOpacity(0.8),
          elevation: 0.0,
          leading: BackButton(
            color: Color(0xFF6F2DA8),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                setuserStatus();
              });
            },
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: imageFile != null && saved == false
                    ? () {
                        setState(() async {
                          await saveRecentProfile();
                          imageFile!.delete();
                          fectc();
                          setuserStatus();
                          saved = true;
                        });
                      }
                    : null,
                child: imageFile != null && saved == false
                    ? Text(
                        "Save",
                        style: TextStyle(
                            color: Color(0xFF007AFF),
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      )
                    : Text(
                        "Save",
                        style: TextStyle(
                            color: Colors.grey,
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
            child: isLoading != true
                ? Column(
                    children: [
                      SizedBox(
                        height: height(context: context) / 8,
                      ),
                      SizedBox(
                        height: height(context: context) / 100,
                      ),
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
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              6.5,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          fit: BoxFit.cover,
                                        )
                                      : UserData.userProfile!.image != "0"
                                          ? imageprofileupload()
                                          : imageprofiletemp()),
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
                        },
                        child: Text(
                          "Change Profile Photo",
                          style: TextStyle(
                              color: Color(0xFF6F2DA8),
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        height: height(context: context) / 50,
                      ),
                      profileboxlist(
                          "Username", "${UserData.userProfile?.username}"),
                      profileboxlist(
                          "Firstname", "${UserData.userProfile?.name}"),
                      profileboxlist(
                          "Lastname", "${UserData.userProfile?.surname}"),
                      profileboxlist("Email", "${UserData.userProfile?.email}"),
                      profileboxlist("Phone", "${UserData.userProfile?.phone}"),
                      profileboxlist(
                          "Citizen ID", "${UserData.userProfile?.ctzid}"),
                      SizedBox(
                        height: height(context: context) / 20,
                      ),
                    ],
                  )
                : Container(
                    height: 633,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CupertinoActivityIndicator(),
                        Text(
                          "LOADING",
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget profileboxlist(String titile, String detail) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      height: 86,
      decoration: BoxDecoration(
        color: Color(0xFFEBEDF2),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      titile,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Color(0xFF6F2DA8),
                ),
                Text(
                  detail,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget imageprofileupload() {
    return Image(
      image: NetworkImage(
          "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/image_display/${UserData.userProfile!.image}"),
      height: MediaQuery.of(context).size.height / 6.5,
      width: MediaQuery.of(context).size.width / 3,
      fit: BoxFit.cover,
    );
  }

  Widget imageprofiletemp() {
    return Image(
      image: AssetImage('assets/images/profile_temp.jpg'),
      height: MediaQuery.of(context).size.height / 6.5,
      width: MediaQuery.of(context).size.width / 3,
      fit: BoxFit.cover,
    );
  }
}
