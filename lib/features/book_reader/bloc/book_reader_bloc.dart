import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_port/core/dp_injection.dart';
import 'package:read_port/features/book_reader/bloc/book_reader_event.dart';
import 'package:read_port/features/book_reader/bloc/book_reader_state.dart';
import 'package:read_port/service/book_service.dart';

class BookReaderBloc extends Bloc<BookReaderEvent, BookReaderState> {
  final bookService = getIt.get<BookService>();

  BookReaderBloc() : super(InitialState()) {
    on<SetLastPositionInBook>((event, emit) async {
      await bookService.setLastPosition(id: event.idBook, lastPosition: event.lastPosition ?? "");
    });
  }
}
