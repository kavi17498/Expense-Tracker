import 'package:fivehoursapp/models/expence.dart';
import 'package:fivehoursapp/server/database.dart';
import 'package:fivehoursapp/widgets/addnewexpences.dart';
import 'package:fivehoursapp/widgets/expence_list.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pie_chart/pie_chart.dart';

class Expences extends StatefulWidget {
  const Expences({super.key});

  @override
  State<Expences> createState() => _ExpencesState();
}

class _ExpencesState extends State<Expences> {
  final _myBox = Hive.box("expenceDatabase");
  Database db = Database();

  // final List<ExpenceModel> _expenceList = [
  //   ExpenceModel(
  //       amount: 12.5,
  //       date: DateTime.now(),
  //       title: "Football",
  //       category: Category.leasure),
  //   ExpenceModel(
  //       amount: 10,
  //       date: DateTime.now(),
  //       title: "Carrot",
  //       category: Category.food),
  //   ExpenceModel(
  //       amount: 20,
  //       date: DateTime.now(),
  //       title: "Bag",
  //       category: Category.travel)
  // ];
  //added some comments
  //pie CHart
  Map<String, double> dataMap = {
    "Food": 0,
    "Travel": 0,
    "Leasure": 0,
    "Work": 0,
  };
  //add new expence
  void onAddNewExpence(ExpenceModel expence) {
    setState(() {
      db.expenceList.add(expence);
      calCategoryValues();
      db.updateData();
    });
  }

  //funtion to open a modal overlay
  void _openAddExpencesOverlay() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Addnewexpences(onAddExpence: onAddNewExpence);
        });
  }

  //store the deleting expence

  void onDeleteExpencethis(ExpenceModel expence) {
    ExpenceModel deletingExpece = expence;
    //get the index of the removing expence
    final int removingIndex = db.expenceList.indexOf(expence);
    setState(() {
      db.expenceList.remove(expence);
      db.updateData();
      calCategoryValues();
    });

    //show snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Delete Sucessfull"),
        action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                db.expenceList.insert(removingIndex, deletingExpece);
              });
            }),
      ),
    );
  }

  double foodVal = 0;
  double travelVal = 0;
  double leasureVal = 0;
  double workVal = 0;

  void calCategoryValues() {
    double foodValTotal = 0;
    double travelValTotal = 0;
    double leasureValTotal = 0;
    double workValTotal = 0;
    for (final expence in db.expenceList) {
      if (expence.category == Category.food) {
        foodValTotal += expence.amount;
      }
      if (expence.category == Category.leasure) {
        leasureValTotal += expence.amount;
      }
      if (expence.category == Category.travel) {
        travelValTotal += expence.amount;

        if (expence.category == Category.work) {
          workValTotal += expence.amount;
        }
      }
    }
    setState(() {
      foodVal = foodValTotal;
      travelVal = travelValTotal;
      leasureVal = leasureValTotal;
      workVal = workValTotal;
      db.updateData();
    });
    dataMap = {
      "Food": foodVal,
      "Travel": travelVal,
      "Leasure": leasureVal,
      "Work": workVal,
    };
  }

  @override
  void initState() {
    super.initState();

    //if this is the first time create the initial data
    if (_myBox.get("EXP_DATA") == null) {
      db.createInitialDatabase();
      calCategoryValues();
    } else {
      db.loadData();
      calCategoryValues();
    }

    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Expence Master",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 90, 0, 226),
        actions: [
          Container(
              color: Colors.yellow,
              child: IconButton(
                onPressed: _openAddExpencesOverlay,
                icon: const Icon(Icons.add),
                color: Colors.black,
              ))
        ],
      ),
      body: Column(
        children: [
          PieChart(dataMap: dataMap),
          ExpenceList(
            expenceList: db.expenceList,
            onDeleteExpence: onDeleteExpencethis,
          ),
        ],
      ),
    );
  }
}
