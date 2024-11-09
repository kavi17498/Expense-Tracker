import 'package:fivehoursapp/models/expence.dart';
import 'package:fivehoursapp/widgets/expence_tile.dart';
import 'package:flutter/material.dart';

class ExpenceList extends StatelessWidget {
  final List<ExpenceModel> expenceList;
  final void Function(ExpenceModel expence) onDeleteExpence;
  const ExpenceList(
      {super.key, required this.expenceList, required this.onDeleteExpence});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: expenceList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Dismissible(
                  key: ValueKey(expenceList[index]),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {
                    onDeleteExpence(expenceList[index]);
                  },
                  child: ExpenceTile(expence: expenceList[index])),
            );
          }),
    );
  }
}
