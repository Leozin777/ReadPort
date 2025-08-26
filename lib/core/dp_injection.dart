import 'package:book_nest/service/book_service.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance();

void setupDpInjection() {
  getIt.registerSingleton<BookService>(BookService());
}
