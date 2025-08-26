import 'package:read_port/models/book_model.dart';

abstract class HomeState {}

class InitialState extends HomeState {}

class ShowBooks extends HomeState {
  final List<BookModel> books;

  ShowBooks({required this.books});
}
