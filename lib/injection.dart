import 'package:get_it/get_it.dart';

import 'agenda/data/datasources/agenda_local_data.dart';
import 'agenda/data/repositories/agenda_repository_impl.dart';
import 'agenda/domain/repositories/agenda_repository.dart';
import 'agenda/domain/usecases/agenda_usecase.dart';
import 'agenda/presentation/bloc/agenda/agendabloc_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - agenda
  sl.registerFactory(() => AgendaBloc(
      deleteAgenda: sl(),
      getConcreteAgenda: sl(),
      createAgend: sl(),
      deleteAllAgenda: sl()));
  // caso de uso

  sl.registerLazySingleton(() => GetConcreteAgenda(sl()));
  sl.registerLazySingleton(() => CreateAgendas(sl()));
  sl.registerLazySingleton(() => DeleteAllAgendas(sl()));
  sl.registerLazySingleton(() => DeleteAgendas(sl()));
  //repositorio
  sl.registerLazySingleton<AgendaRepository>(() => AgendaRepositoryImpl(
        localDataSource: sl(),
      ));
  //  datasource

  sl.registerLazySingleton<AgendaLocalDataSource>(
      () => AgendaLocalDataSourceImpl());

  //! Core
}
