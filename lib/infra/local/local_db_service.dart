abstract class LocalDbService {
  Future<List<Map<String, dynamic>>> getData(String path);

  Future clearData(String path);

  Future<int> saveData(
      {required Map<String, dynamic> data, required String path});
}
