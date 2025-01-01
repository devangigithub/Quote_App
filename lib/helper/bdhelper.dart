import 'package:path/path.dart';
import 'package:quoteapp/helper/modal_class.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'quotes.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE quotes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            text TEXT,
            author TEXT,
            isFavorite INTEGER DEFAULT 0
          )
        ''');
      },
    );
  }

  Future<List<Quote>> getQuotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('quotes');
    return maps.map((map) => Quote.fromMap(map)).toList();
  }

  Future<List<Quote>> getFavoriteQuotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
    await db.query('quotes', where: 'isFavorite = ?', whereArgs: [1]);
    return maps.map((map) => Quote.fromMap(map)).toList();
  }

  Future<void> insertQuote(Quote quote) async {
    final db = await database;

    final existing = await db.query(
      'quotes',
      where: 'text = ? AND author = ?',
      whereArgs: [quote.text, quote.author],
    );

    if (existing.isEmpty) {
      await db.insert('quotes', quote.toMap());
    }
  }

  Future<void> updateFavoriteStatus(int id, int isFavorite) async {
    final db = await database;
    await db.update(
      'quotes',
      {'isFavorite': isFavorite},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateQuote(int id, String newText, String newAuthor) async {
    final db = await database;
    await db.update(
      'quotes',
      {'text': newText, 'author': newAuthor},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
