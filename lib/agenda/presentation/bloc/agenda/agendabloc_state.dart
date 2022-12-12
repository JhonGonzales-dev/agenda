part of 'agendabloc_bloc.dart';

abstract class AgendablocState extends Equatable {
  const AgendablocState();

  @override
  List<Object> get props => [];
}

class Empty extends AgendablocState {}

class Loading extends AgendablocState {}

class Loaded extends AgendablocState {
  final List<AgendaEntities> agenda;

  const Loaded({required this.agenda});

  @override
  List<Object> get props => [agenda];
}

class Error extends AgendablocState {
  final String message;

  const Error({required this.message});
  @override
  List<Object> get props => [message];
}
