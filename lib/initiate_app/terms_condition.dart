import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_2/styles/size.dart';

class TermsAndConditionPage extends StatefulWidget {
  TermsAndConditionPage({Key? key}) : super(key: key);

  @override
  State<TermsAndConditionPage> createState() => _TermsAndConditionPageState();
}

class _TermsAndConditionPageState extends State<TermsAndConditionPage> {
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
            title: Text('Terms & Conditions',
                style: TextStyle(fontSize: 28, color: Colors.black)),
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(16))),
            backgroundColor: Colors.white.withOpacity(0.8),
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
                  SizedBox(
                    height: height(context: context) / 7.5,
                  ),
                  updateArea(),
                  SizedBox(
                    height: height(context: context) / 50,
                  ),
                  generalTermsHeader(),
                  generalTermsDetails(),
                  SizedBox(
                    height: height(context: context) / 50,
                  ),
                  licenseHeader(),
                  licenseDetails(),
                  SizedBox(
                    height: height(context: context) / 50,
                  ),
                  consentHeader(),
                  consentDetails(),
                  SizedBox(
                    height: height(context: context) / 50,
                  ),
                  contactHeader(),
                  SizedBox(
                    height: height(context: context) / 100,
                  ),
                  contactDetails(),
                  SizedBox(
                    height: height(context: context) / 20,
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget updateArea() {
    return Row(
      children: [
        SizedBox(
          height: height(context: context) / 100,
        ),
        Text(
          "Updated at 2022-01-01",
          style: TextStyle(color: Color(0xFFAEAEB2), fontSize: 12),
        ),
      ],
    );
  }

  Widget generalTermsHeader() {
    return Row(
      children: [
        SizedBox(
          height: height(context: context) / 100,
        ),
        Text(
          "General Terms",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget generalTermsDetails() {
    return Column(
      children: [
        SizedBox(
          height: height(context: context) / 100,
        ),
        Text(
          "     By accessing and placing an order with, you confirm that you are in agreement with and bound by the terms of service contained in the Terms & Conditions outlined below.\n     These terms apply to the entire website and any email or other type of communication.  Under no circumstances shall team be liable for any direct, indirect, special, incidental or consequential damages, including, but not limited to, loss of data or profit, arising out of the use, or the inability to use, the materials on this site, even if team or an authorized representative has been advised of the possibility of such damages.\n     If your use of materials from this site results in the need for servicing, repair or correction of equipment or data, you assume any costs.\n     will not be responsible for any outcome that may occur during the course of usage of our resources. We reserve the rights to change prices and revise the resources usage policy in any moment.",
          style: TextStyle(color: Color(0xFFAEAEB2), fontSize: 13),
        ),
      ],
    );
  }

  Widget licenseHeader() {
    return Row(
      children: [
        SizedBox(
          height: height(context: context) / 100,
        ),
        Text(
          "License",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget licenseDetails() {
    return Column(
      children: [
        SizedBox(
          height: height(context: context) / 100,
        ),
        Text(
          "     Quest  grants you a revocable, non-exclusive, non- transferable, limited license to download, install and use our service strictly in accordance with the terms of this Agreement.\n     These Terms & Conditions are a contract between you and Quest  (referred to in these Terms & Conditions as we), the provider of the Quest  website and the services accessible from the Quest  website (which are collectively referred to in these Terms & Conditions as the Quest Service).\n     You are agreeing to be bound by these Terms & Conditions. If you do not agree to these Terms & Conditions, please do not use the  Service. In these Terms & Conditions, you refers both to you as an individual and to the entity you represent. If you violate any of these Terms & Conditions, we reserve the right to cancel your account or block access to your account without notice.",
          style: TextStyle(color: Color(0xFFAEAEB2), fontSize: 13),
        ),
      ],
    );
  }

  Widget consentHeader() {
    return Row(
      children: [
        SizedBox(
          height: height(context: context) / 100,
        ),
        Text(
          "Your Consent",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget consentDetails() {
    return Column(
      children: [
        SizedBox(
          height: height(context: context) / 100,
        ),
        Text(
          "     We've updated our Terms & Conditions to provide you with complete transparency into what is being set when you visit our site and how it's being used. By using our service, registering an account, or making a purchase, you hereby consent to our Terms & Conditions.",
          style: TextStyle(color: Color(0xFFAEAEB2), fontSize: 13),
        ),
      ],
    );
  }

  Widget contactHeader() {
    return Row(
      children: [
        SizedBox(
          height: height(context: context) / 100,
        ),
        Text(
          "Contact Us",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget contactDetails() {
    return Row(
      children: [
        SizedBox(
          height: height(context: context) / 100,
        ),
        Text(
          "     Don't hesitate to contact us if you have any questions.\n     - Via Email: quest.grape@gmail.com",
          style: TextStyle(color: Color(0xFFAEAEB2), fontSize: 13),
        ),
      ],
    );
  }
}
