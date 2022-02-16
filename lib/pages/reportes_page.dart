import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report_generator/data/database/database.dart';
import 'package:report_generator/data/models/reporte.dart';
import 'package:report_generator/data/providers/loading_provider.dart';
import 'package:report_generator/data/providers/reporte_provider.dart';
import 'package:report_generator/data/services/service_locator.dart';
import 'package:report_generator/pages/create_report_page.dart';
import 'package:report_generator/shared/widgets/reporte_card.dart';

class ReportesPage extends StatelessWidget {
  final _database = serviceLocator<AppDatabase>();
  ReportesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Reportes'),
        ),
        backgroundColor: Colors.white,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'delete_btn',
              tooltip: "Eliminar Todos Los Reportes",
              onPressed: () async {
                context.read<LoadingProvider>().setLoading(true);

                var reportes =
                    await _database.reporteDao.findAllReportesFuture();

                if (reportes.isEmpty) {
                  context.read<LoadingProvider>().setLoading(false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('No hay reportes para Eliminar'),
                    ),
                  );
                  return;
                }

                await _database.reporteDao.deleteAllReportes();

                context.read<LoadingProvider>().setLoading(false);
              },
              child: const Icon(Icons.delete),
            ),
            const SizedBox(width: 10),
            FloatingActionButton(
              heroTag: 'download_btn',
              tooltip: "Descargar Reporte Semanal",
              onPressed: () async {
                context.read<LoadingProvider>().setLoading(true);
                await context.read<ReporteProvider>().downloadReportes();
                context.read<LoadingProvider>().setLoading(false);
              },
              child: const Icon(Icons.download),
            ),
            const SizedBox(width: 10),
            FloatingActionButton(
              heroTag: 'add_btn',
              tooltip: "Crear Nuevo Reporte",
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CreateReportPage(),
                ),
              ),
              child: const Icon(Icons.add),
            ),
          ],
        ),
        body: Stack(
          children: [
            StreamBuilder<List<Reporte>>(
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error'),
                  );
                }

                final reports = snapshot.data;

                if (reports == null) {
                  return Column(
                    children: const [
                      Image(image: AssetImage('assets/images/no_data.png')),
                      Text(
                        'NO HAY REPORTES!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                }

                if (reports.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Image(image: AssetImage('assets/images/no_data.png')),
                      Text(
                        'NO HAY REPORTES!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                }

                if (snapshot.hasData) {
                  final reports = snapshot.data;
                  return ListView.builder(
                    itemCount: reports!.length,
                    itemBuilder: (_, index) => ReporteCard(
                      reporte: reports[index],
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
              stream: _database.reporteDao.findAllReportesStream(),
            ),
            if (context.watch<LoadingProvider>().isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
