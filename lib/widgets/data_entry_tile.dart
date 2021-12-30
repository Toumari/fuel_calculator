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
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade900.withOpacity(0.7),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            DateFormat.yMMMd().format(records[index].dateAdded),
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white),
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
                style: const TextStyle(
                    wordSpacing: 0,
                    height: 1.5,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
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
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const Text(
                    'MPG',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
