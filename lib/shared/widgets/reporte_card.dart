import 'package:flutter/material.dart';
import 'package:report_generator/shared/utils/date_manager.dart';

class ReporteCard extends StatelessWidget {
  const ReporteCard({
    Key? key,
  }) : super(key: key);

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
            Text("Fecha ${DateManager.getCurrentDate()}"),
          ],
        ),
      ),
    );
  }
}
