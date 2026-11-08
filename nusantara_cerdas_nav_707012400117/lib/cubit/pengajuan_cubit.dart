
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/layanan.dart';

class PengajuanCubit extends Cubit<List<Layanan>> {
  PengajuanCubit() : super(const []);

  int get totalPengajuan => state.length;

  void tambahPengajuan(Layanan layanan) {
    final sudahAda = state.any(
      (item) => item.nama == layanan.nama,
    );

    if (sudahAda) return;

    final daftarBaru = List<Layanan>.from(state);

    daftarBaru.add(layanan);

    emit(List.unmodifiable(daftarBaru));
  }

  void hapusPengajuan(Layanan layanan) {
    final daftarBaru = state
        .where((item) => item.nama != layanan.nama)
        .toList();

    emit(List.unmodifiable(daftarBaru));
  }

  void kosongkan() {
    emit(const []);
  }
}
