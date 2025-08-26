import 'package:book_nest/core/dp_injection.dart';
import 'package:book_nest/features/home/bloc/home_event.dart';
import 'package:book_nest/features/home/bloc/home_state.dart';
import 'package:book_nest/service/book_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final bookService = getIt.get<BookService>();

  HomeBloc() : super(InitialState()) {
    on<GetBooks>((event, emit) async {
      final books = await bookService.getAllBooks();
      emit(ShowBooks(books: books));
    });
  }
}
