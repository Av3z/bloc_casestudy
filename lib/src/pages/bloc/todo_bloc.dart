import 'dart:async';

import 'package:bloc_casestudy/src/models/todo_model.dart';
import 'package:bloc_casestudy/src/pages/bloc/todo_event.dart';
import 'package:bloc_casestudy/src/pages/bloc/todo_state.dart';
import 'package:bloc_casestudy/src/repositories/todo_repository.dart';

class TodoBloc {
  final _todoRepository = TodoRepository();

  final StreamController<TodoEvent> _inputTodoController = StreamController<TodoEvent>();
  final StreamController<TodoState> _outputTodoController = StreamController<TodoState>();

  Sink<TodoEvent> get inputTodo => _inputTodoController.sink;
  Stream<TodoState> get outputTodo => _outputTodoController.stream;

  TodoBloc(){
    _inputTodoController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(TodoEvent event) async{
    List<TodoModel> todos = [];

    _outputTodoController.add(TodoLoadingState());

    if(event is GetTodos) todos = await _todoRepository.getTodos();
    if(event is PostTodos) todos = await _todoRepository.postTodo(todo: event.todo);
    if(event is DeleteTodo) todos = await _todoRepository.removeTodo(todo: event.todo);

    _outputTodoController.add(TodoLoadedState(todo: todos));
  }
}