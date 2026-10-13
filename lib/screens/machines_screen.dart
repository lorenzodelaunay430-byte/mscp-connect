import 'package:flutter/material.dart';

import '../data/machines.dart';
import '../models/machine.dart';
import '../widgets/status_chip.dart';
import 'app_shell.dart';
import 'machine_detail_screen.dart';

class MachinesScreen extends StatefulWidget {
  final bool inShell;

  const MachinesScreen({super.key, this.inShell = false});

  @override
  State<MachinesScreen> createState() => _MachinesScreenState();
}

class _MachinesScreenState extends State<MachinesScreen> {
  String filter = 'Toutes';

  List<Machine> get filtered {
    if (filter == 'Toutes') return machines;
    if (filter == 'Disponibles') {
      return machines.where((m) => m.status == 'Disponible' || m.status == 'Documentation OK').toList();
    }
    if (filter == 'Maintenance') {
      return machines.where((m) => m.status == 'Maintenance').toList();
    }
    return machines.where((m) => m.status == 'Contrôle requis').toList();
  }

  @override
  Widget build(BuildContext context) {
    final body = SafeArea(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(22, 26, 22, 22),
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
                  'MSCP Connect',
                  style: TextStyle(color: Colors.white, fontSize: 29, fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 18),
                Text(
                  'Machines',
                  style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 6),
                Text(
                  'Consultez la liste des équipements\nde l’atelier de maintenance.',
                  style: TextStyle(color: Color(0xFFD5E6F6), fontSize: 15, height: 1.3),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Rechercher une machine',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: Color(0xFFE6ECF3)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: Color(0xFFE6ECF3)),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: ['Toutes', 'Disponibles', 'Maintenance', 'Hors service']
                        .map(
                          (label) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ChoiceChip(
                              selected: filter == label,
                              label: Text(label),
                              onSelected: (_) => setState(() => filter = label),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(height: 14),
                ...filtered.map((machine) => _MachineListCard(machine: machine)),
              ],
            ),
          ),
        ],
      ),
    );

    if (widget.inShell) return body;

    return Scaffold(
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: 1,
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

class _MachineListCard extends StatelessWidget {
  final Machine machine;

  const _MachineListCard({required this.machine});

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
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => MachineDetailScreen(machine: machine)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 94,
                height: 82,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF2FB),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(machine.icon, size: 44, color: const Color(0xFF0B4A82)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(machine.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 4),
                    Text(machine.subtitle, style: const TextStyle(color: Color(0xFF667085))),
                    const SizedBox(height: 8),
                    StatusChip(text: machine.status, color: machine.statusColor),
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
