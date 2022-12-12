import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../entities/agenda_entities.dart';

import '../repositories/agenda_repository.dart';

class GetConcreteAgenda {
  final AgendaRepository repository;

  GetConcreteAgenda(this.repository);

  Future<Either<Failure, List<AgendaEntities>>> call(String fecha) async {
    return await repository.getConcreteAgenda(fecha);
  }
}

class CreateAgendas {
  final AgendaRepository repository;

  CreateAgendas(this.repository);
  Future<Either<Failure, int>> call(
      String username, String cancha, String fecha) async {
    return await repository.creteAgenda(username, cancha, fecha);
  }
}

class DeleteAllAgendas {
  final AgendaRepository repository;

  DeleteAllAgendas(this.repository);
  Future<Either<Failure, int>> call() async {
    return await repository.deleteAllAgenda();
  }
}

class DeleteAgendas {
  final AgendaRepository repository;

  DeleteAgendas(this.repository);
  Future<Either<Failure, int>> call(int index) async {
    return await repository.deleteOneAgenda(index);
  }
}
