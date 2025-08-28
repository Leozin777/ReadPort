import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {},
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          if (state is ShowBooks) {
            if (state.books.isEmpty) {
              return Center(child: Text("Aperte no + para adicionar um documento"));
            }
            return ListView.separated(
              itemBuilder: (_, index) => GestureDetector(
                onTap: () {
                  print("");
                },
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            state.books[index].title,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          state.books[index].lastPage > 0
                              ? Text(
                                  state.books[index].lastPage.toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                )
                              : Spacer(),
                        ],
                      ),
                      Divider()
                    ],
                  ),
                ),
              ),
              itemCount: state.books.length,
              separatorBuilder: (_, i) => SizedBox(
                height: 10,
              ),
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
