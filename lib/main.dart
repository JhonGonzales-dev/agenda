import 'package:agenda/agenda/presentation/pages/agendapage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'agenda/presentation/bloc/agenda/agendabloc_bloc.dart';
import 'injection.dart' as di;
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AgendaBloc>(),
      child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          home: AgendaPage()),
    );
  }
}
