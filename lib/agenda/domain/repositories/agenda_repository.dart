import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../entities/agenda_entities.dart';

abstract class AgendaRepository {
  Future<Either<Failure, List<AgendaEntities>>> getConcreteAgenda(String fecha);

  Future<Either<Failure, int>> creteAgenda(
      String name, String cancha, String fecha);

  Future<Either<Failure, int>> deleteAllAgenda();
  Future<Either<Failure, int>> deleteOneAgenda(int index);
}
