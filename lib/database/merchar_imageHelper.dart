import 'dart:async';
import 'dart:io';
import 'package:retailer/models/image_sqflite_M.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class ImageDbHelper {
  static ImageDbHelper _imageDbHelper;
  static Database _imagedatabase;
  static const String table = 'PhotosTable';
  static const String db_name = 'photos.db';
  static const String _id = 'id';
  static const String photo = 'photo';
  static const String shopSysKey = 'shopSysKey';
  static const String activeTaskCode = 'activeTaskCode';
   static const String remark= 'remark';

  ImageDbHelper._createInstane();

  factory ImageDbHelper() {
    if (_imageDbHelper == null) {
      _imageDbHelper = ImageDbHelper._createInstane();
    }
    return _imageDbHelper;
  }

  Future<Database> get database async {
    if (_imagedatabase == null) {
      _imagedatabase = await initializedDatabase();
    }
    return _imagedatabase;
  }

  Future<Database> initializedDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + db_name;

    var notesDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $table($_id INTEGER PRIMARY KEY AUTOINCREMENT,$photo TEXT,$shopSysKey TEXT,$activeTaskCode TEXT,$remark TEXT)');
  }

  Future<List<Map<String, dynamic>>> getTaskCodeMapList(
      String activeSysKey, String getActiveTaskCode) async {
    Database db = await this.database;
//  var result = await db.rawQuery('SELECTE * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(table,
        orderBy: '$_id DESC',
        where: '$shopSysKey = ? AND $activeTaskCode = ?',
        whereArgs: [activeSysKey, getActiveTaskCode]);
    return result;
  }

  Future<List<Map<String, dynamic>>> getSysKeyMapList(
      String activeSysKey) async {
    Database db = await this.database;
//  var result = await db.rawQuery('SELECTE * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(table,
        orderBy: '$_id DESC',
        where: '$shopSysKey = ?',
        whereArgs: [activeSysKey]);
    return result;
  }

  Future<int> insertPhoto(Photo photo) async {
    Database db = await this.database;
    var result = await db.insert(table, photo.toMap());
    print('Insert Successfully');
    return result;
  }

  Future<int> updatePhoto(Photo photo) async {
    Database db = await this.database;
    var result = await db
        .update(table, photo.toMap(), where: '$_id = ?', whereArgs: [photo.id]);

    return result;
  }

  Future<int> deletePhoto(int id) async {
    Database db = await this.database;
    var result = await db.rawDelete('DELETE FROM $table WHERE $_id = $id');
    return result;
  }

  Future<int> deleteAllPhoto() async {
    Database db = await this.database;
    var result = await db.rawDelete('DELETE FROM $table');
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $table');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Photo>> getPhotoByTaskCode(
      String activeSysKey, String activeTaskCode) async {
    var noteMapList = await getTaskCodeMapList(activeSysKey, activeTaskCode);
    int count = noteMapList.length;
    List<Photo> noteList = List<Photo>();
    for (int i = 0; i < count; i++) {
      noteList.add(Photo.formMapObject(noteMapList[i]));
    }
    return noteList;
  }

  Future<List<Photo>> getPhotoBySysKey(String activeSysKey) async {
    var noteMapList = await getSysKeyMapList(activeSysKey);
    int count = noteMapList.length;
    List<Photo> noteList = List<Photo>();
    for (int i = 0; i < count; i++) {
      noteList.add(Photo.formMapObject(noteMapList[i]));
    }
    return noteList;
  }
}
