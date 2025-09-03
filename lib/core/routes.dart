import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_port/core/domain/models/book_model.dart';
import 'package:read_port/features/book_reader/bloc/book_reader_bloc.dart';
import 'package:read_port/features/book_reader/screens/book_reader_screen.dart';

Map<String, WidgetBuilder> routes() => {
      BookReaderScreen.routeName: (context) => BlocProvider(
            create: (_) => BookReaderBloc(),
            child: BookReaderScreen(book: ModalRoute.of(context)?.settings.arguments as BookModel),
          )
    };
