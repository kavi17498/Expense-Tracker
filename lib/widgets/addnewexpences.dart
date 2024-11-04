import 'package:flutter/material.dart';

class Addnewexpences extends StatefulWidget {
  const Addnewexpences({super.key});

  @override
  State<Addnewexpences> createState() => _AddnewexpencesState();
}

class _AddnewexpencesState extends State<Addnewexpences> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //title text Filed
        TextField(
          decoration:
              InputDecoration(hintText: "Add New Title", label: Text("Title")),
          keyboardType: TextInputType.text,
          maxLength: 50,
        )
      ],
    );
  }
}
