import 'package:dartz/dartz.dart';
import 'package:tdd_project/core/errors/exceptions.dart';
import 'package:tdd_project/core/errors/failure.dart';
import 'package:tdd_project/core/utils/typedef.dart';
import 'package:tdd_project/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_project/src/authentication/domain/entities/user.dart';
import 'package:tdd_project/src/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImplementation
    implements AuthenticationRepository {
  const AuthenticationRepositoryImplementation(this._remoteDataSources);
  final AuthenticationRemoteDataSource _remoteDataSources;

  @override
  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    //Test Driven Development

    //Step - 1 call the remote data.

    //Step - 2 check that method will returns proper data.
    //....... // check if when remoteDataSources throws an expection, we return a failure.
    //else if it doesn't, we return the actual data.
    try {
      await _remoteDataSources.createUser(
          createdAt: createdAt, name: name, avatar: avatar);
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try{
      final result = await _remoteDataSources.getUsers();
    return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
