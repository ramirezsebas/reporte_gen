import 'package:floor/floor.dart';
import 'package:report_generator/data/models/reporte.dart';

@dao
abstract class ReporteDao {
  @Query('SELECT * FROM Reporte')
  Stream<List<Reporte>> findAllReportesStream();

  @Query('SELECT * FROM Reporte')
  Future<List<Reporte>> findAllReportesFuture();

  @Query('SELECT * FROM Reporte WHERE id = :id')
  Future<Reporte?> findReporteByIdStream(int id);

  @Query('SELECT * FROM Reporte WHERE id = :id')
  Future<Reporte?> findReporteByIdFuture(int id);

  @insert
  Future<void> insertReporte(Reporte reporte);

  @update
  Future<void> updateReporte(Reporte reporte);

  @delete
  Future<void> deleteReporte(Reporte reporte);

  @Query('DELETE FROM Reporte')
  Future<void> deleteAllReportes();
}
