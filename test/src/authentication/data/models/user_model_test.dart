import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_project/core/utils/typedef.dart';
import 'package:tdd_project/src/authentication/data/models/user_model.dart';
import 'package:tdd_project/src/authentication/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  // test(description, () => null) --> test work on unit testing or on specific method.
  //While Group lets us to test the groups.
  // group('from map', () { })

  const tModel = UserModel.empty();

  //in this test we are testing that Usermodel is a subclass or not of User entity,,..
  test('should be a sub class of [User] entity', () {
    //Arrange
    //.. tModel

    //Act - for this case we don't need to act here.

    //Assert
    expect(tModel, isA<User>());
  });

  final tJson = fixtures('user.json');
  final tMap = jsonDecode(tJson) as DataMap;

  //in this test we will test in group of fromMap..
  group('fromMap', () {
    //first test to check that it should return a userModel.
    test('should return a [UserModel] with accurate data using Map', () {
      //Arrangement
      //.. tJson & .. tMap

      //Act
      final result = UserModel.fromMap(tMap);

      //Assert
      expect(result, equals(tModel));
    });
  });

  //in this group we'll test in group of fromJSON..
  group('fromJSON', () {
    test('should return a [UserModel] with accurate data using JSON.', () {
      //Arrange
      //.. tJson & .. tMap

      //Act
      final result = UserModel.fromJson(tJson);

      //Assert
      expect(result, equals(tModel));
    });
  });

  //in this group we'll test in group of toMap..
  group('toMap', () {
    test('should return a [Map] with accurate data from UserModel', () {
      //Arrange
      //.. tModel & .. tMap

      //Act
      final result = tModel.toMap();

      //Assert
      expect(result, equals(tMap));
    });
  });

  //in this group we'll test in group of toJSON..
  group('toJSON', () {
    test('should return a [JSON] with accurate data from UserModel', () {
      //Arrange
      //.. tModel & .. tJSON

      //Act
      final result = tModel.toJson();
      final tJson = jsonEncode({
        "id": "1",
        "avatar": "_empty.avatar",
        "createdAt": "_empty.createdAt",
        "name": "_empty.name"
      });

      //Assert
      expect(result, equals(tJson));
    });
  });

  //in this we'll test in grp of copyWith method..
  group('copyWith', () {
    test('should return a [UserModel] with different or updated data', () {
      //Arrange..
      //.. tModel

      //Act
      final result = tModel.copyWith(name: 'Harsh');

      //Assert
      expect(result.name, equals('Harsh'));
      // expect(result, notEqual(first, second))
    });
  });
}
