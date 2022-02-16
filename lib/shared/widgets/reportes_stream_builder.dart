import 'package:flutter/material.dart';
import 'package:report_generator/data/database/database.dart';
import 'package:report_generator/data/models/reporte.dart';
import 'package:report_generator/data/services/service_locator.dart';
import 'package:report_generator/shared/widgets/no_data.dart';
import 'package:report_generator/shared/widgets/reporte_card.dart';

class ReportesStreamBuilder extends StatelessWidget {
  final _database = serviceLocator<AppDatabase>();
  ReportesStreamBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Reporte>>(
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
          return const NoData(
            title: "NO HAY REPORTES!",
          );
        }

        if (reports.isEmpty) {
          return const NoData(
            title: "NO HAY REPORTES!",
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
      stream: _database.reporteDao.findAllReporteByFechaAscStream(),
    );
  }
}
