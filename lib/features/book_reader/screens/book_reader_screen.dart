import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:read_port/core/domain/enums/extensions.dart';
import 'package:epub_view/epub_view.dart';
import 'package:read_port/core/domain/models/book_model.dart';
import 'package:read_port/features/book_reader/bloc/book_reader_bloc.dart';
import 'package:read_port/features/book_reader/bloc/book_reader_event.dart';
import 'package:read_port/features/book_reader/bloc/book_reader_state.dart';

class BookReaderScreen extends StatefulWidget {
  static const routeName = "book_reader";
  final BookModel book;

  const BookReaderScreen({super.key, required this.book});

  @override
  State<BookReaderScreen> createState() => _BookReaderScreenState();
}

class _BookReaderScreenState extends State<BookReaderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<BookReaderBloc, BookReaderState>(
          builder: (context, state) {
            switch (widget.book.extension) {
              case Extensions.pdf:
                return Scaffold(
                  appBar: AppBar(
                    title: Text(widget.book.title),
                  ),
                  body: PDFView(
                    filePath: widget.book.path,
                    nightMode: ThemeMode.system == ThemeMode.dark,
                  ),
                );

              case Extensions.epub:
                final File epubFile = File(widget.book.path);
                final EpubController _epubController =
                    EpubController(document: EpubDocument.openFile(epubFile), epubCfi: widget.book.readPosition);

                _epubController.currentValueListenable.addListener(() {
                  final value = _epubController.currentValueListenable.value;
                  if (value?.position != null) {
                    final epubCfi = value!.position!.index;
                    context.read<BookReaderBloc>().add(
                          SetLastPositionInBook(
                            idBook: widget.book.id,
                            lastPosition: epubCfi.toString(),
                          ),
                        );
                  }
                });

                return Scaffold(
                  appBar: AppBar(
                    title: EpubViewActualChapter(
                      controller: _epubController,
                      builder: (chapterValue) => Text(
                        'Chapter: ${chapterValue?.chapter?.Title?.replaceAll('\n', '').trim() ?? ''}',
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  endDrawer: Drawer(
                    child: EpubViewTableOfContents(
                      controller: _epubController,
                    ),
                  ),
                  body: EpubView(
                    controller: _epubController,
                  ),
                );
            }
          },
          listener: (context, state) {}),
    );
  }
}
