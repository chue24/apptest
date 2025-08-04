import 'package:apptest/models/delete_user_model.dart';
import 'package:apptest/models/get_all_model.dart';
import 'package:apptest/models/postusermodel.dart';
import 'package:apptest/models/update_user_mode.dart';
import 'package:equatable/equatable.dart';

class GetUserState extends Equatable {
  const GetUserState();

  @override
  List<Object> get props => [];
}

class GetAllUserInitial extends GetUserState {}

class GetAllUserLoading extends GetUserState {}

class GetAllUserLoaded extends GetUserState {
  final List<Row> users;

  const GetAllUserLoaded(this.users);

  @override
  List<Object> get props => [users];
}

class GetAllUserError extends GetUserState {
  final String message;

  const GetAllUserError(this.message);

  @override
  List<Object> get props => [message];
}

class AddUsersuccess extends GetUserState {
  final Postusermodel addUser;

  const AddUsersuccess({required this.addUser});

  @override
  List<Object> get props => [addUser];
}

class AddUserError extends GetUserState {
  final String error;

  const AddUserError({required this.error});

  @override
  List<Object> get props => [error];
}

class DeleteUserSuccess extends GetUserState {
  final Deleteusermodel message;

  const DeleteUserSuccess({required this.message});

  @override
  List<Object> get props => [message];
}
class DeleteUserError extends GetUserState {
  final String messageerror;

  const DeleteUserError({required this.messageerror});

  @override
  List<Object> get props => [messageerror];
}
class UpdateUserSuccess extends GetUserState {
  final Updateusermodel updateUser;

  const UpdateUserSuccess({required this.updateUser});

  @override
  List<Object> get props => [updateUser];
}
class UpdateUserError extends GetUserState {
  final String error;

  const UpdateUserError({required this.error});

  @override
  List<Object> get props => [error];
}