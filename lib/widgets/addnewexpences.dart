import 'package:flutter/material.dart';
import 'package:fivehoursapp/models/expence.dart';
import 'package:intl/intl.dart'; // Ensure you import intl for date formatting

class Addnewexpences extends StatefulWidget {
  final void Function(ExpenceModel expence) onAddExpence;
  const Addnewexpences({super.key, required this.onAddExpence});

  @override
  State<Addnewexpences> createState() => _AddnewexpencesState();
}

class _AddnewexpencesState extends State<Addnewexpences> {
  final _titleController = TextEditingController();
  final _amountcontroller = TextEditingController();
  final DateFormat formattedDate = DateFormat('yyyy-MM-dd'); // Date format
  Category _selectedCategory = Category.leasure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountcontroller.dispose();
    super.dispose();
  }

  // Date variables
  final DateTime initialDate = DateTime.now();
  final DateTime firstDate = DateTime(
      DateTime.now().year - 1, DateTime.now().month, DateTime.now().day);
  final DateTime lastDate = DateTime(
    DateTime.now().year + 1,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime _selectedDate = DateTime.now();

  Future<void> _openDateModel() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  //handle form submit
  void _handleformsubmit() {
    final useramount = double.parse(_amountcontroller.text.trim());

    //form validation
    //convert the amount to a double

    if (_titleController.text.trim().isEmpty || useramount <= 0) {
      showDialog(
          context: context,
          builder: (context) {
            return (AlertDialog(
              title: Text("Enter Valid Data"),
              content: const Text(
                  "Please enter the valid title and amount cant be less than 0"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("close"))
              ],
            ));
          });
    } else {
      //create the new expence
      ExpenceModel newExpence = ExpenceModel(
          amount: useramount,
          date: _selectedDate,
          title: _titleController.text.trim(),
          category: _selectedCategory);
      widget.onAddExpence(newExpence);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          // Title TextField
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              helperText: "Add New Title",
              labelText: "Title",
            ),
            keyboardType: TextInputType.text,
            maxLength: 50,
          ),
          Row(
            children: [
              // Amount TextField
              Expanded(
                child: TextField(
                  controller: _amountcontroller,
                  decoration: const InputDecoration(
                    helperText: "Enter the amount",
                    labelText: "Amount",
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              // Date picker
              Expanded(
                child: Row(
                  children: [
                    Text(formattedDate.format(_selectedDate)),
                    IconButton(
                      onPressed: _openDateModel,
                      icon: const Icon(Icons.date_range_outlined),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              DropdownButton<Category>(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Close button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the modal
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.redAccent),
                      ),
                      child: const Text("Close"),
                    ),
                    const SizedBox(width: 10),
                    // Save button
                    ElevatedButton(
                      onPressed: () {
                        // Add save logic here
                        _handleformsubmit();
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue[300]),
                      ),
                      child: const Text("Save"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
