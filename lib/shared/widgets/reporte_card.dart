import 'package:flutter/material.dart';
import 'package:report_generator/data/models/reporte.dart';

class ReporteCard extends StatelessWidget {
  const ReporteCard({Key? key, required this.reporte}) : super(key: key);

  final Reporte reporte;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 25.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(12.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        width: double.infinity,
        height: 350,
        child: Column(
          children: [
            CardText(label: "Fecha", value: reporte.fecha),
            Divider(),
            CardText(label: 'Descripción', value: reporte.descripcion),
            SizedBox(
              height: 10,
            ),
            CardText(label: 'Encargado', value: reporte.encargado),
            SizedBox(
              height: 10,
            ),
            CardText(label: 'Maquina', value: reporte.maquina),
            SizedBox(
              height: 10,
            ),
            CardText(label: "Operador", value: reporte.operador),
            SizedBox(
              height: 10,
            ),
            CardText(
                label: "Hora de Inicio", value: reporte.horaInicio.toString()),
            SizedBox(
              height: 10,
            ),
            CardText(label: "Hora de Fin", value: reporte.horaFin.toString()),
            SizedBox(
              height: 10,
            ),
            CardText(
                label: "Hora Total",
                value: (reporte.horaFin - reporte.horaInicio).toString()),
            SizedBox(
              height: 10,
            ),
            CardText(label: "Lugar", value: reporte.lugar),
          ],
        ),
      ),
    );
  }
}

class CardText extends StatelessWidget {
  const CardText({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          "$label: ",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          "$value",
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
        ),
      ],
    );
  }
}
