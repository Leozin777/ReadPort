import 'package:book_nest/core/dp_injection.dart';
import 'package:book_nest/features/home/bloc/home_bloc.dart';
import 'package:book_nest/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  setupDpInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider<HomeBloc>(create: (context) => HomeBloc(), child: const HomeScreen()),
    );
  }
}
