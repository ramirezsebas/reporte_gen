import 'package:flutter/material.dart';
import 'package:report_generator/data/models/reporte.dart';
import 'package:report_generator/shared/utils/date_manager.dart';

class ReporteCard extends StatelessWidget {
  const ReporteCard({Key? key, required this.reporte}) : super(key: key);

  final Reporte reporte;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        width: double.infinity,
        height: 300,
        child: Column(
          children: [
            Text("Fecha: ${reporte.fecha}"),
            Text("Descripción: ${reporte.descripcion}"),
            Text("Encargado: ${reporte.encargado}"),
            Text("Maquina: ${reporte.maquina}"),
            Text("Operador: ${reporte.operador}"),
            Text("Hora: Inicio ${reporte.horaInicio}"),
            Text("Hora: Fin ${reporte.horaFin}"),
            Text("Hora: Total ${reporte.horaFin - reporte.horaInicio}"),
            Text("Lugar: ${reporte.lugar}"),
          ],
        ),
      ),
    );
  }
}
