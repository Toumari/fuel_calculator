import 'package:flutter/material.dart';
import 'package:fuel_calculator/widgets/data_entry_tile.dart';
import 'package:fuel_calculator/widgets/overview_panel.dart';
import 'package:hive/hive.dart';
import 'model/fuel_record.dart';

class MainFuelPage extends StatefulWidget {
  const MainFuelPage({Key? key}) : super(key: key);

  @override
  _MainFuelPageState createState() => _MainFuelPageState();

  static void removeFromBox(int index) {}
}

class _MainFuelPageState extends State<MainFuelPage> {
  late final Box box;

  List<FuelRecord> loadRecords() {
    records = List<FuelRecord>.from(box.get('fuelRecord') == null
        ? []
        : List<FuelRecord>.from(box.get('fuelRecord')));

    return records;
  }

  List<FuelRecord> records = [];

  String fuelAdded = "";
  String milesTravelled = "";
  int fuelentries = 0;
  double averageMPGOverview = 0;
  double avgNumber = 0.0;
  TextEditingController fuelPriceController = TextEditingController();
  TextEditingController milesTravelledController = TextEditingController();

  void entryNumber() {
    setState(() {
      fuelentries = records.length;
    });
  }

  averageNumber() {
    List<double> results = [];

    double sum = 0;

    for (int i = 0; i < records.length; i++) {
      results.add((records[i].milesTravelled.toDouble() /
              records[i].litresOfFuel.toDouble()) *
          4.544);
    }

    for (var i = 0; i < results.length; i++) {
      sum += results[i].toDouble();
    }

    return (results.isNotEmpty ? sum / results.length.toDouble() : 0.0);
  }

  @override
  void initState() {
    super.initState();
    fuelentries = records.length;
    box = Hive.box('fuelRecords');
    records = loadRecords();
    fuelentries = loadRecords().length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('MPG Calculator'),
          backgroundColor: Colors.teal,
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: OverflowBox(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OverviewPanel(
                      fuelEntries:
                          fuelentries.toInt() > 0 ? fuelentries.toInt() : 0,
                      averageMPG: averageNumber().toStringAsFixed(2)),
                  const SizedBox(
                    height: 25,
                  ),
                  DataEntry(),
                  const SizedBox(height: 25),
                  Container(
                    color: Colors.grey.shade200,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        height: 300,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: records.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Dismissible(
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                deleteFromBox(index);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('item deleted')));
                              },
                              key: Key(records[index].toString()),
                              background: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: const [
                                    Icon(
                                      Icons.delete_forever,
                                      color: Colors.white,
                                      size: 40.0,
                                    ),
                                    Text(
                                      'Delete',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24.0),
                                    )
                                  ],
                                ),
                                color: Colors.red,
                              ),
                              child: DataEntryTile(
                                records: records,
                                index: index,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  // ignore: non_constant_identifier_names
  Column DataEntry() {
    return Column(
      children: [
        const Text(
          "Add Fuel Purchase",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 40,
        ),
        const Text(
          'Fuel added to vehicle',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        Center(
            child: TextField(
          controller: fuelPriceController,
          maxLength: 4,
          keyboardType: TextInputType.number,
          style: const TextStyle(fontSize: 16),
        )),
        const Text(
          'Miles Travelled',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        Center(
            child: TextField(
          controller: milesTravelledController,
          maxLength: 4,
          keyboardType: TextInputType.number,
          style: const TextStyle(fontSize: 20),
        )),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 50,
          width: 150,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.teal.shade400),
              onPressed: () {
                setState(() {
                  milesTravelled = milesTravelledController.text;
                  fuelAdded = fuelPriceController.text;
                });

                milesTravelled.isEmpty || fuelAdded.isEmpty
                    // ignore: avoid_print
                    ? showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text('Failed to add record'),
                              content: const Text(
                                  'Please add vaules to both fields'),
                              actions: <Widget>[
                                IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    })
                              ],
                            ))
                    // Need to implement failed route / dialog alert box for this
                    : setState(() {
                        _addToBox(records);
                        entryNumber();
                      });
              },
              child: const Text('Add to log')),
        ),
        const SizedBox(
          height: 40,
        ),
        const Text(
          "Activity Log",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  void _addToBox(List<FuelRecord> record) async {
    setState(() {
      records.add(
        FuelRecord(
            litresOfFuel: double.tryParse(fuelPriceController.text)!,
            milesTravelled: double.tryParse(milesTravelledController.text)!,
            dateAdded: DateTime.now()),
      );
    });

    fuelPriceController.clear();
    milesTravelledController.clear();

    // adds to the Hive Box once record has been added to non permanent list
    box.put('fuelRecord', records);
  }

  void deleteFromBox(int index) async {
    records.removeAt(index);
    setState(() {
      fuelentries = records.length;
      // Sets the fuel entries value in the overview panel to the latest total
      averageNumber();
    });
    box.put('fuelRecord', records);
    // Updates the fuelRecord list upon deleting from the non-permanent Records List
  }
}
