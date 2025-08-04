import 'package:apptest/bloc/get_user_bloc.dart';
import 'package:apptest/bloc/get_user_event.dart';
import 'package:apptest/bloc/get_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  int? editingUserId;

  @override
  void initState() {
    super.initState();
    context.read<GetUserBloc>().add(const GetAllUser());
  }

  void startEditing(user) {
    setState(() {
      editingUserId = user.id;
      nameController.text = user.username;
      ageController.text = user.age.toString();
    });
  }

  void cancelEditing() {
    setState(() {
      editingUserId = null;
      nameController.clear();
      ageController.clear();
    });
  }

  void submitEdit() {
    final name = nameController.text.trim();
    final ageStr = ageController.text.trim();
    final age = int.tryParse(ageStr);

    if (name.isEmpty || age == null) {
      _showDialog("Error", "Please enter valid name and age");
      return;
    }

    if (editingUserId != null) {
      context
          .read<GetUserBloc>()
          .add(UpdateUser(id: editingUserId!, name: name, age: age));
      cancelEditing();
    } else {
      _showDialog("Error", "No user selected to update");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("homePage"),
      ),
      body: BlocConsumer<GetUserBloc, GetUserState>(
        listener: (context, state) {
          if (state is AddUsersuccess) {
            _showDialog("Success", state.addUser.message);
          } else if (state is AddUserError) {
            _showDialog("Error", state.error);
          } else if (state is DeleteUserSuccess) {
            _showDialog("Delete Success", state.message.message);
          } else if (state is DeleteUserError) {
            _showDialog("Delete Error", state.messageerror);
          } else if (state is UpdateUserSuccess) {
            _showDialog("Update Success", state.updateUser.message);
          } else if (state is UpdateUserError) {
            _showDialog("Update Error", state.error);
          }
        },
        builder: (context, state) {
          if (state is GetAllUserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetAllUserLoaded) {
            final users = state.users;
            return RefreshIndicator(
              onRefresh: () {
                context.read<GetUserBloc>().add(const GetAllUser());
                return Future.value();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (editingUserId != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: TextField(
                                    controller: nameController,
                                    decoration: const InputDecoration(
                                      labelText: 'name',
                                      labelStyle: TextStyle(color: Colors.green), 
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 10),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  flex: 2,
                                  child: TextField(
                                    controller: ageController,
                                    decoration: const InputDecoration(
                                      labelText: 'age',
                                      labelStyle: TextStyle(color: Colors.green), 
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 10),
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                const SizedBox(width: 16),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ElevatedButton(
                                  onPressed: submitEdit,
                                  child: const Text('Update User'),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: cancelEditing,
                                  child: const Text('Cancel'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.only(top: 40,left: 8.0, right: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: TextField(
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      labelText: 'name',
                                      labelStyle: TextStyle(color: Colors.grey[350]!),
                                      contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 10),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  flex: 2,
                                  child: TextField(
                                    controller: ageController,
                                    decoration:  InputDecoration(
                                      labelText: 'age',
                                      labelStyle: TextStyle(color: Colors.grey[350]!), 
                                      contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 10),
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 30),
                              child: Container(
                                width: 100,
                                height: 48,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.red[900]!,
                                      Colors.yellow[600]!,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                    ),
                                    onPressed: () {
                                      final name = nameController.text.trim();
                                      final age = ageController.text.trim();
                                      if (name.isNotEmpty && age.isNotEmpty) {
                                        context.read<GetUserBloc>().add(
                                              AddUser(
                                                  name: name,
                                                  age: int.parse(age)),
                                            );
                                        nameController.clear();
                                        ageController.clear();
                                      }
                                    },
                                    child: const Text(
                                      'Add User',
                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    users.isEmpty
                        ? const Center(
                            child: Column(
                              children: [
                                SizedBox(height: 50),
                                Icon(Icons.people_outline,
                                    size: 60, color: Colors.grey),
                                SizedBox(height: 8),
                                Text(
                                  'Please refresh it.',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Table(
                              border: TableBorder.all(),
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              children: [
                                const TableRow(
                                  decoration: BoxDecoration(color: Colors.grey),
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Name',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Age',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Text(
                                        'Actions',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                ...users.map(
                                  (user) => TableRow(
                                    children: [
                                      GestureDetector(
                                        onTap: () => startEditing(user),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            user.username,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => startEditing(user),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            user.age.toString(),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: IconButton(
                                          icon: const Icon(Icons.delete,
                                              color: Colors.red),
                                          onPressed: () {
                                            context
                                                .read<GetUserBloc>()
                                                .add(DeleteUser(id: user.id));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () {
              context.read<GetUserBloc>().add(const GetAllUser());
              return Future.value();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: const Center(child: Text('Unexpected state.')),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
