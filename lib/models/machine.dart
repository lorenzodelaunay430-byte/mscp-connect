import 'package:flutter/material.dart';

class Machine {
  final String name;
  final String subtitle;
  final String status;
  final Color statusColor;
  final IconData icon;
  final List<String> epi;
  final List<String> risks;
  final String technicalSummary;

  const Machine({
    required this.name,
    required this.subtitle,
    required this.status,
    required this.statusColor,
    required this.icon,
    required this.epi,
    required this.risks,
    required this.technicalSummary,
  });
}
