/* 
  This is from where we fetch data with defining the structure or modal of how our data look like.

  Here we have defined the blueprint of our data..
*/

import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  const User.empty()
      : this(
          id: "1",
          createdAt: 'empty.createdAt',
          name: 'empty.name',
          avatar: 'empty.avatar',
        );
  final String id;
  final String createdAt;
  final String name;
  final String avatar;

  @override
  List<Object?> get props => [id, name, avatar];
}
