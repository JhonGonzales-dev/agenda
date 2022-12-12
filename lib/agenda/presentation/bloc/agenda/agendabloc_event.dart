part of 'agendabloc_bloc.dart';

abstract class AgendablocEvent extends Equatable {
  const AgendablocEvent();
}

class GetAgendaConcrete extends AgendablocEvent {
  final String fecha;
  const GetAgendaConcrete(this.fecha);

  @override
  List<Object?> get props => [fecha];
}

class CreateAgenda extends AgendablocEvent {
  final String username;
  final String cancha;
  final String fecha;

  const CreateAgenda(this.username, this.cancha, this.fecha);

  @override
  List<Object?> get props => [fecha, cancha, fecha];
}

class DeleteAllAgenda extends AgendablocEvent {
  const DeleteAllAgenda();

  @override
  List<Object?> get props => [];
}

class DeleteAgenda extends AgendablocEvent {
  final int index;
  const DeleteAgenda(this.index);

  @override
  List<Object?> get props => [index];
}
