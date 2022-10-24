import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_cubit_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchState());
}
