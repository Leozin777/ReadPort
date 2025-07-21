import 'package:book_nest/features/home/bloc/home_event.dart';
import 'package:book_nest/features/home/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitialState()) {
    on<GetData>((event, emit) {});
  }
}
