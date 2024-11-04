import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

//enum for category
enum Category { food, travel, leasure, work }

//date format
final fomattedDate = DateFormat.yMd();

//category icons
final CategoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.travel_explore,
  Category.leasure: Icons.leak_add,
  Category.work: Icons.work
};

class ExpenceModel {
  //constructor
  ExpenceModel(
      {required this.amount,
      required this.date,
      required this.title,
      required this.category})
      : id = const Uuid().v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  //getter > Fomratted Date

  String get getFormatedDate {
    return fomattedDate.format(date);
  }
}
