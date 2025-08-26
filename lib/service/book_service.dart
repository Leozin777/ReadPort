import 'dart:convert';

import 'package:book_nest/core/constants/constants.dart';
import 'package:uuid/uuid.dart';
import 'package:book_nest/models/book_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookService {
  Future<BookModel?> pickBook() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'txt', 'epub'],
    );

    if (result != null && result.files.isNotEmpty) {
      final filePath = result.files.single.path!;
      final fileName = result.files.single.name;
      final fileExtension = result.files.single.extension;

      final uuid = Uuid();
      final bookId = uuid.v4();
      return BookModel(id: bookId, title: fileName, path: filePath, extension: fileExtension ?? "");
    }
    return null;
  }

  Future<void> addBook(BookModel book) async {
    final shared = await SharedPreferences.getInstance();
    final books = await getAllBooks();
    books.add(book);
    final String listOfBooksToSave = json.encode(books);
    await shared.setString(keyListBooks, listOfBooksToSave);
  }

  Future<List<BookModel>> getAllBooks() async {
    final shared = await SharedPreferences.getInstance();
    final listOfBooksJson = shared.getString(keyListBooks);
    if (listOfBooksJson != null) {
      final List<dynamic> decodedJson = json.decode(listOfBooksJson) as List<dynamic>;
      return decodedJson.map((book) => BookModel.fromJson(book)).toList();
    }
    return [];
  }

  Future<BookModel?> getBookById(String id) async {
    final books = await getAllBooks();
    return books.firstWhere((book) => book.id == id);
  }
}
