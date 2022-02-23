import 'package:india_learner/models/DownloadVideoModel.dart';
import 'package:india_learner/utils/DatabaseProvider.dart';

class DownloadsVideoDao {
  final dbProvider = DatabaseProvider.databaseProvider;

  Future<int> saveDownloadedVideo(DownloadVideoModel downloadVideoModel) async {
    final db = await dbProvider.database;

    var result = db.insert(tableName, downloadVideoModel.toDatabaseJson());

    return result;
  }

  Future<List<DownloadVideoModel>> getAllDownloads({List<String> columns, String query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty) {
        result = await db.query(tableName, columns: columns, where: 'name LIKE ?', whereArgs: ["%$query%"]);
      } else {
        result = await db.query(tableName, columns: columns);
      }
      List<DownloadVideoModel> downloadVideoList = result.isNotEmpty ? result.map((item) => DownloadVideoModel.fromDatabaseJson(item)).toList() : [];
      print("RRRRRRRR ${result.length}");
      return downloadVideoList;
    }
  }
}
