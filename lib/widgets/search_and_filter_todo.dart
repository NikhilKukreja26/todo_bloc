import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/blocs.dart';
import '../models/todo_model.dart';

class SearchAndFilterTodo extends StatelessWidget {
  const SearchAndFilterTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'Search todos...',
            filled: true,
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (String? newSearchTerm) {
            if (newSearchTerm != null) {
              context
                  .read<TodoSearchBloc>()
                  .add(SetSearchTermEvent(newSearch: newSearchTerm));
            }
          },
        ),
        const SizedBox(height: 10.0),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilterButton(filter: Filter.all),
            FilterButton(filter: Filter.active),
            FilterButton(filter: Filter.completed),
          ],
        ),
      ],
    );
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
    required this.filter,
  });

  final Filter filter;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoFilterBloc, TodoFilterState>(
      builder: (context, state) {
        final currentFilter = state.filter;
        return TextButton(
          onPressed: () {
            context
                .read<TodoFilterBloc>()
                .add(ChangeFilterEvent(newFilter: filter));
          },
          style: TextButton.styleFrom(
            foregroundColor:
                currentFilter == filter ? Colors.blue : Colors.grey,
          ),
          child: Text(
            filter == Filter.all
                ? 'All'
                : filter == Filter.active
                    ? 'Active'
                    : 'Completed',
            style: const TextStyle(
              fontSize: 18.0,
            ),
          ),
        );
      },
    );
  }
}
