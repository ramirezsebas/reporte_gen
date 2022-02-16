import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:report_generator/data/database/database.dart';
import 'package:report_generator/data/models/reporte.dart';
import 'package:report_generator/data/services/service_locator.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ReporteProvider with ChangeNotifier {
  AppDatabase _database = serviceLocator<AppDatabase>();
  String? encargado;
  DateTime? fecha;
  String? descripcion;
  String? lugar;
  String? maquina;
  String? operador;
  double? inicio;
  double? fin;

  void setEncargado(String encargado) {
    this.encargado = encargado;
    notifyListeners();
  }

  void setFecha(DateTime fecha) {
    this.fecha = fecha;
    notifyListeners();
  }

  void setDescripcion(String descripcion) {
    this.descripcion = descripcion;
    notifyListeners();
  }

  void setLugar(String lugar) {
    this.lugar = lugar;
    notifyListeners();
  }

  void setMaquina(String maquina) {
    this.maquina = maquina;
    notifyListeners();
  }

  void setOperador(String operador) {
    this.operador = operador;
    notifyListeners();
  }

  void setInicio(double inicio) {
    this.inicio = inicio;
    notifyListeners();
  }

  void setFin(double fin) {
    this.fin = fin;
    notifyListeners();
  }

  Future<Reporte> createReporte() async {
    List<Map<String, Object?>> listQuery =
        await _database.database.rawQuery('SELECT MAX(id) FROM REPORTE');
    var query = listQuery.first;
    var id = query.values.first;
    var newId = id == null ? 1 : int.parse(id.toString()) + 1;

    if (encargado == null || encargado!.isEmpty) {
      throw Exception('El encargado es requerido');
    }

    if (fecha == null) {
      throw Exception('La fecha es requerida');
    }

    if (descripcion == null || descripcion!.isEmpty) {
      throw Exception('La descripción es requerida');
    }

    if (lugar == null || lugar!.isEmpty) {
      throw Exception('El lugar es requerido');
    }

    if (maquina == null || maquina!.isEmpty) {
      throw Exception('La máquina es requerida');
    }

    if (operador == null || operador!.isEmpty) {
      throw Exception('El operador es requerido');
    }

    if (inicio == null) {
      throw Exception('La hora de inicio es requerida');
    }

    if (fin == null) {
      throw Exception('La hora de fin es requerida');
    }

    return Reporte(
      id: newId,
      encargado: encargado ?? '',
      fecha: "${fecha?.year}-${fecha?.month}-${fecha?.day}",
      descripcion: descripcion ?? '',
      lugar: lugar ?? '',
      maquina: maquina ?? '',
      operador: operador ?? '',
      horaInicio: inicio ?? 0,
      horaFin: fin ?? 0,
    );
  }

  Future<void> saveReporte(Reporte reporte) async {
    await _database.reporteDao.insertReporte(reporte);
  }

  Future<void> downloadReportes() async {
    List<Reporte> reportes = await _database.reporteDao.findAllReportesFuture();
    var doc = pw.Document();
    if (reportes.length < 4) {
      doc.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              children: <pw.Widget>[
                pw.Header(
                  level: 0,
                  child: pw.Text(
                    'Reporte Semanal',
                    style: const pw.TextStyle(fontSize: 32),
                  ),
                ),
                pw.SizedBox(height: 10),
                ...reportes.map(
                  (Reporte reporte) {
                    return pw.Column(
                      children: [
                        pw.Header(
                          child: pw.Text(
                            'Fecha ${reporte.fecha}',
                            style: const pw.TextStyle(fontSize: 20),
                          ),
                        ),
                        pw.Table(
                          children: [
                            pw.TableRow(
                              children: [
                                pw.Text('Encargado: '),
                                pw.Text(reporte.encargado),
                              ],
                            ),
                            pw.TableRow(
                              children: [
                                pw.Text('Descripción: '),
                                pw.Text(reporte.descripcion),
                              ],
                            ),
                            pw.TableRow(
                              children: [
                                pw.Text('Lugar: '),
                                pw.Text(reporte.lugar),
                              ],
                            ),
                            pw.TableRow(
                              children: [
                                pw.Text('Máquina: '),
                                pw.Text(reporte.maquina),
                              ],
                            ),
                            pw.TableRow(
                              children: [
                                pw.Text('Operador: '),
                                pw.Text(reporte.operador),
                              ],
                            ),
                            pw.TableRow(
                              children: [
                                pw.Text('Hora de inicio: '),
                                pw.Text(reporte.horaInicio.toString()),
                              ],
                            ),
                            pw.TableRow(
                              children: [
                                pw.Text('Hora de fin: '),
                                pw.Text(reporte.horaFin.toString()),
                              ],
                            ),
                            pw.TableRow(
                              children: [
                                pw.Text('Horas trabajadas: '),
                                pw.Text(
                                  (reporte.horaFin - reporte.horaInicio)
                                      .toString(),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    );
                  },
                ),
                pw.SizedBox(height: 25),
                pw.Table(children: [
                  pw.TableRow(
                    children: [
                      pw.Text('TOTAL NETO: '),
                      pw.Text(reportes
                          .fold<double>(
                            0,
                            (previousValue, element) =>
                                previousValue +
                                (element.horaFin - element.horaInicio),
                          )
                          .toString()),
                    ],
                  ),
                ])
              ],
            );
          },
        ),
      );
    } else {
      //Divide Array By 4 elements
      List<List<Reporte>> reportesBy4 = [];
      List<Reporte> reportesTemp = [];
      for (int i = 0; i < reportes.length; i++) {
        reportesTemp.add(reportes[i]);
        if (i % 4 == 3) {
          reportesBy4.add(reportesTemp);
          reportesTemp = [];
        }
      }
      reportesBy4.add(reportesTemp);
      for (var reportes4 in reportesBy4) {
        doc.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.a4,
            build: (pw.Context context) {
              return pw.Column(
                children: <pw.Widget>[
                  pw.Header(
                    level: 0,
                    child: pw.Text(
                      'Reporte Semanal',
                      style: const pw.TextStyle(fontSize: 32),
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  ...reportes4.map(
                    (Reporte reporte) {
                      return pw.Column(
                        children: [
                          pw.Header(
                            child: pw.Text(
                              'Fecha ${reporte.fecha}',
                              style: const pw.TextStyle(fontSize: 20),
                            ),
                          ),
                          pw.Table(
                            children: [
                              pw.TableRow(
                                children: [
                                  pw.Text('Encargado: '),
                                  pw.Text(reporte.encargado),
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text('Descripción: '),
                                  pw.Text(reporte.descripcion),
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text('Lugar: '),
                                  pw.Text(reporte.lugar),
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text('Máquina: '),
                                  pw.Text(reporte.maquina),
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text('Operador: '),
                                  pw.Text(reporte.operador),
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text('Hora de inicio: '),
                                  pw.Text(reporte.horaInicio.toString()),
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text('Hora de fin: '),
                                  pw.Text(reporte.horaFin.toString()),
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text('Horas trabajadas: '),
                                  pw.Text(
                                    (reporte.horaFin - reporte.horaInicio)
                                        .toString(),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      );
                    },
                  ),
                  pw.SizedBox(height: 25),
                  pw.Table(children: [
                    pw.TableRow(
                      children: [
                        pw.Text('TOTAL NETO: '),
                        pw.Text(
                          reportes
                              .fold<double>(
                                0,
                                (previousValue, element) =>
                                    previousValue +
                                    (element.horaFin - element.horaInicio),
                              )
                              .toString(),
                        ),
                      ],
                    ),
                  ])
                ],
              );
            },
          ),
        );
      }
    }

    final directory = await getExternalStorageDirectory();
    final file = File('${directory!.path}/reportes.pdf');
    await file.writeAsBytes(await doc.save());
    OpenFile.open(file.path);
  }

  Future<void> downloadReporte(Reporte reporte) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: <pw.Widget>[
              pw.Header(
                level: 0,
                child: pw.Text('Reporte Semanal'),
              ),
              pw.Header(
                level: 0,
                child: pw.Text('Fecha ${reporte.fecha}'),
              ),
              pw.Table(
                children: [
                  pw.TableRow(
                    children: [
                      pw.Text('Encargado'),
                      pw.Text(reporte.encargado),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text('Descripción'),
                      pw.Text(reporte.descripcion),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text('Lugar'),
                      pw.Text(reporte.lugar),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text('Máquina'),
                      pw.Text(reporte.maquina),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text('Operador'),
                      pw.Text(reporte.operador),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text('Hora de Inicio'),
                      pw.Text(reporte.horaInicio.toString()),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text('Hora de Fin'),
                      pw.Text(reporte.horaFin.toString()),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text('Hora Total'),
                      pw.Text("${reporte.horaFin - reporte.horaInicio}"),
                    ],
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/reporte.pdf');
    await file.writeAsBytes(await pdf.save());
    await OpenFile.open(file.path);
  }
}
