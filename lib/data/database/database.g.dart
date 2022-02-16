// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ReporteDao? _reporteDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 7,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Reporte` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `fecha` TEXT NOT NULL, `encargado` TEXT NOT NULL, `descripcion` TEXT NOT NULL, `lugar` TEXT NOT NULL, `maquina` TEXT NOT NULL, `operador` TEXT NOT NULL, `horaInicio` REAL NOT NULL, `horaFin` REAL NOT NULL, `seleccionado` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ReporteDao get reporteDao {
    return _reporteDaoInstance ??= _$ReporteDao(database, changeListener);
  }
}

class _$ReporteDao extends ReporteDao {
  _$ReporteDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _reporteInsertionAdapter = InsertionAdapter(
            database,
            'Reporte',
            (Reporte item) => <String, Object?>{
                  'id': item.id,
                  'fecha': item.fecha,
                  'encargado': item.encargado,
                  'descripcion': item.descripcion,
                  'lugar': item.lugar,
                  'maquina': item.maquina,
                  'operador': item.operador,
                  'horaInicio': item.horaInicio,
                  'horaFin': item.horaFin,
                  'seleccionado': item.seleccionado ? 1 : 0
                },
            changeListener),
        _reporteUpdateAdapter = UpdateAdapter(
            database,
            'Reporte',
            ['id'],
            (Reporte item) => <String, Object?>{
                  'id': item.id,
                  'fecha': item.fecha,
                  'encargado': item.encargado,
                  'descripcion': item.descripcion,
                  'lugar': item.lugar,
                  'maquina': item.maquina,
                  'operador': item.operador,
                  'horaInicio': item.horaInicio,
                  'horaFin': item.horaFin,
                  'seleccionado': item.seleccionado ? 1 : 0
                },
            changeListener),
        _reporteDeletionAdapter = DeletionAdapter(
            database,
            'Reporte',
            ['id'],
            (Reporte item) => <String, Object?>{
                  'id': item.id,
                  'fecha': item.fecha,
                  'encargado': item.encargado,
                  'descripcion': item.descripcion,
                  'lugar': item.lugar,
                  'maquina': item.maquina,
                  'operador': item.operador,
                  'horaInicio': item.horaInicio,
                  'horaFin': item.horaFin,
                  'seleccionado': item.seleccionado ? 1 : 0
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Reporte> _reporteInsertionAdapter;

  final UpdateAdapter<Reporte> _reporteUpdateAdapter;

  final DeletionAdapter<Reporte> _reporteDeletionAdapter;

  @override
  Stream<List<Reporte>> findAllReportesStream() {
    return _queryAdapter.queryListStream('SELECT * FROM Reporte',
        mapper: (Map<String, Object?> row) => Reporte(
            id: row['id'] as int,
            fecha: row['fecha'] as String,
            seleccionado: (row['seleccionado'] as int) != 0,
            encargado: row['encargado'] as String,
            descripcion: row['descripcion'] as String,
            lugar: row['lugar'] as String,
            maquina: row['maquina'] as String,
            operador: row['operador'] as String,
            horaInicio: row['horaInicio'] as double,
            horaFin: row['horaFin'] as double),
        queryableName: 'Reporte',
        isView: false);
  }

  @override
  Future<List<Reporte>> findAllReportesFuture() async {
    return _queryAdapter.queryList('SELECT * FROM Reporte',
        mapper: (Map<String, Object?> row) => Reporte(
            id: row['id'] as int,
            fecha: row['fecha'] as String,
            seleccionado: (row['seleccionado'] as int) != 0,
            encargado: row['encargado'] as String,
            descripcion: row['descripcion'] as String,
            lugar: row['lugar'] as String,
            maquina: row['maquina'] as String,
            operador: row['operador'] as String,
            horaInicio: row['horaInicio'] as double,
            horaFin: row['horaFin'] as double));
  }

  @override
  Stream<List<Reporte>> findAllReporteByFechaDescStream() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM Reporte ORDER BY fecha DESC',
        mapper: (Map<String, Object?> row) => Reporte(
            id: row['id'] as int,
            fecha: row['fecha'] as String,
            seleccionado: (row['seleccionado'] as int) != 0,
            encargado: row['encargado'] as String,
            descripcion: row['descripcion'] as String,
            lugar: row['lugar'] as String,
            maquina: row['maquina'] as String,
            operador: row['operador'] as String,
            horaInicio: row['horaInicio'] as double,
            horaFin: row['horaFin'] as double),
        queryableName: 'Reporte',
        isView: false);
  }

  @override
  Future<List<Reporte>> findAllReporteByFechaDescFuture() async {
    return _queryAdapter.queryList('SELECT * FROM Reporte ORDER BY fecha DESC',
        mapper: (Map<String, Object?> row) => Reporte(
            id: row['id'] as int,
            fecha: row['fecha'] as String,
            seleccionado: (row['seleccionado'] as int) != 0,
            encargado: row['encargado'] as String,
            descripcion: row['descripcion'] as String,
            lugar: row['lugar'] as String,
            maquina: row['maquina'] as String,
            operador: row['operador'] as String,
            horaInicio: row['horaInicio'] as double,
            horaFin: row['horaFin'] as double));
  }

  @override
  Stream<List<Reporte>> findAllReporteByFechaAscStream() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM Reporte ORDER BY fecha ASC',
        mapper: (Map<String, Object?> row) => Reporte(
            id: row['id'] as int,
            fecha: row['fecha'] as String,
            seleccionado: (row['seleccionado'] as int) != 0,
            encargado: row['encargado'] as String,
            descripcion: row['descripcion'] as String,
            lugar: row['lugar'] as String,
            maquina: row['maquina'] as String,
            operador: row['operador'] as String,
            horaInicio: row['horaInicio'] as double,
            horaFin: row['horaFin'] as double),
        queryableName: 'Reporte',
        isView: false);
  }

  @override
  Future<List<Reporte>> findAllReporteByFechaAscFuture() async {
    return _queryAdapter.queryList('SELECT * FROM Reporte ORDER BY fecha ASC',
        mapper: (Map<String, Object?> row) => Reporte(
            id: row['id'] as int,
            fecha: row['fecha'] as String,
            seleccionado: (row['seleccionado'] as int) != 0,
            encargado: row['encargado'] as String,
            descripcion: row['descripcion'] as String,
            lugar: row['lugar'] as String,
            maquina: row['maquina'] as String,
            operador: row['operador'] as String,
            horaInicio: row['horaInicio'] as double,
            horaFin: row['horaFin'] as double));
  }

  @override
  Stream<Reporte?> findReporteByIdStream(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Reporte WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Reporte(
            id: row['id'] as int,
            fecha: row['fecha'] as String,
            seleccionado: (row['seleccionado'] as int) != 0,
            encargado: row['encargado'] as String,
            descripcion: row['descripcion'] as String,
            lugar: row['lugar'] as String,
            maquina: row['maquina'] as String,
            operador: row['operador'] as String,
            horaInicio: row['horaInicio'] as double,
            horaFin: row['horaFin'] as double),
        arguments: [id],
        queryableName: 'Reporte',
        isView: false);
  }

  @override
  Future<Reporte?> findReporteByIdFuture(int id) async {
    return _queryAdapter.query('SELECT * FROM Reporte WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Reporte(
            id: row['id'] as int,
            fecha: row['fecha'] as String,
            seleccionado: (row['seleccionado'] as int) != 0,
            encargado: row['encargado'] as String,
            descripcion: row['descripcion'] as String,
            lugar: row['lugar'] as String,
            maquina: row['maquina'] as String,
            operador: row['operador'] as String,
            horaInicio: row['horaInicio'] as double,
            horaFin: row['horaFin'] as double),
        arguments: [id]);
  }

  @override
  Stream<Reporte?> findReporteByIdAndFechaStream(int id, String fecha) {
    return _queryAdapter.queryStream(
        'SELECT * FROM Reporte WHERE id = ?1 AND fecha = ?2',
        mapper: (Map<String, Object?> row) => Reporte(
            id: row['id'] as int,
            fecha: row['fecha'] as String,
            seleccionado: (row['seleccionado'] as int) != 0,
            encargado: row['encargado'] as String,
            descripcion: row['descripcion'] as String,
            lugar: row['lugar'] as String,
            maquina: row['maquina'] as String,
            operador: row['operador'] as String,
            horaInicio: row['horaInicio'] as double,
            horaFin: row['horaFin'] as double),
        arguments: [id, fecha],
        queryableName: 'Reporte',
        isView: false);
  }

  @override
  Future<Reporte?> findReporteByIdAndFechaFuture(int id, String fecha) async {
    return _queryAdapter.query(
        'SELECT * FROM Reporte WHERE id = ?1 AND fecha = ?2',
        mapper: (Map<String, Object?> row) => Reporte(
            id: row['id'] as int,
            fecha: row['fecha'] as String,
            seleccionado: (row['seleccionado'] as int) != 0,
            encargado: row['encargado'] as String,
            descripcion: row['descripcion'] as String,
            lugar: row['lugar'] as String,
            maquina: row['maquina'] as String,
            operador: row['operador'] as String,
            horaInicio: row['horaInicio'] as double,
            horaFin: row['horaFin'] as double),
        arguments: [id, fecha]);
  }

  @override
  Future<void> deleteAllReportes() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Reporte');
  }

  @override
  Future<void> insertReporte(Reporte reporte) async {
    await _reporteInsertionAdapter.insert(reporte, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateReporte(Reporte reporte) async {
    await _reporteUpdateAdapter.update(reporte, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteReporte(Reporte reporte) async {
    await _reporteDeletionAdapter.delete(reporte);
  }
}
