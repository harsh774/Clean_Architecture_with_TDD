//Questions to ask yourself before testing.
/* -> On what does the class depends on. 
      Ans: AuthenticationRepository
   -> How can we create a fake version of dependencies.
      Ans: I will use MockTail
   -> How do we control what our dependencies do.
      Ans: Using the MockTail's APIs.

   Packages use for this.
   1. MockTail
   2. Mockito (Template Based)
*/

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_project/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_project/src/authentication/domain/usecases/create_user.dart';

import 'authentication_repository.mock.dart';



void main() {
  late CreateUser usecase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthRepo();
    usecase = CreateUser(repository);
  });

  const params = CreateUserParams.empty();

  test(
    "should call the [AuthRepo.createUser]",
    () async {
      //Arrange..  : Print together everything we need for our function to work.

      //STUB We are hijacking the president response
      when(
        () => repository.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        ),
      ).thenAnswer((_) async => const Right(null));

      //Act..
      final result = await usecase(params);

      //Assert..

      expect(result, equals(const Right<dynamic, void>(null)));
      verify(
        () => repository.createUser(
            createdAt: params.createdAt,
            name: params.name,
            avatar: params.avatar),
      ).called(1);


      verifyNoMoreInteractions(repository);
    },
  );
}
