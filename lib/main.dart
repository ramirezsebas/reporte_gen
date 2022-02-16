import 'dart:io';

import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report_generator/data/database/database.dart';
import 'package:report_generator/data/providers/loading_provider.dart';
import 'package:report_generator/data/providers/reporte_provider.dart';
import 'package:report_generator/data/services/service_locator.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:report_generator/pages/reportes_page.dart';

import 'pages/reportes_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory dataDirectory = await getApplicationDocumentsDirectory();
  String dbPath = join(dataDirectory.path, "'app_database.db'");

  print("La Ubicación de la Base de Datos en el telefono seria: $dbPath");

  AppDatabase database =
      await $FloorAppDatabase.databaseBuilder(dbPath).build();

  setupServiceLocator(database);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ReporteProvider()),
        ChangeNotifierProvider(create: (_) => LoadingProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Report Generator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ReportesPage(),
    );
  }
}
