import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../bloc/agenda/agendabloc_bloc.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({Key? key}) : super(key: key);

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime(2010),
      lastDay: DateTime(2040),
      focusedDay: _focusedDay,
      locale: 'es_ES',
      calendarFormat: CalendarFormat.week,
      headerStyle: const HeaderStyle(titleCentered: true),
      availableCalendarFormats: const {CalendarFormat.week: 'Week'},
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          String fechaSelected = DateFormat('yyyy-MM-dd').format(selectedDay);
          context.read<AgendaBloc>().add(GetAgendaConcrete(fechaSelected));

          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        }
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
    );
  }
}
