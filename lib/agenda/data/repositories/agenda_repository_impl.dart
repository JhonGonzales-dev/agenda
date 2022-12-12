import 'dart:convert';

import 'package:agenda/core/error/failures.dart';
import 'package:agenda/agenda/domain/entities/agenda_entities.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/exceptions.dart';
import '../../domain/repositories/agenda_repository.dart';
import '../datasources/agenda_local_data.dart';
import '../models/agenda_model.dart';

class AgendaRepositoryImpl implements AgendaRepository {
  final AgendaLocalDataSource localDataSource;
  AgendaRepositoryImpl({required this.localDataSource});
  @override
  Future<Either<Failure, List<AgendaEntities>>> getConcreteAgenda(
      String fecha) async {
    try {
      final filteredAgenda = <AgendaEntities>[];
      final localAgenda = await localDataSource.getAllAgenda(fecha);

      for (var agenda in localAgenda) {
        if (agenda.dates == fecha) {
          filteredAgenda.add(agenda);
        }
      }

      return Right(filteredAgenda);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, int>> creteAgenda(
      String name, String cancha, String fecha) async {
    try {
      var body = jsonEncode({
        "username": name,
        "namecancha": cancha,
        "date": fecha,
        "percentrain": "80%"
      });

      var agendamodel = AgendaModel.fromJson(body);
      final localAgenda = await localDataSource.newAgenda(agendamodel);
      return Right(localAgenda);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, int>> deleteAllAgenda() async {
    try {
      final localAgenda = await localDataSource.deleteAllAgenda();
      return Right(localAgenda);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, int>> deleteOneAgenda(int index) async {
    try {
      final localAgenda = await localDataSource.deleteAgenda(index);
      return Right(localAgenda);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
