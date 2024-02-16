import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/todo_model.dart';

import '../blocs.dart';

part 'active_todo_count_event.dart';
part 'active_todo_count_state.dart';

class ActiveTodoCountBloc
    extends Bloc<ActiveTodoCountEvent, ActiveTodoCountState> {
  late final StreamSubscription<TodoListState> todoListStateSubscription;
  final TodoListBloc todoListBloc;
  final int initialActiveTodoCount;

  ActiveTodoCountBloc({
    required this.initialActiveTodoCount,
    required this.todoListBloc,
  }) : super(ActiveTodoCountState(activeTodoCount: initialActiveTodoCount)) {
    todoListStateSubscription = todoListBloc.stream.listen((
      TodoListState todoListState,
    ) {
      final int currentActiveTodoCount = todoListState.todos
          .where((Todo todo) => !todo.completed)
          .toList()
          .length;
      add(CalculateActiveTodoCountEvent(
        activeTodoCount: currentActiveTodoCount,
      ));
    });

    on<CalculateActiveTodoCountEvent>(_onCalculateActiveTodoCount);
  }

  void _onCalculateActiveTodoCount(
      CalculateActiveTodoCountEvent event, Emitter<ActiveTodoCountState> emit) {
    emit(state.copyWith(activeTodoCount: event.activeTodoCount));
  }

  @override
  Future<void> close() {
    todoListStateSubscription.cancel();
    return super.close();
  }
}
