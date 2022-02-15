import 'package:flutter/material.dart';

class CreateReportPage extends StatelessWidget {
  const CreateReportPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Report'),
      ),
      body: Form(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Fecha de Reporte',
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2111),
                    );
                    if (date != null) {
                      print(date);
                      return;
                    }
                  },
                  icon: const Icon(Icons.date_range),
                  label: const Text("Fecha del Trabajo"),
                )
              ],
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Encargado',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Descripcion',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Lugar',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Maquina',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Operador',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Inicio',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Fin',
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
              child: const Text('Guardar Reporte'),
              onPressed: () {},
            ),
          ],
        ),
      )),
    );
  }
}
