import 'package:apptest/bloc/get_user_event.dart';
import 'package:apptest/bloc/get_user_state.dart';
import 'package:apptest/screens/sevices/repos.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetUserBloc extends Bloc<GetUserEvent, GetUserState> {
  final Repos reposi;

  GetUserBloc({required this.reposi}) : super(GetAllUserInitial()) {
    on<GetAllUser>((event, emit) async {
      emit(GetAllUserLoading());
      try {
        final users = await reposi.getAllInformation();
        emit(GetAllUserLoaded(users));
      } catch (e) {
        emit(GetAllUserError(e.toString()));
      }
    });
    on<AddUser>((event, emit) async {
      // print('AddUser event started');
      emit(GetAllUserLoading());
      try {
        final users = await reposi.addUser(name: event.name, age: event.age);
        // print('Repo addUser returned message: ${users.message}');

        if (users.message.toLowerCase().contains('success')) {
          emit(AddUsersuccess(addUser: users));
        } else {
          emit(AddUserError(error: 'Failed to add user: ${users.message}'));
        }
      } catch (e) {
        emit(AddUserError(error: e.toString()));
      }
    });

    on<DeleteUser>((event, emit) async {
      emit(GetAllUserLoading());
      try {
        final users = await reposi.deleteUser(id: event.id);

        if (users.message == 'User deleted successfully') {
          emit(DeleteUserSuccess(message: users));
          // print('User added successfully: ${users.message}');
        } else {
          emit(const AddUserError(
              error: 'Failed to add user or invalid response message.'));
        }
      } catch (e) {
        emit(AddUserError(error: e.toString()));
      }
    });
    on<UpdateUser>((event, emit) async {
      emit(GetAllUserLoading());
      try {
        final users = await reposi.updateUser(
            id: event.id, name: event.name, age: event.age);

        if (users.message.toLowerCase().contains('success')) {
          emit(UpdateUserSuccess(updateUser: users));
        } else {
          emit(UpdateUserError(error: 'Failed to update user: ${users.message}'));
        }
      } catch (e) {
        emit(UpdateUserError(error: e.toString()));
      }
    });
  }
}
