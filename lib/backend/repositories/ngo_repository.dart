import '../database/database_helper.dart';
import '../models/ngo.dart';

class NGORepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> insertNgoProfile(NGO ngo) async {
    final db = await _dbHelper.database;
    return await db.insert('ngo_profiles', ngo.toMap());
  }

  Future<NGO?> getNgoProfileByUserId(int userId) async {
    final db = await _dbHelper.database;
    List<Map<String, dynamic>> maps = await db.query(
      'ngo_profiles',
      where: 'userId = ?',
      whereArgs: [userId],
    );

    if (maps.isNotEmpty) {
      return NGO.fromMap(maps.first);
    }
    return null;
  }

  Future<List<NGO>> getAllNgos() async {
    final db = await _dbHelper.database;

    // Join the NGO profiles with user data
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT ngo_profiles.*, users.name, users.email, users.phone, users.address
      FROM ngo_profiles
      INNER JOIN users ON ngo_profiles.userId = users.id
    ''');

    return List.generate(maps.length, (i) => NGO.fromJoinedMap(maps[i]));
  }

  Future<List<NGO>> getNearbyNgos(String location) async {
    final db = await _dbHelper.database;

    // Simple location-based query (in a real app, you'd use coordinates)
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT ngo_profiles.*, users.name, users.email, users.phone, users.address
      FROM ngo_profiles
      INNER JOIN users ON ngo_profiles.userId = users.id
      WHERE ngo_profiles.location LIKE ?
    ''', ['%$location%']);

    return List.generate(maps.length, (i) => NGO.fromJoinedMap(maps[i]));
  }
}
