// Here we defines the contracts(classes) of our data.

/* 
  This is a contract which will call the methods createUser() or getUser() after the AuthenticationRepo. 
  CreatUser has three parameters with return type of void.
  While GetUser has nothing but it will return a List of Users from the external source.
*/
import 'package:tdd_project/core/utils/typedef.dart';

import '../entities/user.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  ResultFuture<List<User>> getUsers();
}
