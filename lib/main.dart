import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_port/core/dp_injection.dart';
import 'package:read_port/core/routes.dart';
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
      debugShowCheckedModeBanner: false,
      showSemanticsDebugger: false,
      routes: routes(),
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green, brightness: Brightness.light),
          useMaterial3: true,
          brightness: Brightness.light),
      darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green, brightness: Brightness.dark),
          useMaterial3: true,
          brightness: Brightness.dark),
      themeMode: ThemeMode.system,
      home: BlocProvider<HomeBloc>(create: (context) => HomeBloc(), child: const HomeScreen()),
    );
  }
}
