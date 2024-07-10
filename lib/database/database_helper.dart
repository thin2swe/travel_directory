import 'package:sqflite/sqflite.dart'; // Import sqflite package
import 'package:path/path.dart';
import 'package:travel_directory/models/booking.dart';
import 'package:travel_directory/models/review.dart';
import 'package:travel_directory/models/user.dart'; // Import path package

class DatabaseHelper {
  static final DatabaseHelper _instance =
      DatabaseHelper._internal(); // Singleton instance
  factory DatabaseHelper() =>
      _instance; // Factory constructor to return the singleton instance

  static Database? _database; // Reference to the database instance

  DatabaseHelper._internal(); // Private constructor

  // Get the database instance
  Future<Database> get database async {
    if (_database != null)
      return _database!; // Return existing database instance if available

    _database =
        await _initDatabase(); // Initialize database if not already done
    return _database!; // Return initialized database instance
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'travels.db');
    return await openDatabase(
      path,
      version: 2, // Increment the version number
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, userName TEXT, password TEXT, email TEXT, phone TEXT);",
        );
        await db.execute(
          "CREATE TABLE reviews(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, review TEXT, rating REAL);",
        );
        await db.execute(
          "CREATE TABLE bookings(id INTEGER PRIMARY KEY AUTOINCREMENT, package_id INTEGER, user_id INTEGER, price NUMERIC, no_of_person INTEGER, booking_date TEXT);",
        );
      },
      // onUpgrade: (db, oldVersion, newVersion) async {
      //   if (oldVersion < 2) {
      //     await db.execute(
      //       "CREATE TABLE reviews(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, review TEXT, rating REAL);",
      //     );
      //   }
      // },
    );
  }

  // Tasks
  // Insert a task into the database
  Future<void> insertTask(String task) async {
    final db = await database; // Get database instance
    await db.insert(
      'tasks',
      {'task': task},
      conflictAlgorithm:
          ConflictAlgorithm.replace, // Conflict resolution strategy
    );
// Debug: Print inserted task
  }

  // Get all tasks from the database
  Future<List<Map<String, dynamic>>> getTasks() async {
    final db = await database; // Get database instance
    final List<Map<String, dynamic>> tasks = await db
        .query('tasks'); // Query tasks table// Debug: Print retrieved tasks
    return tasks; // Return retrieved tasks
  }

  // Delete a task from the database
  Future<void> deleteTask(int id) async {
    final db = await database; // Get database instance
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    ); // Debug: Print deleted task ID
  }
  // end Tasks

  // start User
  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm:
          ConflictAlgorithm.replace, // Conflict resolution strategy
    );
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> tasks = await db.query('users');
    return tasks;
  }

  Future<Map<String, dynamic>?> checkLogin(String name, String password) async {
    final db = await database;
    final result = await db.query(
      "users",
      where: 'userName = ? AND password = ?',
      whereArgs: [name, password],
      limit: 1,
    );
    return result.isNotEmpty ? result.first : null;
  }

  // Delete a task from the database
  Future<void> deleteUser(int id) async {
    final db = await database;
    await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  // end User

  // Review
  Future<void> insertReview(Review review) async {
    final db = await database;
    await db.insert(
      'reviews',
      review.toMap(),
      conflictAlgorithm:
          ConflictAlgorithm.replace, // Conflict resolution strategy
    );
  }

  Future<List<Map<String, dynamic>>> getReviews() async {
    final db = await database;
    final List<Map<String, dynamic>> reviews = await db.query('reviews');
    return reviews;
  }

  Future<void> deleteReview(int id) async {
    final db = await database;
    await db.delete(
      'reviews',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> insertBooking(Booking booking) async {
    final db = await database;
    await db.insert(
      'bookings',
      booking.toMap(),
      conflictAlgorithm:
          ConflictAlgorithm.replace, // Conflict resolution strategy
    );
  }
}
