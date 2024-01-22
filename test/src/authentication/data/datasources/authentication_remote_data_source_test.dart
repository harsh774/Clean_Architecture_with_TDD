import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:tdd_project/core/errors/exceptions.dart';
import 'package:tdd_project/core/utils/constants.dart';
import 'package:tdd_project/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_project/src/authentication/data/models/user_model.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = AuthRemoteDataSrcImp(client);
    registerFallbackValue(Uri());
  });

  group('CreateUser', () {
    test('should complete successfully when [statusCode] is 200 or 201',
        () async {
      when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
        (_) async => http.Response('User created successfully', 201),
      );

      // final result = await remoteDataSource.createUser(
      //   createdAt: 'createdAt',
      //   name: 'name',
      //   avatar: 'avatar',
      // );

      final methodCall = remoteDataSource.createUser;

      // expect(result, equals(Future.value()));
      expect(methodCall(createdAt: 'createdAt', name: 'name', avatar: 'avatar'),
          completes);

      verify(
        () => client.post(
          Uri.https(kBaseUrl, kCreateUserEndPoint),
          body: jsonEncode({
            'createdAt': 'createdAt',
            'name': 'name',
            'avatar': 'avatar',
          }),
        ),
      ).called(1);
      verifyNoMoreInteractions(client);
    });

    test(
      'should throw a [APIException] when'
      '[statusCode] is not 200 or 201',
      () async {
        when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
          (_) async => http.Response('Invalid email address', 400),
        );

        final methodCall = remoteDataSource.createUser;

        expect(
          () async => methodCall(
            createdAt: 'createdAt',
            name: 'name',
            avatar: 'avatar',
          ),
          throwsA(
            const APIException(
                message: 'Invalid email address', statusCode: 400),
          ),
        );

        verify(
          () => client.post(
            Uri.https(kBaseUrl, kCreateUserEndPoint),
            body: jsonEncode({
              'createdAt': 'createdAt',
              'name': 'name',
              'avatar': 'avatar',
            }),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );
  });

  group('GetUser', () {
    const tUsers = [UserModel.empty()];
    test('should return [List<User>] when the [statusCode] is 200', () async {
      when(() => client.get(any())).thenAnswer(
        (_) async => http.Response(jsonEncode([tUsers.first.toMap()]), 200),
      );

      // final result = await remoteDataSource.createUser(
      //   createdAt: 'createdAt',
      //   name: 'name',
      //   avatar: 'avatar',
      // );

      final result = await remoteDataSource.getUsers();

      // expect(result, equals(Future.value()));
      expect(result, equals(tUsers));

      verify(
        () => client.get(
          Uri.https(kBaseUrl, kGetUserEndPoint),
        ),
      ).called(1);
      verifyNoMoreInteractions(client);
    });

    test(
      'should throw a [APIException] when [statusCode] is not 200',
      () async {
        const tMessage = 'Server down, Server down, Server down!!!';
        when(() => client.get(any())).thenAnswer(
          (_) async => http.Response(tMessage, 500),
        );

        final methodCall = remoteDataSource.getUsers;

        expect(
          () async => methodCall(),
          throwsA(
            const APIException(
              message: tMessage,
              statusCode: 500,
            ),
          ),
        );

        verify(
          () => client.get(
            Uri.https(kBaseUrl, kGetUserEndPoint),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );
  });
}
