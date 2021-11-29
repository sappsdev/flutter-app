import 'package:app/config/cafe_api.dart';
import 'package:app/config/notifications_service.dart';
import 'package:app/pages/todo/todo_model.dart';
import 'package:flutter/material.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> list = [];
  int count = 0;

  Todo service = Todo(
    id: "", 
    name: "", 
    message: "",
    country: "",
    color: "", 
    type: "", 
    active: false,
  );

  setTodo() {
    service = Todo(
      id: "", 
      name: "", 
      message: "",
      country: "",
      color: "", 
      type: "", 
      active: false,
    );
  }


  Future<bool> form() async {
    var url = "/service/new";
    if (service.id.isNotEmpty) url = "/service/edit";
    try {
      final _ = await CafeApi.post(url, {});
      getListTodo();
      CafeApi.configureDio();
      notifyListeners();
      return true;
    } catch (e) {
      NotificationsService.showSnackbarError('Error');
      return false;
    }
  }

  getListTodo() async {
    notifyListeners();
  }
}