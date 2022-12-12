import 'dart:convert';

import '../../domain/entities/agenda_entities.dart';

class AgendaModel extends AgendaEntities {
  const AgendaModel({
    this.ids,
    required this.usernames,
    required this.namecanchas,
    required this.dates,
    required this.percentrains,
  }) : super(ids, usernames, namecanchas, dates, percentrains);

  final int? ids;
  final String usernames;
  final String namecanchas;
  final String dates;
  final String percentrains;

  factory AgendaModel.fromJson(String str) =>
      AgendaModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AgendaModel.fromMap(Map<String, dynamic> json) => AgendaModel(
        ids: json["id"],
        usernames: json["username"],
        namecanchas: json["namecancha"],
        dates: json["date"],
        percentrains: json["percentrain"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "namecancha": namecancha,
        "date": date,
        "percentrain": percentrain,
      };
}
