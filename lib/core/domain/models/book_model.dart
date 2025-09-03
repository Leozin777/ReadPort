import 'package:read_port/core/domain/enums/extensions.dart';

class BookModel {
  final String id;
  final String title;
  final String path;
  final Extensions extension;
  String? readPosition;
  final bool isFavorite;

  BookModel({
    required this.id,
    required this.title,
    required this.path,
    required this.extension,
    this.readPosition,
    this.isFavorite = false,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'] as String,
      title: json['title'] as String,
      path: json['path'] as String,
      extension: Extensions.values.byName(json['extension']),
      readPosition: json['lastPage'],
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'path': path,
      'extension': extension.name,
      'lastPage': readPosition,
      'isFavorite': isFavorite,
    };
  }
}
