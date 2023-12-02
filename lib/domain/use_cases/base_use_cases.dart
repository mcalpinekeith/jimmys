abstract class BaseUseCases<T> {
  late DateTime? lastSave;

  Future<List<T>> get({(String, String)? criteria});
  void remove(T data);
  void save(T data);
}