class BookModel {
  final String id;
  final String title;
  final String path;
  final String extension;
  final int lastPage;
  final bool isFavorite;

  BookModel({
    required this.id,
    required this.title,
    required this.path,
    required this.extension,
    this.lastPage = 0,
    this.isFavorite = false,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'] as String,
      title: json['title'] as String,
      path: json['path'] as String,
      extension: json['extension'] as String,
      lastPage: json['lastPage'] as int? ?? 0,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'path': path,
      'extension': extension,
      'lastPage': lastPage,
      'isFavorite': isFavorite,
    };
  }
}
