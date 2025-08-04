import 'package:apptest/bloc/get_user_state.dart';
import 'package:apptest/models/delete_user_model.dart';
import 'package:apptest/models/get_all_model.dart';
import 'package:apptest/models/postusermodel.dart';
import 'package:apptest/models/update_user_mode.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetUserEmiiter {
  GetUserEmiiter();
  getAllUserLoadingState({required Emitter emit}) {
    emit(GetAllUserLoading());
  }

  getAllUserLoadedState({required Emitter emit, required List<Row> users}) {
    emit(GetAllUserLoaded(users));
  }

  getAllUserErrorState({required Emitter emit, required String message}) {
    emit(GetAllUserError(message));
  }

// < --- Add User --- >
  addUserLoadingState({required Emitter emit}) {
    emit(GetAllUserLoading());
  }

  addUserLoadedState({required Emitter emit, required Postusermodel addUsers}) {
    emit(AddUsersuccess(addUser: addUsers));
  }

  addUserErrorState({required Emitter emit, required String error}) {
    emit(AddUserError(error: error));
  }

// < --- Delete User --- >
  deleteUserSuccessState(
      {required Emitter emit, required Deleteusermodel message}) {
    emit(DeleteUserSuccess(message: message));
  }

  deleteUserErrorState({required Emitter emit, required String error}) {
    emit(DeleteUserError(messageerror: error));
  }

  // < --- Update User --- >
  updateUserSuccessState(
      {required Emitter emit, required Updateusermodel message}) {
    emit(UpdateUserSuccess(updateUser: message));
  }
  updateUserErrorState({required Emitter emit, required String error}) {
    emit(UpdateUserError(  error: error));
  }
}
