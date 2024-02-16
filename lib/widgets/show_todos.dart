import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/blocs.dart';
import '../models/todo_model.dart';

class ShowTodos extends StatelessWidget {
  const ShowTodos({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredTodosBloc, FilteredTodosState>(
      builder: (context, state) {
        return ListView.separated(
          primary: false,
          shrinkWrap: true,
          itemCount: state.filteredTodos.length,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(color: Colors.grey);
          },
          itemBuilder: (BuildContext context, int index) {
            final todo = state.filteredTodos[index];
            return Dismissible(
              key: ValueKey(todo.id),
              background: const ShowBackground(direction: 0),
              secondaryBackground: const ShowBackground(direction: 1),
              onDismissed: (_) {
                context.read<TodoListBloc>().add(RemoveTodoEvent(todo: todo));
              },
              confirmDismiss: (_) async {
                return await showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Are you sure?'),
                      content: const Text('Do you really want to delete?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('NO'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('YES'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: TodoItem(todo: todo),
            );
          },
        );
      },
    );
  }
}

class TodoItem extends StatefulWidget {
  const TodoItem({
    super.key,
    required this.todo,
  });

  final Todo todo;

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late final TextEditingController todoDescController;

  @override
  void initState() {
    super.initState();
    todoDescController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            bool error = false;
            todoDescController.text = widget.todo.desc;
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return AlertDialog(
                  title: const Text('Edit Todo'),
                  content: TextField(
                    autofocus: true,
                    controller: todoDescController,
                    decoration: InputDecoration(
                      errorText: error ? 'Value cannot be empty' : null,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('CANCEL'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          error =
                              todoDescController.text.isEmpty ? true : false;
                          if (!error) {
                            Navigator.of(context).pop();
                            context.read<TodoListBloc>().add(
                                  EditTodoEvent(
                                    id: widget.todo.id,
                                    todoDesc: todoDescController.text,
                                  ),
                                );
                          }
                        });
                      },
                      child: const Text('EDIT'),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
      leading: Checkbox(
        value: widget.todo.completed,
        onChanged: (value) {
          context.read<TodoListBloc>().add(ToggleTodoEvent(id: widget.todo.id));
        },
      ),
      title: Text(
        widget.todo.desc,
        style: const TextStyle(fontSize: 20.0),
      ),
    );
  }
}

class ShowBackground extends StatelessWidget {
  const ShowBackground({
    super.key,
    required this.direction,
  });

  final int direction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      color: Colors.red,
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: const Icon(
        Icons.delete,
        size: 30.0,
        color: Colors.white,
      ),
    );
  }
}
