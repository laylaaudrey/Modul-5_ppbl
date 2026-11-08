
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/layanan.dart';
import '../cubit/favorit_cubit.dart';
import '../pages/halaman_detail_layanan.dart';

class HalamanLayanan extends StatelessWidget {
  const HalamanLayanan({super.key});

  static const List<Layanan> daftarLayanan = [
    Layanan(
      nama: 'Surat Keterangan Domisili',
      bidang: 'Administrasi Kependudukan',
      deskripsi:
          'Layanan untuk memperoleh surat keterangan domisili sebagai bukti tempat tinggal warga.',
      ikon: Icons.home_work,
    ),
    Layanan(
      nama: 'Surat Pengantar KTP',
      bidang: 'Administrasi Kependudukan',
      deskripsi:
          'Layanan pengajuan surat pengantar untuk keperluan pembuatan atau perubahan data KTP.',
      ikon: Icons.badge,
    ),
    Layanan(
      nama: 'Pengaduan Infrastruktur',
      bidang: 'Pembangunan',
      deskripsi:
          'Layanan untuk melaporkan kerusakan jalan, saluran air, lampu jalan, dan fasilitas umum.',
      ikon: Icons.construction,
    ),
    Layanan(
      nama: 'Permohonan Bantuan Sosial',
      bidang: 'Kesejahteraan Sosial',
      deskripsi:
          'Layanan pengajuan bantuan sosial bagi warga yang memenuhi persyaratan.',
      ikon: Icons.volunteer_activism,
    ),
    Layanan(
      nama: 'Surat Keterangan Usaha',
      bidang: 'Administrasi Ekonomi',
      deskripsi:
          'Layanan penerbitan surat keterangan usaha untuk kebutuhan administrasi warga.',
      ikon: Icons.store,
    ),
    Layanan(
      nama: 'Pelaporan Keadaan Darurat',
      bidang: 'Keamanan dan Ketertiban',
      deskripsi:
          'Layanan pelaporan kejadian darurat yang membutuhkan perhatian perangkat desa atau kelurahan.',
      ikon: Icons.emergency,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Layanan Warga'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Layanan untuk Masyarakat',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Pilih layanan yang dibutuhkan atau tandai layanan sebagai favorit.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          ...daftarLayanan.map(
            (layanan) => _KartuLayanan(layanan: layanan),
          ),
        ],
      ),
    );
  }
}

class _KartuLayanan extends StatelessWidget {
  final Layanan layanan;

  const _KartuLayanan({required this.layanan});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              child: Icon(layanan.ikon, size: 27),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    layanan.nama,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    layanan.bidang,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HalamanDetailLayanan(
                            layanan: layanan,
                          ),
                        ),
                      );
                    },
                    child: const Text('Lihat Detail'),
                  ),
                ],
              ),
            ),
            BlocBuilder<FavoritCubit, Set<String>>(
              builder: (context, daftarFavorit) {
                final isFavorit =
                    daftarFavorit.contains(layanan.nama);

                return IconButton(
                  tooltip: isFavorit
                      ? 'Hapus dari favorit'
                      : 'Tambahkan ke favorit',
                  onPressed: () {
                    context
                        .read<FavoritCubit>()
                        .toggle(layanan.nama);
                  },
                  icon: Icon(
                    isFavorit ? Icons.star : Icons.star_border,
                    color: isFavorit ? Colors.amber : Colors.grey,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Import halaman detail di bagian atas file.
