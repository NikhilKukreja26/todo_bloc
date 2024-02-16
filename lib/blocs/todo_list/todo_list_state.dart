part of 'todo_list_bloc.dart';

class TodoListState extends Equatable {
  final List<Todo> todos;

  const TodoListState({
    required this.todos,
  });

  factory TodoListState.initial() {
    return TodoListState(
      todos: [
        Todo(id: '1', desc: 'Flutter Bloc Essential Course'),
        Todo(id: '2', desc: 'Dart Crash Course'),
        Todo(id: '3', desc: 'Watch New Movies'),
      ],
    );
  }

  TodoListState copyWith({
    List<Todo>? todos,
  }) {
    return TodoListState(
      todos: todos ?? this.todos,
    );
  }

  @override
  String toString() => 'TodoListState(todos: $todos)';

  @override
  List<Object?> get props => [todos];
}
