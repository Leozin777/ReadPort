abstract class BookReaderEvent {}

class SetLastPositionInBook extends BookReaderEvent {
  final String idBook;
  final String? lastPosition;

  SetLastPositionInBook({required this.idBook, required this.lastPosition});
}
