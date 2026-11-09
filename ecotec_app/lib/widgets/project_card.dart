import 'package:flutter/material.dart';
import '../models/project.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  final VoidCallback onDetails;

  const ProjectCard({super.key, required this.project, required this.onDetails});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: colors.primary.withValues(alpha: 0.13),
              child: Icon(project.icon, color: colors.primary, size: 27),
            ),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(project.category.toUpperCase(), style: TextStyle(color: colors.secondary, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.1)),
              const SizedBox(height: 4),
              Text(project.title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            ])),
          ]),
          const SizedBox(height: 12),
          Text(project.description, style: const TextStyle(height: 1.45, color: Color(0xFF555B64))),
          const SizedBox(height: 10),
          Text(project.technologies, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton.icon(
              onPressed: onDetails,
              icon: const Icon(Icons.arrow_forward, size: 18),
              label: const Text('Ver detalles'),
            ),
          ),
        ]),
      ),
    );
  }
}
