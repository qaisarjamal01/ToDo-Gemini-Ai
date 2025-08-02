import 'package:flutter/material.dart';

/// A class representing a single todo item.
class Todo {
  final String id;
  String title;
  String description;
  DateTime dueDate;
  String category;
  bool isCompleted;

  Todo({
    required this.id,
    required this.title,
    this.description = '',
    required this.dueDate,
    required this.category,
    this.isCompleted = false,
  });
}