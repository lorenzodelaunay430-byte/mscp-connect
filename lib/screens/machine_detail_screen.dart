import 'package:flutter/material.dart';

import '../models/machine.dart';
import '../widgets/status_chip.dart';
import 'interventions_screen.dart';

class MachineDetailScreen extends StatelessWidget {
  final Machine machine;

  const MachineDetailScreen({
    super.key,
    required this.machine,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 14, 18, 18),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF073B68), Color(0xFF0B4A82)],
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(machine.name,
                            style: const TextStyle(color: Colors.white, fontSize: 27, fontWeight: FontWeight.w900)),
                        Text(machine.subtitle, style: const TextStyle(color: Color(0xFFD6E7F6), fontSize: 15)),
                      ],
                    ),
                  ),
                  const Icon(Icons.more_horiz, color: Colors.white),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  Container(
                    height: 240,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFE8F0F8), Color(0xFFF8FAFD)],
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Icon(machine.icon, size: 125, color: const Color(0xFF0B4A82)),
                        ),
                        Positioned(
                          left: 14,
                          bottom: 14,
                          child: StatusChip(text: machine.status, color: machine.statusColor),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _InfoCard(
                    icon: Icons.description_outlined,
                    title: 'Fiche technique',
                    subtitle: 'Caractéristiques, données techniques et plans',
                    onTap: () => _showInfo(context, 'Fiche technique', machine.technicalSummary),
                  ),
                  const _InfoCard(
                    icon: Icons.view_in_ar_outlined,
                    title: 'Rendu 3D',
                    subtitle: 'Visualisez la machine en 3D et explorez ses composants',
                  ),
                  _EpiCard(epi: machine.epi),
                  _RiskCard(risks: machine.risks),
                  const _InfoCard(
                    icon: Icons.folder_copy_outlined,
                    title: 'Documentation',
                    subtitle: 'Modes opératoires, plans, manuels et autres documents utiles',
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: FilledButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const InterventionsScreen()),
                        );
                      },
                      icon: const Icon(Icons.build),
                      label: const Text(
                        'Voir la procédure d’intervention',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void _showInfo(BuildContext context, String title, String text) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
            const SizedBox(height: 12),
            Text(text, style: const TextStyle(fontSize: 16, height: 1.4)),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Color(0xFFE6ECF3)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(14),
        leading: Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: const Color(0xFFEAF2FB),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: const Color(0xFF1976D2)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

class _EpiCard extends StatelessWidget {
  final List<String> epi;

  const _EpiCard({required this.epi});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Color(0xFFE6ECF3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.shield_outlined, color: Color(0xFF1976D2)),
                SizedBox(width: 10),
                Text('EPI obligatoires', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: epi.map((e) => Chip(label: Text(e))).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _RiskCard extends StatelessWidget {
  final List<String> risks;

  const _RiskCard({required this.risks});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Color(0xFFE6ECF3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.red),
                SizedBox(width: 10),
                Text('Risques', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: risks
                  .map(
                    (e) => Chip(
                      avatar: const Icon(Icons.warning_amber_rounded, size: 18, color: Colors.red),
                      label: Text(e),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
