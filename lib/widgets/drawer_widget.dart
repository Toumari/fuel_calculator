import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../pages/about_page.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const url =
        "https://github.com/Toumari/privacy_policy_site/blob/main/MPG_Calculator_privacy_policy";

    launchURL(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Drawer(
      backgroundColor: Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
        child: ListView(
          children: [
            // ignore: prefer_const_constructors
            SizedBox(
              height: 80,
              child: const DrawerHeader(
                // ignore: unnecessary_const
                // ignore: prefer_const_constructors
                child: Text(
                  'Menu',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
                ),
              ),
            ),
            const Divider(
              color: Colors.teal,
              thickness: 0.8,
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AboutUs()));
                    },
                    child: const Text(
                      'About this App',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 20.0),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      print("test");
                      launchURL(url);
                    },
                    child: const Text('Privacy Policy',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20.0)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
