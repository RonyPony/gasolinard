import 'package:flutter/material.dart';
import 'package:gasolinard/models/fuels.model.dart';
import 'package:gasolinard/providers/fuels.provider.dart';
import 'package:gasolinard/screens/allFuels.dart/allFuelsScreen.dart';
import 'package:gasolinard/screens/getHistory/historyScreen.dart';
import 'package:gasolinard/screens/shared_component/shorcut.dart';
import 'package:gasolinard/utils/fuel_assets.dart';
import 'package:gasolinard/utils/page_transitions.dart';
import 'package:provider/provider.dart';

import '../shared_component/custom_card promo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String routeName = '/homeScreen';

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Fuels> _fuelsFuture;

  @override
  void initState() {
    super.initState();
    _fuelsFuture = context.read<FuelProvider>().getAll();
  }

  String _formatSyncDate(Fuels fuels) {
    final rawDate = fuels.combustibles
        ?.firstWhere(
          (combustible) =>
              combustible.updateDate != null &&
              combustible.updateDate!.trim().isNotEmpty,
          orElse: () => Combustibles(updateDate: null),
        )
        .updateDate;

    if (rawDate == null) {
      return 'No disponible';
    }

    final parsedDate = DateTime.tryParse(rawDate);
    if (parsedDate == null) {
      return rawDate;
    }

    final localDate = parsedDate.toLocal();
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

    final dayName = weekDays[localDate.weekday - 1];
    final monthName = months[localDate.month - 1];
    final hour12 = localDate.hour % 12 == 0 ? 12 : localDate.hour % 12;
    final minutes = localDate.minute.toString().padLeft(2, '0');
    final amPm = localDate.hour >= 12 ? 'PM' : 'AM';

    return '$dayName ${localDate.day} de $monthName, ${localDate.year} • '
        '$hour12:$minutes $amPm';
  }

  Combustibles _findFuel(Fuels fuels, String fuelName) {
    return fuels.combustibles!.firstWhere((fuel) => fuel.nombre == fuelName);
  }

  void _openScreen(Widget page) {
    Navigator.of(context).push(FadeSlideRoute(page: page));
  }

  @override
  Widget build(BuildContext context) {
    final baseSize = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Soporte y asistencia: escríbenos a rn.cz@icloud.com'),
            ),
          );
        },
        backgroundColor: const Color(0xFF0EA5E9),
        icon: const Icon(Icons.support_agent_rounded),
        label: const Text('Soporte'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F172A), Color(0xFF1E293B), Color(0xFF334155)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: baseSize.width * .05,
              vertical: baseSize.height * .02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.wb_sunny_outlined, color: Color(0xFF38BDF8)),
                    SizedBox(width: 8),
                    Text(
                      'Bienvenido',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: const [
                    Icon(
                      Icons.local_gas_station_rounded,
                      color: Color(0xFFF43F5E),
                      size: 28,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'CombustibleRD',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: baseSize.height * .025),
                const CustomCardPromo(),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => _openScreen(const HistoryFuels()),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Color(0xFF38BDF8)),
                    ),
                    icon: const Icon(Icons.timeline_rounded),
                    label: const Text('Ver histórico semanal'),
                  ),
                ),
                SizedBox(height: baseSize.height * .03),
                const Row(
                  children: [
                    Icon(Icons.insights_rounded, color: Colors.white, size: 24),
                    SizedBox(width: 8),
                    Text(
                      'Precios de esta semana',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                FutureBuilder<Fuels>(
                  future: _fuelsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 24),
                          child: Text(
                            'Ups, inténtalo más tarde.',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 24),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFFF43F5E),
                          ),
                        ),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data?.combustibles == null) {
                      return const Text(
                        'No hay datos disponibles.',
                        style: TextStyle(color: Colors.white70),
                      );
                    }

                    final fuels = snapshot.data!;
                    final gpremium = _findFuel(fuels, 'Gasolina Premium');
                    final gregular = _findFuel(fuels, 'Gasolina Regular');
                    final oilOpti = _findFuel(fuels, 'Gasoil Óptimo');
                    final oilRegular = _findFuel(fuels, 'Gasoil Regular');

                    return TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0, (1 - value) * 24),
                            child: child,
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF111827), Color(0xFF0B1220)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              border: Border.all(
                                color: const Color(0xFF38BDF8).withOpacity(.45),
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.event_available_rounded,
                                  color: Color(0xFF38BDF8),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    'Última sincronización: ${_formatSyncDate(fuels)}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Shortcut(
                                texxt: 'Gasolina Premium',
                                value: gpremium.precio,
                                icon: Icons.local_fire_department_rounded,
                                svgAsset: FuelAssets.svgForFuel(gpremium.nombre ?? ''),
                              ),
                              const SizedBox(width: 12),
                              Shortcut(
                                texxt: 'Gasolina Regular',
                                value: gregular.precio,
                                icon: Icons.local_gas_station_rounded,
                                svgAsset: FuelAssets.svgForFuel(gregular.nombre ?? ''),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Shortcut(
                                texxt: 'Gasoil Premium',
                                value: oilOpti.precio,
                                icon: Icons.ev_station_rounded,
                                svgAsset: FuelAssets.svgForFuel(oilOpti.nombre ?? ''),
                              ),
                              const SizedBox(width: 12),
                              Shortcut(
                                texxt: 'Gasoil Regular',
                                value: oilRegular.precio,
                                icon: Icons.speed_rounded,
                                svgAsset: FuelAssets.svgForFuel(oilRegular.nombre ?? ''),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () => _openScreen(const AllFuelsScreen()),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFF43F5E),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              icon: const Icon(Icons.grid_view_rounded),
                              label: const Text('Ver otros combustibles'),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
