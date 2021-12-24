import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
        child: ListView(
          children: [
            // ignore: prefer_const_constructors
            Container(
              height: 80,
              child: DrawerHeader(
                // ignore: unnecessary_const
                // ignore: prefer_const_constructors
                child: Text(
                  'Menu',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 32.0),
                ),
              ),
            ),
            Divider(
              color: Colors.teal,
              thickness: 0.8,
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'About this App',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text('Privacy Policy',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 20.0))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
