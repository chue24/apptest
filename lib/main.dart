import 'package:apptest/bloc/get_user_bloc.dart';
import 'package:apptest/bloc/get_user_event.dart';
import 'package:apptest/bloc/get_user_state.dart';
import 'package:apptest/screens/home/home_screen.dart';
import 'package:apptest/screens/sevices/repositories/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<Repository>(create: (context) => Repository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<GetUserBloc>(
            create: (context) => GetUserBloc(
              reposi: RepositoryProvider.of<Repository>(context),
            ),
          )
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
