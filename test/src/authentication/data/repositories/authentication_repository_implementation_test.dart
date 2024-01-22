import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_project/core/errors/exceptions.dart';
import 'package:tdd_project/core/errors/failure.dart';
import 'package:tdd_project/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_project/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:tdd_project/src/authentication/domain/entities/user.dart';

class MockAuthRemoteDataSrc extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImplementation repoImpl;
  setUp(() {
    remoteDataSource = MockAuthRemoteDataSrc();
    repoImpl = AuthenticationRepositoryImplementation(remoteDataSource);
  });

  const tException =
      APIException(message: 'Unknown Error Occured', statusCode: 500);

  group('CreateUser', () {
    const createdAt = 'what.createdAt';
    const name = 'what.name';
    const avatar = 'what.avatar';
    test(
        'should call the [RemoteDataSource.createUser] and completed successfully.',
        () async {
      //arrange
      when(() => remoteDataSource.createUser(
            createdAt: any(named: 'createdAt'),
            name: any(named: 'name'),
            avatar: any(named: 'avatar'),
          )).thenAnswer((_) async => Future.value());

      //act
      final result = await repoImpl.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      //assert
      //remote src is created a user.
      expect(result, equals(const Right(null)));
      verify(() => remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'should return a [ServerFailure] when the call to the remote source is unsuccessful.',
        () async {
      when(() => remoteDataSource.createUser(
            createdAt: any(named: 'createdAt'),
            name: any(named: 'name'),
            avatar: any(named: 'avatar'),
          )).thenThrow(tException);

      final result = await repoImpl.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      expect(
        result,
        equals(Left(APIFailure(
            message: tException.message, statusCode: tException.statusCode))),
      );

      verify(() => remoteDataSource.createUser(
            createdAt: createdAt,
            name: name,
            avatar: avatar,
          )).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('GetUsers', () {
    test(
        'should  call the [RemoteDataSource] and return [List<Users>] '
        'when call the remote source is successfull.', () async {
      //Arrange..
      when(() => remoteDataSource.getUsers()).thenAnswer(
        (_) async => [],
      );
      //Act
      final result = await repoImpl.getUsers();

      //Assert
      expect(result, isA<Right<dynamic, List<User>>>());
      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'should return a [ServerFailure] when the call to the remote source is unsuccessful.',
        () async {
      when(() => remoteDataSource.getUsers()).thenThrow(tException);

      final result = await repoImpl.getUsers();

      expect(
        result,
        equals(Left(APIFailure.fromException(tException))),
      );

      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
