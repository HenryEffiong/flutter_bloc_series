part of 'person_bloc.dart';

@immutable
abstract class PersonState {}

class PersonInitial extends PersonState {}

class FetchResult extends PersonState {
  final Iterable<Person> persons;
  final bool isRetrievedFromCache;

  FetchResult({
    required this.persons,
    required this.isRetrievedFromCache,
  });

  @override
  String toString() =>
      'FetchResults (isRetrievedFromCache = $isRetrievedFromCache';
}
