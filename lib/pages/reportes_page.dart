import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report_generator/data/database/database.dart';
import 'package:report_generator/data/models/reporte.dart';
import 'package:report_generator/data/providers/loading_provider.dart';
import 'package:report_generator/data/providers/reporte_provider.dart';
import 'package:report_generator/data/services/service_locator.dart';
import 'package:report_generator/pages/create_report_page.dart';
import 'package:report_generator/shared/widgets/action_bar.dart';
import 'package:report_generator/shared/widgets/reporte_card.dart';
import 'package:report_generator/shared/widgets/reportes_stream_builder.dart';

class ReportesPage extends StatelessWidget {
  ReportesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Reportes'),
        ),
        backgroundColor: Colors.white,
        floatingActionButton: ActionBar(),
        body: Stack(
          children: [
            ReportesStreamBuilder(),
          ],
        ),
      ),
    );
  }
}
