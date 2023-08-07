abstract class HiveDataSource<T> {
  Future<bool> init();

  int count();
  Future<List<T>> getAll();
  Future<void> add(T obj);
  Future<void> delete(T obj);
  Future<void> deleteAll();
}
