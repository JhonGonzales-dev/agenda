import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'custominput.dart';
import '../bloc/agenda/agendabloc_bloc.dart';
import 'custombuttom.dart';

class FormShowModal extends StatefulWidget {
  const FormShowModal({Key? key}) : super(key: key);

  @override
  State<FormShowModal> createState() => _FormShowModalState();
}

class _FormShowModalState extends State<FormShowModal> {
  String fecha = '';
  String username = '';
  var controllerFecha = TextEditingController();
  String? _value;
  final _isEmpty = ValueNotifier<bool>(true);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 30,
            right: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Crear nueva agenda',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 50,
              child: TextFormField(
                maxLines: 1,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: CustomInputs.loginInputDecoration(
                  borderRadius: 15,
                  hint: 'Nombre',
                  fillcolor: Colors.grey.withOpacity(0.1),
                  icon: Icons.person,
                ),
                onChanged: (value) {
                  _isEmpty.value = false;
                  username = value;
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: controllerFecha,
                    enableInteractiveSelection: false,
                    maxLines: 1,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: CustomInputs.loginInputDecoration(
                      borderRadius: 15,
                      hint: 'Fecha',
                      fillcolor: Colors.grey.withOpacity(0.1),
                      icon: Icons.calendar_today,
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      selectedDate(context);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: DropdownButton(
                        iconSize: 40,
                        hint: const Text('Cancha'),
                        underline: Container(height: 0),
                        isExpanded: true,
                        value: _value,
                        borderRadius: BorderRadius.circular(10),
                        items: const [
                          DropdownMenuItem(value: 'A', child: Text('A')),
                          DropdownMenuItem(value: 'B', child: Text('B')),
                          DropdownMenuItem(value: 'c', child: Text('C'))
                        ],
                        onChanged: (value) {
                          setState(() {
                            _value = value;
                          });
                        }),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomButtom(
                      borderRadius: 30,
                      colorButtom: const Color(0xFFFD3C2E),
                      paddingHorizontal: 10,
                      paddingVertical: 10,
                      text: 'Cancelar',
                      isEmpty: false,
                      onpress: () => Navigator.pop(context)),
                ),
                const SizedBox(width: 20),
                Expanded(
                    child: ValueListenableBuilder(
                        valueListenable: _isEmpty,
                        builder: (_, bool value, __) {
                          return CustomButtom(
                            borderRadius: 30,
                            colorButtom: const Color(0XFF52D0A1),
                            paddingHorizontal: 10,
                            paddingVertical: 10,
                            text: 'Guardar',
                            isEmpty: value,
                            onpress: () async {
                              context
                                  .read<AgendaBloc>()
                                  .add(CreateAgenda(username, _value!, fecha));
                              Navigator.pop(context);
                            },
                          );
                        })),
              ],
            )
          ],
        ));
  }

  void selectedDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2030));

    if (picked != null) {
      setState(() {
        fecha = DateFormat('yyyy-MM-dd').format(picked);
        controllerFecha.text = fecha;
      });
    }
  }
}
