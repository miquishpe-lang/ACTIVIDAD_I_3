import 'package:flutter/material.dart';

class Project {
  final String title;
  final String category;
  final String description;
  final String technologies;
  final IconData icon;

  const Project({
    required this.title,
    required this.category,
    required this.description,
    required this.technologies,
    required this.icon,
  });
}
