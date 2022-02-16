import 'package:floor/floor.dart';

@Entity(tableName: 'Reporte')
class Reporte {
  @PrimaryKey(autoGenerate: true)
  int id;
  String fecha;
  String encargado;
  String descripcion;
  String lugar;
  String maquina;
  String operador;
  double horaInicio;
  double horaFin;
  bool seleccionado;

  Reporte({
    required this.id,
    required this.fecha,
    this.seleccionado = false,
    required this.encargado,
    required this.descripcion,
    required this.lugar,
    required this.maquina,
    required this.operador,
    required this.horaInicio,
    required this.horaFin,
  });

  factory Reporte.fromJson(Map<String, dynamic> json) => Reporte(
        id: json["id"],
        fecha: json["fecha"],
        encargado: json["encargado"],
        descripcion: json["descripcion"],
        lugar: json["lugar"],
        maquina: json["maquina"],
        operador: json["operador"],
        horaInicio: json["horaInicio"],
        horaFin: json["horaFin"],
        seleccionado: json["seleccionado"],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fecha': fecha,
      'encargado': encargado,
      'seleccionado': seleccionado,
      'descripcion': descripcion,
      'lugar': lugar,
      'maquina': maquina,
      'operador': operador,
      'horaInicio': horaInicio,
      'horaFin': horaFin,
    };
  }
}
