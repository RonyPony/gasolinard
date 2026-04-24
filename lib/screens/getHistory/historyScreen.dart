import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/fuels.model.dart';
import '../../providers/fuels.provider.dart';
import '../../utils/fuel_assets.dart';
import '../shared_component/shorcut.dart';

class HistoryFuels extends StatefulWidget {
  const HistoryFuels({super.key});
  static String routeName = '/historyScreen';

  @override
  State<HistoryFuels> createState() => _HistoryFuelsState();
}

class _HistoryFuelsState extends State<HistoryFuels> {
  late Future<List<Fuels>> _historyFuture;

  @override
  void initState() {
    super.initState();
    _historyFuture = context.read<FuelProvider>().getHistory();
  }

  String _formatWeekDate(String? rawDate) {
    if (rawDate == null) {
      return 'Fecha no disponible';
    }
    final parsedDate = DateTime.tryParse(rawDate);
    if (parsedDate == null) {
      return rawDate;
    }

    const weekDays = [
      'lunes',
      'martes',
      'miércoles',
      'jueves',
      'viernes',
      'sábado',
      'domingo',
    ];
    const months = [
      'enero',
      'febrero',
      'marzo',
      'abril',
      'mayo',
      'junio',
      'julio',
      'agosto',
      'septiembre',
      'octubre',
      'noviembre',
      'diciembre',
    ];

    final localDate = parsedDate.toLocal();
    final dayName = weekDays[localDate.weekday - 1];
    final month = months[localDate.month - 1];

    return '$dayName ${localDate.day} de $month ${localDate.year}';
  }

  List<Combustibles> _dedupeByName(List<Combustibles> fuels) {
    final uniqueByName = <String, Combustibles>{};
    for (final fuel in fuels) {
      uniqueByName.putIfAbsent(fuel.nombre ?? '', () => fuel);
    }
    return uniqueByName.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: Colors.white,
        title: const Text('Histórico semanal'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder<List<Fuels>>(
          future: _historyFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'Ups, inténtalo más tarde',
                  style: TextStyle(color: Colors.white70),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFFF43F5E)),
              );
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'Sin histórico por el momento.',
                  style: TextStyle(color: Colors.white70),
                ),
              );
            }

            final history = snapshot.data!.reversed.toList();
            return ListView.builder(
              padding: const EdgeInsets.all(14),
              itemCount: history.length,
              itemBuilder: (context, index) {
                final week = history[index];
                final items = _dedupeByName(week.combustibles ?? []);
                final weekDate = items.isNotEmpty ? items.first.updateDate : null;

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF111827),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF38BDF8).withOpacity(.2)),
                  ),
                  child: ExpansionTile(
                    collapsedIconColor: Colors.white,
                    iconColor: const Color(0xFF38BDF8),
                    title: Text(
                      'Semana ${history.length - index}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      _formatWeekDate(weekDate),
                      style: const TextStyle(color: Colors.white70),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: .92,
                          ),
                          itemCount: items.length,
                          itemBuilder: (context, fuelIndex) {
                            final fuel = items[fuelIndex];
                            return Shortcut(
                              texxt: fuel.nombre ?? 'Combustible',
                              value: fuel.precio,
                              svgAsset: FuelAssets.svgForFuel(fuel.nombre ?? ''),
                              useExpanded: false,
                            );
                          },
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
