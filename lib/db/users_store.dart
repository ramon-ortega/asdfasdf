

import 'package:sembast/sembast.dart';
import 'package:sembast_app/db/db.dart';

import '../models/user.dart';

class UsersStore{

  UsersStore._internal();
  static final UsersStore _instance = UsersStore._internal();
  static UsersStore get instance => _instance;

  final DatabaseClient? _db = DB.instance.database;
  final StoreRef<String, Map<String, dynamic>> _store = StoreRef<String, Map<String, dynamic>>('users');

  Future<List<User>> find({Finder? finder}) async {
    List<RecordSnapshot<String, Map>> snapshots = 
      await _store.find(_db!, finder: finder);


    return snapshots.map((RecordSnapshot<String, Map> snap) {
      print("key: ${snap.key}");
      return User.fromJson(snap.value as Map<String,dynamic>);
    }).toList();
    
  }

  Future<void> add(User user) async {
    await _store.record(user.id).put(_db!, user.toJson());
  }

  Future<int> delete({Finder? finder}) async {
    return await _store.delete(_db!, finder: finder);
  }

}