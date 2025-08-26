import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_port/core/dp_injection.dart';
import 'package:read_port/features/home/screens/home_screen.dart';
import 'features/home/bloc/home_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
