import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:mobicar/modelos/carro.dart';

class ClasseBanco {
  static const String TABLE_CARRO = "Carro";
  static const String COLUMN_ID = "id";
  static const String COLUMN_NOME = "nome";
  static const String COLUMN_CODIGO = "codigo";

  ClasseBanco._();
  static final ClasseBanco db = ClasseBanco._();

  Database _database;

  Future<Database> get database async {
    print("Get Banco");

    if (_database != null) {
      return _database;
    }

    _database = await criarBanco();

    return _database;
  }

  Future<Database> criarBanco() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'mobicar4.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        print("criando tabela carros");

        await database.execute(
          "CREATE TABLE $TABLE_CARRO  ("
          "$COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,"
          "$COLUMN_NOME TEXT,"
          "$COLUMN_CODIGO TEXT"
          ")",
        );
      },
    );
  }

  Future<List<Carro>> getCarros() async {
    final db = await database;

    var carros = await db
        .query(TABLE_CARRO, columns: [COLUMN_ID, COLUMN_NOME, COLUMN_CODIGO]);

    List<Carro> listaPassagem = <Carro>[];

    carros.forEach((carroSelecionado) {
      Carro carro = Carro.fromJson(carroSelecionado);

      listaPassagem.add(carro);
    });

    return listaPassagem;
  }

  Future<Carro> insert(Carro carro) async {
    final db = await database;
    carro.id = await db.insert(TABLE_CARRO, carro.toJson());
    return carro;
  }

  Future<int> delete(String nome) async {
    final db = await database;

    return await db.delete(
      TABLE_CARRO,
      where: "nome = ?",
      whereArgs: [nome],
    );
  }

  Future<int> update(Carro carro) async {
    final db = await database;

    return await db.update(
      TABLE_CARRO,
      carro.toJson(),
      where: "id = ?",
      whereArgs: [carro.id],
    );
  }
}
