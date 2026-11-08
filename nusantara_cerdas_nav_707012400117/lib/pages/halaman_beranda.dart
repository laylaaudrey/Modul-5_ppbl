
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/layanan.dart';
import '../cubit/pengajuan_cubit.dart';
import 'halaman_layanan.dart';
import 'halaman_warga.dart';

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  int indeksTerpilih = 0;

  final List<Widget> daftarHalaman = const [
    HalamanLayanan(),
    HalamanWarga(),
  ];

  void pilihHalaman(int indeks) {
    setState(() {
      indeksTerpilih = indeks;
    });

    Navigator.pop(context);
  }

  Widget ikonDenganBadge() {
    return BlocSelector<PengajuanCubit, List<Layanan>, int>(
      selector: (daftar) => daftar.length,
      builder: (context, jumlah) {
        return Badge(
          isLabelVisible: jumlah > 0,
          label: Text('$jumlah'),
          child: const Icon(Icons.people_outline),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool layarLebar = constraints.maxWidth >= 700;

        if (layarLebar) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Nusantara Cerdas Mobile'),
            ),
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: indeksTerpilih,
                  onDestinationSelected: (indeks) {
                    setState(() {
                      indeksTerpilih = indeks;
                    });
                  },
                  labelType: NavigationRailLabelType.all,
                  destinations: [
                    const NavigationRailDestination(
                      icon: Icon(Icons.home_repair_service_outlined),
                      selectedIcon: Icon(Icons.home_repair_service),
                      label: Text('Layanan'),
                    ),
                    NavigationRailDestination(
                      icon: ikonDenganBadge(),
                      selectedIcon: ikonDenganBadge(),
                      label: const Text('Warga'),
                    ),
                  ],
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: IndexedStack(
                    index: indeksTerpilih,
                    children: daftarHalaman,
                  ),
                ),
              ],
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Nusantara Cerdas Mobile'),
          ),
          drawer: NavigationDrawer(
            selectedIndex: indeksTerpilih,
            onDestinationSelected: pilihHalaman,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(28, 24, 16, 12),
                child: Text(
                  'Menu Navigasi',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const NavigationDrawerDestination(
                icon: Icon(Icons.home_repair_service_outlined),
                selectedIcon: Icon(Icons.home_repair_service),
                label: Text('Layanan'),
              ),
              NavigationDrawerDestination(
                icon: ikonDenganBadge(),
                selectedIcon: ikonDenganBadge(),
                label: const Text('Warga'),
              ),
            ],
          ),
          body: IndexedStack(
            index: indeksTerpilih,
            children: daftarHalaman,
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: indeksTerpilih,
            onDestinationSelected: (indeks) {
              setState(() {
                indeksTerpilih = indeks;
              });
            },
            destinations: [
              const NavigationDestination(
                icon: Icon(Icons.home_repair_service_outlined),
                selectedIcon: Icon(Icons.home_repair_service),
                label: 'Layanan',
              ),
              NavigationDestination(
                icon: ikonDenganBadge(),
                selectedIcon: ikonDenganBadge(),
                label: 'Warga',
              ),
            ],
          ),
        );
      },
    );
  }
}
