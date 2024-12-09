import 'package:get_storage/get_storage.dart';
class GetStorageData {
  static final GetStorage _storage = GetStorage();

  static write(key,value){
    _storage.write(key, value);
  }

  static read(String key){
    return _storage.read(key);
  }

  static remove(String key){
    _storage.remove(key);
  }

  static containsKey(String key){
    _storage.hasData(key);
  }
}
