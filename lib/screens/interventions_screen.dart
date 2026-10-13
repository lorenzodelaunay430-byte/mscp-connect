import 'package:flutter/material.dart';

import 'app_shell.dart';

class InterventionsScreen extends StatelessWidget {
  final bool inShell;

  const InterventionsScreen({super.key, this.inShell = false});

  @override
  Widget build(BuildContext context) {
    final body = SafeArea(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(22, 28, 22, 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF073B68), Color(0xFF0B4A82)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Interventions',
                  style: TextStyle(color: Colors.white, fontSize: 31, fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 8),
                Text(
                  'Préparez, réalisez et suivez\nvos interventions en toute sécurité.',
                  style: TextStyle(color: Color(0xFFD5E6F6), fontSize: 16, height: 1.3),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF2FB),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.shield, color: Color(0xFF1976D2), size: 36),
                      SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Procédure sécurisée', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                            SizedBox(height: 4),
                            Text('Suivez les étapes avant toute intervention.'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const _StepCard(number: 1, icon: Icons.power_settings_new, title: 'Arrêt machine', subtitle: 'Mettre la machine à l’arrêt complet'),
                const _StepCard(number: 2, icon: Icons.lock_outline, title: 'Consignation', subtitle: 'Appliquer les dispositifs de consignation'),
                const _StepCard(number: 3, icon: Icons.bolt, title: 'Vérification des énergies', subtitle: 'Contrôler l’absence d’énergies résiduelles'),
                const _StepCard(number: 4, icon: Icons.shield_outlined, title: 'Mise en sécurité', subtitle: 'Sécuriser la zone d’intervention'),
                const _StepCard(number: 5, icon: Icons.handyman_outlined, title: 'Intervention', subtitle: 'Réaliser les travaux prévus'),
                const _StepCard(number: 6, icon: Icons.play_arrow, title: 'Essai et remise en service', subtitle: 'Effectuer les tests et redémarrer'),
                const SizedBox(height: 18),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('EPI obligatoires', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                ),
                const SizedBox(height: 10),
                const Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Chip(avatar: Icon(Icons.engineering), label: Text('Casque')),
                    Chip(avatar: Icon(Icons.visibility_outlined), label: Text('Lunettes')),
                    Chip(avatar: Icon(Icons.hiking), label: Text('Chaussures')),
                    Chip(avatar: Icon(Icons.back_hand_outlined), label: Text('Gants')),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEBEE),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.warning_amber_rounded, color: Colors.red, size: 32),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Alerte', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800, fontSize: 18)),
                            Text('Présence d’une zone chaude.'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: FilledButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Démarrer l’intervention', style: TextStyle(fontWeight: FontWeight.w800)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    if (inShell) return body;

    return Scaffold(
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: 2,
        onDestinationSelected: (index) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => AppShell(initialIndex: index)),
          );
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Accueil'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Machines'),
          NavigationDestination(icon: Icon(Icons.build_outlined), selectedIcon: Icon(Icons.build), label: 'Interventions'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  final int number;
  final IconData icon;
  final String title;
  final String subtitle;

  const _StepCard({
    required this.number,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Color(0xFFE6ECF3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFFEAF2FB),
              child: Text('$number', style: const TextStyle(color: Color(0xFF0B4A82), fontWeight: FontWeight.w800)),
            ),
            const SizedBox(width: 12),
            Icon(icon, color: const Color(0xFF1976D2)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 3),
                  Text(subtitle, style: const TextStyle(color: Color(0xFF667085))),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
