part of 'person_bloc.dart';

@immutable
abstract class PersonEvent {
  const PersonEvent();
}

class LoadPersonsAction extends PersonEvent {
  final PersonUrl url;

  const LoadPersonsAction({required this.url}) : super();
}
