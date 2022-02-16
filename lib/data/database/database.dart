// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:path/path.dart';
import 'package:report_generator/data/daos/reporte_dao.dart';
import 'package:report_generator/data/models/reporte.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 7, entities: [Reporte])
abstract class AppDatabase extends FloorDatabase {
  ReporteDao get reporteDao;
}


