import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';

part 'expence.g.dart';

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

@HiveType(typeId: 1)
class ExpenceModel {
  //constructor
  ExpenceModel(
      {required this.amount,
      required this.date,
      required this.title,
      required this.category})
      : id = const Uuid().v4();
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final Category category;

  //getter > Fomratted Date

  String get getFormatedDate {
    return fomattedDate.format(date);
  }
}
