import 'package:equatable/equatable.dart';

class GetUserEvent  extends Equatable {
  const GetUserEvent();

  @override
  List<Object?> get props => [];
  
}

class GetAllUser  extends GetUserEvent {
  const GetAllUser();
  @override
  List<Object?> get props => [];
}
class AddUser  extends GetUserEvent {
  final String name;
  final int age;
  const AddUser({required this.name, required this.age});
  @override
  List<Object?> get props => [name,age];
}
class DeleteUser  extends GetUserEvent {
  final int id;
  const DeleteUser({required this.id});
  @override
  List<Object?> get props => [id];
}
class UpdateUser  extends GetUserEvent {
  final int id;
  final String name;
  final int age;
  const UpdateUser({required this.id, required this.name, required this.age});
  @override
  List<Object?> get props => [id,name,age];
}