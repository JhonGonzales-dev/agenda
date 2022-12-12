import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/agenda/agendabloc_bloc.dart';
import '../widgets/cardagenda.dart';
import '../widgets/customcalendar.dart';
import '../widgets/showmodal.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({Key? key}) : super(key: key);

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  @override
  Widget build(BuildContext context) {
    final String initialFecha = DateFormat('yyyy-MM-dd').format(DateTime.now());
    context.read<AgendaBloc>().add(GetAgendaConcrete(initialFecha));

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('AgendaApp'),
          actions: actionsAppbar(context),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25.0)),
                ),
                builder: (_) => const FormShowModal());
          },
          child: const Icon(Icons.add),
        ),
        body: const Agenda());
  }
}

List<Widget> actionsAppbar(BuildContext context) {
  return [
    IconButton(
        onPressed: () {
          context.read<AgendaBloc>().add(const GetAgendaConcrete('2012-02-27'));
        },
        icon: const Icon(Icons.replay_outlined)),
    IconButton(
        onPressed: () {
          context.read<AgendaBloc>().add(const DeleteAllAgenda());
        },
        icon: const Icon(Icons.delete_forever))
  ];
}

class Agenda extends StatelessWidget {
  const Agenda({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(color: Colors.white),
          child: const CustomCalendar(),
        ),
        BlocBuilder<AgendaBloc, AgendablocState>(
          builder: (context, state) {
            if (state is Empty) {
              return const Center(child: Text('SEARCHING'));
            } else if (state is Loading) {
              return const CircularProgressIndicator();
            } else if (state is Loaded) {
              return CardAgenda(agenda: state.agenda);
            } else if (state is Error) {
              return Text(state.message);
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }
}
