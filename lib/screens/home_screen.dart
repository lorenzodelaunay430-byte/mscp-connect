import 'package:flutter/material.dart';

import '../data/machines.dart';
import '../widgets/status_chip.dart';
import 'app_shell.dart';
import 'machine_detail_screen.dart';
import 'machines_screen.dart';

class HomeScreen extends StatelessWidget {
  final bool inShell;

  const HomeScreen({super.key, this.inShell = false});

  @override
  Widget build(BuildContext context) {
    final body = SafeArea(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const _Header(),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.08,
                  children: [
                    _ActionCard(
                      icon: Icons.settings,
                      title: 'Voir les machines',
                      subtitle: 'Consultez la liste et l’état des équipements',
                      onTap: () {
                        if (inShell) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const MachinesScreen()),
                          );
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const AppShell(initialIndex: 1)),
                          );
                        }
                      },
                    ),
                    const _ActionCard(
                      icon: Icons.qr_code_scanner,
                      title: 'Scanner un QR code',
                      subtitle: 'Accédez rapidement à une machine',
                    ),
                    const _ActionCard(
                      icon: Icons.description_outlined,
                      title: 'Fiches techniques',
                      subtitle: 'Modes opératoires, plans et documentations',
                    ),
                    const _ActionCard(
                      icon: Icons.shield_outlined,
                      title: 'EPI obligatoires',
                      subtitle: 'Équipements de protection individuelle',
                    ),
                  ],
                ),
                const SizedBox(height: 26),
                Row(
                  children: [
                    Container(
                      width: 4,
                      height: 28,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1976D2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'Machines récentes',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const MachinesScreen()),
                        );
                      },
                      child: const Text('Voir toutes'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ...machines.take(3).map(
                  (machine) => _MachineCard(
                    name: machine.name,
                    subtitle: machine.subtitle,
                    status: machine.status,
                    statusColor: machine.statusColor,
                    icon: machine.icon,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MachineDetailScreen(machine: machine),
                        ),
                      );
                    },
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
        selectedIndex: 0,
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

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF073B68), Color(0xFF0B4A82)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(22, 26, 22, 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'MSCP ', style: TextStyle(color: Colors.white)),
                      TextSpan(text: 'Connect', style: TextStyle(color: Color(0xFF58C2FF))),
                    ],
                  ),
                  style: TextStyle(fontSize: 31, fontWeight: FontWeight.w900),
                ),
              ),
              Stack(
                children: [
                  const Icon(Icons.notifications_none, color: Colors.white, size: 28),
                  Positioned(
                    right: 2,
                    top: 2,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Application atelier MSPC',
            style: TextStyle(color: Colors.white.withOpacity(.82), fontSize: 16),
          ),
          const SizedBox(height: 28),
          const Text(
            'Bonjour !',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Text(
            'Accédez rapidement aux ressources\nde l’atelier de maintenance.',
            style: TextStyle(color: Colors.white.withOpacity(.84), fontSize: 15, height: 1.35),
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: const Color(0xFFE6ECF3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: const Color(0xFF1976D2), size: 34),
              const Spacer(),
              Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
              const SizedBox(height: 5),
              Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Color(0xFF667085), fontSize: 12.5, height: 1.25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MachineCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final String status;
  final Color statusColor;
  final IconData icon;
  final VoidCallback onTap;

  const _MachineCard({
    required this.name,
    required this.subtitle,
    required this.status,
    required this.statusColor,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Color(0xFFE7ECF3)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 84,
                height: 72,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF2FB),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, size: 40, color: const Color(0xFF0B4A82)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 3),
                    Text(subtitle, style: const TextStyle(color: Color(0xFF667085))),
                    const SizedBox(height: 8),
                    StatusChip(text: status, color: statusColor),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
