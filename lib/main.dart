import 'package:flutter/material.dart';
import 'package:fuel_calculator/model/fuel_record.dart';
import 'package:fuel_calculator/widgets/data_entry_tile.dart';
import 'package:fuel_calculator/widgets/overview_panel.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(FuelRecordAdapter());
  await Hive.openBox('fuelRecords');
  runApp(const HomeApp());
}

class HomeApp extends StatelessWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainFuelPage(),
    );
  }
}

class MainFuelPage extends StatefulWidget {
  const MainFuelPage({Key? key}) : super(key: key);

  @override
  _MainFuelPageState createState() => _MainFuelPageState();

  static void removeFromBox(int index) {}
}

class _MainFuelPageState extends State<MainFuelPage> {
  late final Box box;

  List<FuelRecord> loadRecords() {
    // List<FuelRecord> records = [
    //FuelRecord(
    // litresOfFuel: 10.0, milesTravelled: 10.0, dateAdded: DateTime.now())
    //];
    List<FuelRecord> records = List<FuelRecord>.from(box.get('fuelRecord'));
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
      results
          .add(((records[i].milesTravelled / records[i].litresOfFuel)) * 4.544);
    }

    for (var i = 0; i < results.length; i++) {
      sum += results[i];
    }

    return (sum / results.length);
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
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: OverflowBox(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 32.0),
                    child: Text(
                      'MPG Calculator',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                    ),
                  ),
                  const Divider(
                    color: Colors.teal,
                    thickness: 0.9,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Overview',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  OverviewPanel(
                      fuelEntries: fuelentries.toInt(),
                      averageMPG: averageNumber().toStringAsFixed(2)),
                  const SizedBox(
                    height: 25,
                  ),
                  DataEntry(),
                  const SizedBox(height: 25),
                  Container(
                    color: Colors.grey.shade200,
                    child: SizedBox(
                      height: 300,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: records.length,
                        itemBuilder: (BuildContext context, int index) {
                          return DataEntryTile(
                            records: records,
                            index: index,
                            function: () {
                              deleteFromBox(index);
                            },
                          );
                        },
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

                    ? print("failed")
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

    box.put('fuelRecord', records);
    print(box.valuesBetween());
  }

  void deleteFromBox(int index) async {
    records.removeAt(index);
    setState(() {
      fuelentries = records.length;
      averageNumber();
    });
    box.put('fuelRecord', records);
    print(records);
    print("deleting!");
  }
}
