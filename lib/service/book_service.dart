import 'dart:convert';
import 'package:read_port/core/constants/constants.dart';
import 'package:read_port/core/domain/enums/extensions.dart';
import 'package:uuid/uuid.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/domain/models/book_model.dart';

class BookService {
  Future<BookModel?> pickBook() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'epub'],
      );

      if (result != null && result.files.isNotEmpty) {
        final filePath = result.files.single.path!;
        final fileName = result.files.single.name;
        final fileExtension = result.files.single.extension;

        final uuid = Uuid();
        final bookId = uuid.v4();
        return BookModel(id: bookId, title: fileName, path: filePath, extension: Extensions.values.byName(fileExtension ?? "pdf"));
      }
      return null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> addBook([BookModel? bookP]) async {
    try {
      late BookModel? book;
      if (bookP == null) {
        book = await pickBook();
      } else {
        book = bookP;
      }

      if (book == null) throw Exception("Erro ao adicionar livro");
      final shared = await SharedPreferences.getInstance();
      final books = await getAllBooks();
      books.removeWhere((b) => b.id == book?.id);
      books.add(book);
      final String listOfBooksToSave = json.encode(books.map((book) => book.toJson()).toList());
      await shared.setString(keyListBooks, listOfBooksToSave);
    } on Exception catch (e) {
      rethrow;
    }
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
    try {
      final books = await getAllBooks();
      return books.firstWhere((book) => book.id == id);
    } catch (e) {
      throw Exception("Arquivo não encontrado");
    }
  }

  Future<void> setLastPosition({required String id, required String lastPosition}) async {
    try {
      final book = await getBookById(id);
      book?.readPosition = lastPosition;
      addBook(book);
    } catch (e) {}
  }
}
