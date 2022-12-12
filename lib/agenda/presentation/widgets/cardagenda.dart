import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/agenda_entities.dart';
import '../bloc/agenda/agendabloc_bloc.dart';
import 'customtext.dart';

class CardAgenda extends StatelessWidget {
  final List<AgendaEntities> agenda;
  const CardAgenda({Key? key, required this.agenda}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
          padding: const EdgeInsets.only(bottom: 30),
          crossAxisCount: 2,
          children: List.generate(agenda.length, (i) {
            return Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  CustomText(texto: 'usuario', infotext: agenda[i].username),
                  CustomText(texto: 'Cancha', infotext: agenda[i].namecancha),
                  CustomText(texto: 'fecha', infotext: agenda[i].date),
                  CustomText(texto: 'lluvia', infotext: agenda[i].percentrain),
                  const SizedBox(height: 10),
                  CircleAvatar(
                    child: IconButton(
                        onPressed: () {
                          context
                              .read<AgendaBloc>()
                              .add(DeleteAgenda(agenda[i].id!));
                        },
                        icon: const Icon(Icons.delete)),
                  )
                ],
              ),
            );
          })),
    );
  }
}
