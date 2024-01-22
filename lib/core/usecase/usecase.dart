//Usecases are of two type
/* 
  1. Usecases with Params: In this a type and a param is passed.
  2. Usecases without Params: In this only type is passed.

  NOTE: Params can be of any type --- String, int, List, or customizable(Userdefined).
*/
import 'package:tdd_project/core/utils/typedef.dart';

abstract class UsecaseWithParams<Type, Params> {
  const UsecaseWithParams();
  ResultFuture<Type> call(Params params);
}

abstract class UsecaseWithoutParams<Type> {
  const UsecaseWithoutParams();
  ResultFuture<Type> call();
}
