import 'package:chatgpt/logic/bloc/bloc/response_model_bloc.dart';
import 'package:chatgpt/logic/cubit/loading/loading_cubit.dart';
import 'package:chatgpt/presentation/screens/home.dart';
import 'package:chatgpt/presentation/theme/mainTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoadingCubit()),
        BlocProvider(create: (context) => ResponseModelBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeData,
        home: const HomeScreen(),
      ),
    );
  }
}
