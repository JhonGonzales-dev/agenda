import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';

import '../../../domain/entities/agenda_entities.dart';
import '../../../domain/usecases/agenda_usecase.dart';

part 'agendabloc_event.dart';
part 'agendabloc_state.dart';

class AgendaBloc extends Bloc<AgendablocEvent, AgendablocState> {
  final GetConcreteAgenda getConcreteAgenda;
  final CreateAgendas createAgend;
  final DeleteAllAgendas deleteAllAgenda;
  final DeleteAgendas deleteAgenda;

  AgendaBloc(
      {required this.deleteAllAgenda,
      required this.createAgend,
      required this.getConcreteAgenda,
      required this.deleteAgenda})
      : super(Empty()) {
    on<AgendablocEvent>((event, emit) async {
      //...........................................

      if (event is GetAgendaConcrete) {
        emit(Loading());
        final failureOrAgenda = await getConcreteAgenda(event.fecha);
        failureOrAgenda.fold(
          (failure) => const Error(message: 'INVALID'),
          (listagendas) => {emit(Loaded(agenda: listagendas))},
        );
      }
      //..............................................

      else if (event is CreateAgenda) {
        final failureOrCreate =
            await createAgend(event.username, event.cancha, event.fecha);
        failureOrCreate.fold((l) => emit(const Error(message: 'INVALID')), (r) {
          add(GetAgendaConcrete(event.fecha));
        });
      }
      //..................................................
      else if (event is DeleteAllAgenda) {
        final failureOrDelete = await deleteAllAgenda();
        failureOrDelete.fold((l) => emit(const Error(message: 'INVALID')), (r) {
          add(const GetAgendaConcrete("2012-02-27"));
        });
      }
      //.....................................................
      else if (event is DeleteAgenda) {
        final failureOrDelete = await deleteAgenda(event.index);
        failureOrDelete.fold((l) => emit(const Error(message: 'INVALID')), (r) {
          add(const GetAgendaConcrete("2012-02-27"));
        });
      }
    });
  }
}
