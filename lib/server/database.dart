import 'dart:math';

import 'package:fivehoursapp/models/expence.dart';
import 'package:hive/hive.dart';

class Database {
  //create a database reference
  final _mybox = Hive.box("expenceDatabase");
  List<ExpenceModel> expenceList = [];

  //create the init expence list funtions
  void createInitialDatabase() {
    expenceList = [
      ExpenceModel(
          amount: 12.5,
          date: DateTime.now(),
          title: "Football",
          category: Category.leasure),
      ExpenceModel(
          amount: 10,
          date: DateTime.now(),
          title: "Carrot",
          category: Category.food),
      ExpenceModel(
          amount: 20,
          date: DateTime.now(),
          title: "Bag",
          category: Category.travel)
    ];
  }

  //load the data

  void loadData() {
    final dynamic data = _mybox.get("EXP_DATA");
    //validate the data
    if (data != null && data is List<dynamic>) {
      expenceList = data.cast<ExpenceModel>().toList();
    }
  }

  //update the data
  Future<void> updateData() async {
    await _mybox.put("EXP_DATA", expenceList);
  }
}
