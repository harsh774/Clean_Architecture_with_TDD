import 'dart:convert';

import 'package:tdd_project/core/errors/exceptions.dart';
import 'package:tdd_project/core/utils/constants.dart';
import 'package:tdd_project/core/utils/typedef.dart';
import 'package:tdd_project/src/authentication/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  Future<List<UserModel>> getUsers();
}

const kCreateUserEndPoint = '/test-api/users';
const kGetUserEndPoint = '/test-api/users';

class AuthRemoteDataSrcImp implements AuthenticationRemoteDataSource {
  const AuthRemoteDataSrcImp(this._client);
  final http.Client _client;
  @override
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    //steps to implement.

    //step 1 - check to make sure that it returns the correct data when client/server is called.
    //And response code is 200 or proper response code.
    //step 2 - check to make sure that it 'THROWS A CUSTOM EXCEPTION'
    //with the right message when statusCode is bad one.

    try {
      final response = await _client.post(
        Uri.https(kBaseUrl,kCreateUserEndPoint),
        body: jsonEncode(
          {
            'createdAt': createdAt,
            'name': name,
          },
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        }
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _client.get(
      Uri.https(kBaseUrl, kGetUserEndPoint),
    );

    if (response.statusCode != 200) {
      throw APIException(
        message: response.body,
        statusCode: response.statusCode,
      );
    }

    return List<DataMap>.from(jsonDecode(response.body) as List)
        .map((userData) => UserModel.fromMap(userData))
        .toList();
    } on APIException {
      rethrow;
    } 
    catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
