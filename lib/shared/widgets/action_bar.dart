import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report_generator/data/database/database.dart';
import 'package:report_generator/data/providers/loading_provider.dart';
import 'package:report_generator/data/providers/reporte_provider.dart';
import 'package:report_generator/data/services/service_locator.dart';
import 'package:report_generator/pages/create_report_page.dart';

class ActionBar extends StatelessWidget {
  final _database = serviceLocator<AppDatabase>();
  ActionBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          heroTag: 'delete_btn',
          tooltip: "Eliminar Todos Los Reportes",
          onPressed: () async {
            context.read<LoadingProvider>().setLoading(true);

            var reportes = await _database.reporteDao.findAllReportesFuture();

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
            var reportes = await _database.reporteDao.findAllReportesFuture();
            if (reportes.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('NO HAY REPORTES PARA DESCARGAR'),
                ),
              );
              return;
            }
            context.read<ReporteProvider>().downloadReportes();
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
    );
  }
}
