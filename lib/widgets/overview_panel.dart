import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OverviewPanel extends StatefulWidget {
  OverviewPanel({
    Key? key,
    required this.fuelEntries,
    required this.averageMPG,
  }) : super(key: key);

  int fuelEntries;
  String averageMPG;

  @override
  _OverviewPanelState createState() => _OverviewPanelState();
}

class _OverviewPanelState extends State<OverviewPanel> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'FUEL ENTRIES',
                    style: TextStyle(
                        fontSize: 24,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 27,
                  ),
                  Text(
                    widget.fuelEntries.toString(),
                    style: const TextStyle(
                        fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'AVERAGE MPG',
                    style: TextStyle(
                        fontSize: 24,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    widget.averageMPG.toString(),
                    style: const TextStyle(
                        fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
        height: 170,
      ),
      elevation: 0.5,
    );
  }
}
