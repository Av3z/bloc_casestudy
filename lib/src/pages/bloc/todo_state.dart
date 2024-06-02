import 'package:bloc_casestudy/src/models/todo_model.dart';

abstract class TodoState {
  final List<TodoModel> todos;

  TodoState({required this.todos});
}

class TodoInitialState extends TodoState {
  TodoInitialState() : super(todos: []);
}

class TodoLoadingState extends TodoState {
  TodoLoadingState() : super(todos: []);
}

class TodoLoadedState extends TodoState {
  TodoLoadedState({required List<TodoModel> todo}) : super(todos: todo);
}

class TodoErrorState extends TodoState {
  final Exception exception;

  TodoErrorState({required this.exception}) : super(todos: []);

}