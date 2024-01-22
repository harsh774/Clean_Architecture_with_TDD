/* 
  failure can be defined for the developer convenience. 
  Defined a abstract class of failure with message and statuseCode of that failure.

  And created interfaces for different type of failures. like APIFailure, ServerFailure, etc.
*/
import 'package:equatable/equatable.dart';
import 'package:tdd_project/core/errors/exceptions.dart';

abstract class Failure extends Equatable{
  const Failure({required this.message, required this.statusCode});

  final String message;
  final int statusCode;

  String get errorMessage => '$statusCode Error: $message';

  @override
  List<Object> get props => [message, statusCode];

}

class APIFailure extends Failure{
  const APIFailure({required super.message, required super.statusCode});

  APIFailure.fromException(APIException exception) : this(message: exception.message, statusCode: exception.statusCode);
}