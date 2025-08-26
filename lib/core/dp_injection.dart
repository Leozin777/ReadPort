import 'package:get_it/get_it.dart';
import 'package:read_port/service/book_service.dart';

final GetIt getIt = GetIt.instance;

void setupDpInjection() {
  getIt.registerSingleton<BookService>(BookService());
}
