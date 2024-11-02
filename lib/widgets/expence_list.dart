import 'package:fivehoursapp/models/expence.dart';
import 'package:flutter/material.dart';

class ExpenceList extends StatelessWidget {
  const ExpenceList({super.key, required this.expenceList});

  final List<ExpenceModel> expenceList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: expenceList.length,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(expenceList[index].title,
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(expenceList[index].amount.toStringAsFixed(2)),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(Icons.trending_down),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(expenceList[index].date.toString())
                        ],
                      )
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}
