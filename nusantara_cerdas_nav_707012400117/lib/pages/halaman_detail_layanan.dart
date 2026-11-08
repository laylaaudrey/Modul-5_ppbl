
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/layanan.dart';
import '../cubit/pengajuan_cubit.dart';

class HalamanDetailLayanan extends StatefulWidget {
  final Layanan layanan;

  const HalamanDetailLayanan({
    super.key,
    required this.layanan,
  });

  @override
  State<HalamanDetailLayanan> createState() =>
      _HalamanDetailLayananState();
}

class _HalamanDetailLayananState
    extends State<HalamanDetailLayanan> {
  bool sedangMengirim = false;

  Future<void> ajukanPermohonan() async {
    if (sedangMengirim) return;

    setState(() {
      sedangMengirim = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    context
        .read<PengajuanCubit>()
        .tambahPengajuan(widget.layanan);

    setState(() {
      sedangMengirim = false;
    });

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final layanan = widget.layanan;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Layanan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 48,
                child: Icon(layanan.ikon, size: 48),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              layanan.nama,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Chip(
              label: Text(layanan.bidang),
              avatar: const Icon(Icons.category, size: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              'Deskripsi Layanan',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              layanan.deskripsi,
              style: const TextStyle(
                fontSize: 15,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Informasi Pengajuan',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tekan tombol Ajukan Permohonan untuk memasukkan '
              'layanan ini ke dalam daftar pengajuan Anda.',
              style: TextStyle(height: 1.5),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed:
                    sedangMengirim ? null : ajukanPermohonan,
                icon: sedangMengirim
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.send),
                label: Text(
                  sedangMengirim
                      ? 'Mengirim Permohonan...'
                      : 'Ajukan Permohonan',
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
