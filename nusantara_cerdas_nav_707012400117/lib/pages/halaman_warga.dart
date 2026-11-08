
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/layanan.dart';
import '../cubit/favorit_cubit.dart';
import '../cubit/pengajuan_cubit.dart';
import 'halaman_layanan.dart';

class HalamanWarga extends StatelessWidget {
  const HalamanWarga({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Warga'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _bagianJudul(
            ikon: Icons.star,
            judul: 'Layanan Favorit',
            keterangan: 'Daftar layanan yang telah kamu tandai.',
          ),
          const SizedBox(height: 12),
          BlocBuilder<FavoritCubit, Set<String>>(
            builder: (context, daftarFavorit) {
              if (daftarFavorit.isEmpty) {
                return const Card(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Text('Belum ada layanan favorit.'),
                    ),
                  ),
                );
              }

              final layananFavorit = HalamanLayanan.daftarLayanan
                  .where((layanan) =>
                      daftarFavorit.contains(layanan.nama))
                  .toList();

              return Column(
                children: layananFavorit.map((layanan) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Icon(layanan.ikon),
                      ),
                      title: Text(layanan.nama),
                      subtitle: Text(layanan.bidang),
                      trailing: IconButton(
                        tooltip: 'Hapus dari favorit',
                        icon: const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onPressed: () {
                          context
                              .read<FavoritCubit>()
                              .batalTandai(layanan.nama);
                        },
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 24),
          _bagianJudul(
            ikon: Icons.assignment,
            judul: 'Pengajuan Layanan',
            keterangan: 'Daftar layanan yang telah diajukan.',
          ),
          const SizedBox(height: 12),
          BlocBuilder<PengajuanCubit, List<Layanan>>(
            builder: (context, daftarPengajuan) {
              if (daftarPengajuan.isEmpty) {
                return const Card(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Text('Belum ada pengajuan layanan.'),
                    ),
                  ),
                );
              }

              return Column(
                children: daftarPengajuan.map((layanan) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Icon(layanan.ikon),
                      ),
                      title: Text(layanan.nama),
                      subtitle: Text(layanan.bidang),
                      trailing: const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _bagianJudul({
    required IconData ikon,
    required String judul,
    required String keterangan,
  }) {
    return Row(
      children: [
        Icon(ikon, size: 25),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                judul,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                keterangan,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
