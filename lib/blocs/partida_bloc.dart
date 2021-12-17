import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ohanami/blocs/events.dart';

class PartidaBloc extends Bloc<Eventos, int> {
  PartidaBloc() : super(0) {
    on<Eventos>((event, emit) {
      if (event is AddPlayers) emit(state + 1);
    });
  }
}
