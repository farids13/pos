// import 'package:get_storage/get_storage.dart';
//
// class FLocalStorage{
//   static final FLocalStorage _instance = FLocalStorage._internal();
//
//   factory FLocalStorage(){
//     return _instance;
//   }
//
//   FLocalStorage._internal();
//
//   final _storage = GetStorage();
//
//   Future<void> saveDate<T>(String key, T value) async {
//     await _storage.write(key, value);
//   }
//
//   T? readData<T>(String key) {
//     return _storage.read<T>(key);
//   }
//
//   Future<void> removeData(String key) async {
//     await _storage.remove(key);
//   }
//
//   Future<void> clearAll() async{
//     await _storage.erase();
//   }
//
//
// }