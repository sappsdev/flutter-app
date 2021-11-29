import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  static late AnimationController menuController;
  bool sideOpen = false;
  String currentPage = "";
  String pageTitle = "Dashboard";


  setCurrentPageUrl({
    required String routeName, 
    required String routeTitle
  }) {
    pageTitle = routeTitle;
    currentPage = routeName;
    Future.delayed(const Duration(milliseconds: 100), () {
      notifyListeners();
    });
  }

  static Animation<double> movement = Tween<double>(begin: -660, end: 0)
      .animate(
          CurvedAnimation(parent: menuController, curve: Curves.easeInOut));

  static Animation<double> opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: menuController, curve: Curves.easeInOut));

  void openMenu() {
    sideOpen = true;
    menuController.forward();
  }

  void closeMenu() {
    sideOpen = false;
    menuController.reverse();
  }

  void toggleMenu() {
    (sideOpen) ? menuController.reverse() : menuController.forward();

    sideOpen = !sideOpen;
  }
}
