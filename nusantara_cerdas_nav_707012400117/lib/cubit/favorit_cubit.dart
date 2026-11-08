
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritCubit extends Cubit<Set<String>> {
  FavoritCubit() : super(const <String>{});

  void tandai(String namaLayanan) {
    final favoritBaru = Set<String>.from(state);

    favoritBaru.add(namaLayanan);

    emit(Set<String>.unmodifiable(favoritBaru));
  }

  void batalTandai(String namaLayanan) {
    final favoritBaru = Set<String>.from(state);

    favoritBaru.remove(namaLayanan);

    emit(Set<String>.unmodifiable(favoritBaru));
  }

  void toggle(String namaLayanan) {
    if (state.contains(namaLayanan)) {
      batalTandai(namaLayanan);
    } else {
      tandai(namaLayanan);
    }
  }
}
