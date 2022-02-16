import 'package:floor/floor.dart';
import 'package:report_generator/data/models/reporte.dart';

@dao
abstract class ReporteDao {
  @Query('SELECT * FROM Reporte')
  Stream<List<Reporte>> findAllReportesStream();

  @Query('SELECT * FROM Reporte')
  Future<List<Reporte>> findAllReportesFuture();

  @Query('SELECT * FROM Reporte ORDER BY fecha DESC')
  Stream<List<Reporte>> findAllReporteByFechaDescStream();

  @Query('SELECT * FROM Reporte ORDER BY fecha DESC')
  Future<List<Reporte>> findAllReporteByFechaDescFuture();

  @Query('SELECT * FROM Reporte ORDER BY fecha ASC')
  Stream<List<Reporte>> findAllReporteByFechaAscStream();

  @Query('SELECT * FROM Reporte ORDER BY fecha ASC')
  Future<List<Reporte>> findAllReporteByFechaAscFuture();

  @Query('SELECT * FROM Reporte WHERE id = :id')
  Stream<Reporte?> findReporteByIdStream(int id);

  @Query('SELECT * FROM Reporte WHERE id = :id')
  Future<Reporte?> findReporteByIdFuture(int id);

  @Query('SELECT * FROM Reporte WHERE id = :id AND fecha = :fecha')
  Stream<Reporte?> findReporteByIdAndFechaStream(int id, String fecha);

  @Query('SELECT * FROM Reporte WHERE id = :id AND fecha = :fecha')
  Future<Reporte?> findReporteByIdAndFechaFuture(int id, String fecha);

  @insert
  Future<void> insertReporte(Reporte reporte);

  @update
  Future<void> updateReporte(Reporte reporte);

  @delete
  Future<void> deleteReporte(Reporte reporte);

  @Query('DELETE FROM Reporte')
  Future<void> deleteAllReportes();
}
