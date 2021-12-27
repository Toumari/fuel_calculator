import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MPG Calculator'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(padding: EdgeInsets.only(top: 40)),
            Center(
                child: Column(
              children: [
                Text(
                  'About MPG Calculator',
                  style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text(
                    'MPG Calculator is an app designed to help users track their fuel usage when travelling. Users can enter the liters of fuel entered & the miles they travelled using that fuel to get an average of fuel efficiency in their vehicle.',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text(
                    'We hope you enjoy this app. Please consider leaving a review or providing any feedback that could improve the app.',
                    style: TextStyle(fontSize: 20.0),
                  ),
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
