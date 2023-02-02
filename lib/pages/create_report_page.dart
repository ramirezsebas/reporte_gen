import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report_generator/data/providers/loading_provider.dart';
import 'package:report_generator/data/providers/reporte_provider.dart';

class CreateReportPage extends StatefulWidget {
  const CreateReportPage({Key? key}) : super(key: key);

  @override
  State<CreateReportPage> createState() => _CreateReportPageState();
}

class _CreateReportPageState extends State<CreateReportPage> {
  TextEditingController dateinput = TextEditingController();
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
                    _Header(reporteProvider: reporteProvider),
                    Card(
                      margin: const EdgeInsets.all(12.0),
                      elevation: 100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            InputDatePickerFormField(
                              firstDate: DateTime(2021),
                              lastDate: DateTime(2111),
                              initialDate: DateTime.now(),
                              onDateSubmitted: (DateTime value) {
                                reporteProvider.setFecha(value);
                              },
                              onDateSaved: (DateTime? value) {
                                reporteProvider.setFecha(value!);
                              },
                              fieldLabelText: 'Fecha del Trabajo',
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
                                reporteProvider
                                    .setFin(double.tryParse(value) ?? 0.0);
                              },
                              decoration: const InputDecoration(
                                labelText: 'Fin',
                              ),
                            ),
                          ],
                        ),
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

class _Header extends StatelessWidget {
  const _Header({
    Key? key,
    required this.reporteProvider,
  }) : super(key: key);

  final ReporteProvider reporteProvider;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 100,
      margin: const EdgeInsets.all(2.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
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
          ],
        ),
      ),
    );
  }
}
