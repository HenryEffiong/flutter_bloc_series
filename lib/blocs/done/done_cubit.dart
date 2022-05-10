import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'done_state.dart';

class DoneCubit extends Cubit<DoneState> {
  DoneCubit() : super(DoneInitial());
}
