import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/fuel_record.dart';

class DataEntryTile extends StatelessWidget {
  const DataEntryTile({
    Key? key,
    required this.records,
    required this.index,
  }) : super(key: key);

  final List<FuelRecord> records;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          DateFormat.yMMMd().format(records[index].dateAdded),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${records[index].litresOfFuel.toString()} Litres Purchased \n${records[index].milesTravelled} Miles Travelled",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  (((records[index].milesTravelled /
                                  records[index].litresOfFuel)
                              .roundToDouble()) *
                          4.544)
                      .toStringAsFixed(2),
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Text('MPG'),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}
