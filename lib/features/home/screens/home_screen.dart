import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:read_port/core/domain/enums/extensions.dart';
import 'package:read_port/features/book_reader/screens/book_reader_screen.dart';
import 'package:read_port/features/home/bloc/home_bloc.dart';
import 'package:read_port/features/home/bloc/home_event.dart';
import 'package:read_port/features/home/bloc/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(GetBooks());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<HomeBloc>(context).add(GetBooks());
  }

  Widget _buildBookIcon(Extensions extension) {
    switch (extension) {
      case Extensions.pdf:
        return const Icon(Icons.picture_as_pdf, color: Colors.red);
      case Extensions.epub:
        return const Icon(Icons.menu_book, color: Colors.green);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {},
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          if (state is ShowBooks) {
            if (state.books.isEmpty) {
              return Center(child: Text("Aperte no + para adicionar um documento"));
            }
            return ListView.builder(
              itemCount: state.books.length,
              itemBuilder: (context, index) {
                final book = state.books[index];
                return ListTile(
                  leading: _buildBookIcon(book.extension),
                  title: Text(book.title),
                  subtitle: Text(book.extension.name.toUpperCase()),
                  onTap: () {
                    Navigator.of(context).pushNamed(BookReaderScreen.routeName, arguments: state.books[index]);
                  },
                );
              },
            );
          }
          return SizedBox();
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => BlocProvider.of<HomeBloc>(context).add(AddBook()),
        child: Icon(Icons.add),
      ),
    );
  }
}
