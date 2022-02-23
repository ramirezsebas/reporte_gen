import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report_generator/data/providers/loading_provider.dart';
import 'package:report_generator/data/providers/reporte_provider.dart';

class CreateReportPage extends StatelessWidget {
  const CreateReportPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var reporteProvider = context.read<ReporteProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Reporte'),
      ),
      body: Stack(
        children: [
          Form(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () async {
                            DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2022),
                              lastDate: DateTime(2111),
                            );
                            if (date != null) {
                              reporteProvider.setFecha(date);
                              return;
                            }
                          },
                          icon: const Icon(Icons.date_range),
                          label: const Text("Fecha del Trabajo"),
                        )
                      ],
                    ),
                    TextFormField(
                      onChanged: reporteProvider.setEncargado,
                      decoration: const InputDecoration(
                        labelText: 'Encargado',
                      ),
                    ),
                    TextFormField(
                      onChanged: reporteProvider.setDescripcion,
                      decoration: const InputDecoration(
                        labelText: 'Descripcion',
                      ),
                    ),
                    TextFormField(
                      onChanged: reporteProvider.setLugar,
                      decoration: const InputDecoration(
                        labelText: 'Lugar',
                      ),
                    ),
                    TextFormField(
                      onChanged: reporteProvider.setMaquina,
                      decoration: const InputDecoration(
                        labelText: 'Maquina',
                      ),
                    ),
                    TextFormField(
                      onChanged: reporteProvider.setOperador,
                      decoration: const InputDecoration(
                        labelText: 'Operador',
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      onChanged: (String value) {
                        reporteProvider
                            .setInicio(double.tryParse(value) ?? 0.0);
                      },
                      decoration: const InputDecoration(
                        labelText: 'Inicio',
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      onChanged: (String value) {
                        reporteProvider.setFin(double.tryParse(value) ?? 0.0);
                      },
                      decoration: const InputDecoration(
                        labelText: 'Fin',
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ElevatedButton(
                      child: const Text('Guardar Reporte'),
                      onPressed: () async {
                        try {
                          context.read<LoadingProvider>().setLoading(true);
                          var reporte = await context
                              .read<ReporteProvider>()
                              .createReporte();

                          await context
                              .read<ReporteProvider>()
                              .saveReporte(reporte);
                          context.read<LoadingProvider>().setLoading(false);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Reporte Guardado en la Memoria del Telefono'),
                            ),
                          );
                        } catch (e) {
                          context.read<LoadingProvider>().setLoading(false);
                          print(e);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(e.toString()),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (context.watch<LoadingProvider>().isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
