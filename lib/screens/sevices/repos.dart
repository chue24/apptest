import 'package:apptest/models/delete_user_model.dart';
import 'package:apptest/models/get_all_model.dart';
import 'package:apptest/models/postusermodel.dart';
import 'package:apptest/models/update_user_mode.dart';

abstract class Repos {
  Future<List<Row>> getAllInformation();
  Future<Postusermodel> addUser({required String name, required int age});
  Future<Deleteusermodel> deleteUser({required int id});
  Future<Updateusermodel> updateUser({
    required int id,
    required String name,
    required int age,
  });
}
