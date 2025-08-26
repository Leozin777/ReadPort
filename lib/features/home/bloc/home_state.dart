import 'package:book_nest/models/book_model.dart';

abstract class HomeState {}

class InitialState extends HomeState {}

class ShowBooks extends HomeState {
  final List<BookModel> books;

  ShowBooks({required this.books});
}
