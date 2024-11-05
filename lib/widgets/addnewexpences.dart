import 'package:flutter/material.dart';

class Addnewexpences extends StatefulWidget {
  const Addnewexpences({super.key});

  @override
  State<Addnewexpences> createState() => _AddnewexpencesState();
}

class _AddnewexpencesState extends State<Addnewexpences> {
  final _titleController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose

    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //title text Filed
        TextField(
          controller: _titleController,
          decoration:
              InputDecoration(hintText: "Add New Title", label: Text("Title")),
          keyboardType: TextInputType.text,
          maxLength: 50,
        )
      ],
    );
  }
}
