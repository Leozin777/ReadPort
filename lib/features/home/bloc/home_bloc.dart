import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_port/core/dp_injection.dart';
import 'package:read_port/features/home/bloc/home_event.dart';
import 'package:read_port/features/home/bloc/home_state.dart';
import 'package:read_port/service/book_service.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final bookService = getIt.get<BookService>();

  HomeBloc() : super(InitialState()) {
    on<GetBooks>((event, emit) async {
      final books = await bookService.getAllBooks();
      emit(ShowBooks(books: books));
    });
  }
}
