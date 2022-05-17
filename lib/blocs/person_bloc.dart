import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_series/enums/person_url.dart';
import 'package:meta/meta.dart';

part 'person_event.dart';
part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  PersonBloc() : super(PersonInitial()) {
    on<PersonEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
