import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report_generator/data/providers/loading_provider.dart';
import 'package:report_generator/shared/widgets/action_bar.dart';
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
