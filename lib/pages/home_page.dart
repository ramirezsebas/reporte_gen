import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:report_generator/shared/widgets/reporte_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //   Navigator.pushNamed(context, '/counter');
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return const ReporteCard();
      }),
    );
  }
}
