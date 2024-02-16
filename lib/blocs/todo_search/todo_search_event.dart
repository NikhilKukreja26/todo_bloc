// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_search_bloc.dart';

sealed class TodoSearchEvent extends Equatable {
  const TodoSearchEvent();

  @override
  List<Object> get props => [];
}

final class SetSearchTermEvent extends TodoSearchEvent {
  final String newSearch;

  const SetSearchTermEvent({
    required this.newSearch,
  });

  @override
  String toString() => 'SetSearchTermEvent(newSearch: $newSearch)';

  @override
  List<Object> get props => [newSearch];
}
