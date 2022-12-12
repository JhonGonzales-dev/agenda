import 'package:equatable/equatable.dart';

class AgendaEntities extends Equatable {
  const AgendaEntities(
      this.id, this.username, this.namecancha, this.date, this.percentrain);

  final int? id;
  final String username;
  final String namecancha;
  final String date;
  final String percentrain;

  @override
  List<Object?> get props => [id, username, namecancha, date, percentrain];
}
