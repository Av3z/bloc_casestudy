import 'package:bloc_casestudy/src/models/todo_model.dart';

abstract class TodoEvent {}

class GetTodos extends TodoEvent{}

class PostTodos extends TodoEvent {
  final TodoModel todo;

  PostTodos({required this.todo});
}

class DeleteTodo extends TodoEvent{
  final TodoModel todo;

  DeleteTodo({required this.todo});
}