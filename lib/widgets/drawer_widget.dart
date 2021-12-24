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
        padding: const EdgeInsets.only(left: 16.0, top: 16.0),
        child: ListView(
          children: const [
            DrawerHeader(
              // ignore: unnecessary_const
              child: Text(
                'Menu',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
