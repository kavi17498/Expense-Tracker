import 'package:fivehoursapp/models/expence.dart';
import 'package:fivehoursapp/widgets/expence_list.dart';
import 'package:flutter/material.dart';

class Expences extends StatefulWidget {
  const Expences({super.key});

  @override
  State<Expences> createState() => _ExpencesState();
}

class _ExpencesState extends State<Expences> {
  final List<ExpenceModel> _expenceList = [
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
                onPressed: () {},
                icon: const Icon(Icons.add),
                color: Colors.black,
              ))
        ],
      ),
      body: Column(
        children: [
          ExpenceList(
            expenceList: _expenceList,
          ),
        ],
      ),
    );
  }
}
