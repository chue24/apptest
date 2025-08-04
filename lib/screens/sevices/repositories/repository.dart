import 'dart:convert';

import 'package:apptest/models/delete_user_model.dart';
import 'package:apptest/models/get_all_model.dart';
import 'package:apptest/models/postusermodel.dart';
import 'package:apptest/models/update_user_mode.dart';
import 'package:apptest/screens/sevices/repos.dart';
import 'package:dio/dio.dart';

class Repository extends Repos {
  final String getAllInformaUlr = 'http://10.0.2.2:2000/api/v1/get-all-users';
  final String addUserUrl = 'http://10.0.2.2:2000/api/v1/create-user';
  final String deleteUserUrl = 'http://10.0.2.2:2000/api/v1/delete-user/';
  final String updateUserUrl = 'http://10.0.2.2:2000/api/v1/update-user/';
  Dio dio = Dio();

  @override
  Future<Postusermodel> addUser({
    required String name,
    required int age,
  }) async {
    try {
      final response = await dio.post(
        addUserUrl,
        data: jsonEncode({
          'username': name,
          'age': age,
        }),
        options: Options(
          headers: {'Content-Type': 'application/json'},
          validateStatus: (status) => true,
        ),
      );

      // print('Response status code: ${response.statusCode}');
      // print('Response data: ${response.data}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = postusermodelFromJson(jsonEncode(response.data));

        // Check if message contains "success"
        if (data.message.toLowerCase().contains('success')) {
          return data;
        } else {
          throw Exception('Failed to add user: ${data.message}');
        }
      } else {
        throw Exception(
            'Failed to add user. Status code: ${response.statusCode}, Response: ${response.data}');
      }
    } catch (e) {
      throw Exception('Error adding user: $e');
    }
  }

  @override
  Future<List<Row>> getAllInformation() async {
    try {
      final response = await dio.get(getAllInformaUlr);
      // print(" fhggfghfgh ${response.statusCode}");
      // print('object ${response.data}');
      if (response.statusCode == 200) {
        final data = getallmodelFromJson(jsonEncode(response.data));
        return data.rows;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      // print('object $e');
      throw Exception('Error fetching information: $e');
    }
  }

  @override
  Future<Updateusermodel> updateUser({
    required int id,
    required String name,
    required int age,
  }) async {
    final url = Uri.parse('$updateUserUrl$id');

    try {
      final response = await dio.put(
        url.toString(),
        data: jsonEncode({
          'username': name,
          'age': age,
        }),
        options: Options(
          headers: {'Content-Type': 'application/json'},
          validateStatus: (status) => true,
        ),
      );
      // print('---------------->${response.statusCode}');
      // print('object =======>${response.data}');
      if (response.statusCode == 200) {
        return Updateusermodel.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to update user. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // print('kkkkkkkkkkkkkkkkkkkkkkkkkkkkk $e');
      throw Exception('Error updating user: $e');
    }
  }

  @override
  Future<Deleteusermodel> deleteUser({required int id}) async {
    final url = Uri.parse('$deleteUserUrl$id');

    try {
      final response = await dio.delete(url.toString());

      if (response.statusCode == 200) {
        // print('User deleted successfully');
        return Deleteusermodel.fromJson(response.data);
      } else {
        // print('Failed to delete user. Status code: ${response.statusCode}');
        throw Exception('Failed to delete user.');
      }
    } catch (e) {
      // print('Error deleting user: $e');
      throw Exception('Error deleting user: $e');
    }
  }
}
