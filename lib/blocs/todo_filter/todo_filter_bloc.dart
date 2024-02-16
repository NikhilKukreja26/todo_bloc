import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/todo_model.dart';

part 'todo_filter_event.dart';
part 'todo_filter_state.dart';

class TodoFilterBloc extends Bloc<TodoFilterEvent, TodoFilterState> {
  TodoFilterBloc() : super(TodoFilterState.initial()) {
    on<ChangeFilterEvent>(_onChangeFilter);
  }

  void _onChangeFilter(ChangeFilterEvent event, Emitter<TodoFilterState> emit) {
    emit(state.copyWith(filter: event.newFilter));
  }
}
