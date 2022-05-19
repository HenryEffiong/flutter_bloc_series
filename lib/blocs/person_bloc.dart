import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc_series/enums/person_url.dart';
import 'package:flutter_bloc_series/models/person.dart';
import 'package:meta/meta.dart';

part 'person_event.dart';
part 'person_state.dart';

class PersonBloc extends Bloc<LoadPersonsAction, FetchResult?> {
  final Map<PersonUrl, Iterable<Person>> _cache = {};

  Future getPersons(String url) async {
    Iterable<Person> response = await rootBundle.loadStructuredData(
      url,
      (jsonStr) async {
        List localPersons = jsonDecode(jsonStr) as List;
        return localPersons.map(
          (localPerson) => Person.fromJson(localPerson),
        );
      },
    );
    return response;
  }

  PersonBloc() : super(null) {
    on<LoadPersonsAction>((event, emit) async {
      final url = event.url;
      if (_cache.containsKey(url)) {
        final cachedPersons = _cache[url];
        final result = FetchResult(
          persons: cachedPersons!,
          isRetrievedFromCache: true,
        );
        emit(result);
      } else {
        final persons = await getPersons(url.urlString);
        _cache[url] = persons;
        final result = FetchResult(
          persons: persons,
          isRetrievedFromCache: false,
        );
        emit(result);
      }
    });
  }
}
