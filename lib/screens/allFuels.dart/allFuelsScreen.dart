import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/fuels.model.dart';
import '../../providers/fuels.provider.dart';
import '../../utils/fuel_assets.dart';
import '../shared_component/shorcut.dart';

class AllFuelsScreen extends StatefulWidget {
  const AllFuelsScreen({super.key});
  static String routeName = '/allFuelsScreen';

  @override
  State<AllFuelsScreen> createState() => _AllFuelsScreenState();
}

class _AllFuelsScreenState extends State<AllFuelsScreen> {
  late Future<Fuels> _allFuelsFuture;

  @override
  void initState() {
    super.initState();
    _allFuelsFuture = context.read<FuelProvider>().getAll();
  }

  List<Combustibles> _dedupe(List<Combustibles> fuels) {
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
        title: const Text('Todos los Combustibles'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder<Fuels>(
          future: _allFuelsFuture,
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
            if (!snapshot.hasData || snapshot.data?.combustibles == null) {
              return const Center(
                child: Text(
                  'No hay datos disponibles.',
                  style: TextStyle(color: Colors.white70),
                ),
              );
            }

            final fuels = _dedupe(snapshot.data!.combustibles!);
            return GridView.builder(
              padding: const EdgeInsets.all(14),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: .92,
              ),
              itemCount: fuels.length,
              itemBuilder: (context, index) {
                final fuel = fuels[index];
                return Shortcut(
                  texxt: fuel.nombre ?? 'Combustible',
                  value: fuel.precio,
                  svgAsset: FuelAssets.svgForFuel(fuel.nombre ?? ''),
                  useExpanded: false,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
