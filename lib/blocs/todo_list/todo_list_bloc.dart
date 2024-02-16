import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/todo_model.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc() : super(TodoListState.initial()) {
    on<AddTodoEvent>(_onAddTodo);
    on<EditTodoEvent>(_onEditTodo);
    on<ToggleTodoEvent>(_onToggleTodo);
    on<RemoveTodoEvent>(_onRemoveTodo);
  }

  void _onAddTodo(AddTodoEvent event, Emitter<TodoListState> emit) {
    final newTodo = Todo(desc: event.todoDesc);
    final newTodos = [...state.todos, newTodo];
    emit(state.copyWith(todos: newTodos));
  }

  void _onEditTodo(EditTodoEvent event, Emitter<TodoListState> emit) {
    final newTodos = state.todos.map((Todo todo) {
      if (todo.id == event.id) {
        return Todo(
          id: event.id,
          desc: event.todoDesc,
          completed: todo.completed,
        );
      } else {
        return todo;
      }
    }).toList();

    emit(state.copyWith(todos: newTodos));
  }

  void _onToggleTodo(ToggleTodoEvent event, Emitter<TodoListState> emit) {
    final newTodos = state.todos.map((Todo todo) {
      if (todo.id == event.id) {
        return Todo(
          id: event.id,
          desc: todo.desc,
          completed: !todo.completed,
        );
      } else {
        return todo;
      }
    }).toList();

    emit(state.copyWith(todos: newTodos));
  }

  void _onRemoveTodo(RemoveTodoEvent event, Emitter<TodoListState> emit) {
    final newTodos =
        state.todos.where((Todo t) => t.id != event.todo.id).toList();

    emit(state.copyWith(todos: newTodos));
  }
}
