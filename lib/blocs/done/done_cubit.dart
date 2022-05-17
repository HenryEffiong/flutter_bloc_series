import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:math' as math show Random;
part 'done_state.dart';

const names = ['Henry', 'Kenny', 'Life'];

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(length));
}

class NamesCubit extends Cubit<String?> {
  NamesCubit() : super(null);

  void pickRandomState() {
    emit(names.getRandomElement());
  }
}
