
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/produk.dart';

// EVENT
abstract class KeranjangEvent {}

// Event untuk menambahkan produk
class TambahProduk extends KeranjangEvent {
  TambahProduk(this.produk);

  final Produk produk;
}

// Event untuk mengurangi produk
class KurangiProduk extends KeranjangEvent {
  KurangiProduk(this.produk);

  final Produk produk;
}

// Event untuk mengosongkan keranjang
class KosongkanKeranjang extends KeranjangEvent {}

// STATE
class KeranjangState {
  const KeranjangState(this.items);

  final List<ItemKeranjang> items;
}

// BLOC
class KeranjangBloc
    extends Bloc<KeranjangEvent, KeranjangState> {
  KeranjangBloc() : super(const KeranjangState([])) {

    // Handler untuk menambahkan produk
    on<TambahProduk>((event, emit) {
      final daftar = List<ItemKeranjang>.from(state.items);

      final indeks = daftar.indexWhere(
        (item) => item.produk.nama == event.produk.nama,
      );

      if (indeks == -1) {
        daftar.add(
          ItemKeranjang(produk: event.produk),
        );
      } else {
        daftar[indeks] = ItemKeranjang(
          produk: event.produk,
          jumlah: daftar[indeks].jumlah + 1,
        );
      }

      emit(KeranjangState(
        List.unmodifiable(daftar),
      ));
    });

    // Handler untuk mengurangi produk
    on<KurangiProduk>((event, emit) {
      final daftar = List<ItemKeranjang>.from(state.items);

      final indeks = daftar.indexWhere(
        (item) => item.produk.nama == event.produk.nama,
      );

      if (indeks == -1) return;

      if (daftar[indeks].jumlah == 1) {
        daftar.removeAt(indeks);
      } else {
        daftar[indeks] = ItemKeranjang(
          produk: event.produk,
          jumlah: daftar[indeks].jumlah - 1,
        );
      }

      emit(KeranjangState(
        List.unmodifiable(daftar),
      ));
    });

    // Handler untuk mengosongkan keranjang
    on<KosongkanKeranjang>((event, emit) {
      emit(const KeranjangState([]));
    });
  }
}
