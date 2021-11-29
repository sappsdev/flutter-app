import 'package:app/auth/auth_provider.dart';
import 'package:app/pages/dashboard_page.dart';
import 'package:app/pages/error_page.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/pages/profile_page.dart';
import 'package:app/pages/todo/todo_page.dart';
import 'package:app/router/router.dart';
import 'package:app/widgets/user_provider.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RouterHandlers {
  static Handler home = Handler(
    handlerFunc: (context, params) {
      return const HomePage();
    }
  );
  static Handler dashboard = Handler(
    handlerFunc: (context, params) {
      return middleware(
        context: context, 
        routeName: Flurorouter.dashboardRoute, 
        routeTitle: "Dashboard",
        page: const DashboardPage(), 
        auth: "yes"
      );
    }
  );
  static Handler profile = Handler(
    handlerFunc: (context, params) {
      return middleware(
        context: context, 
        routeName: Flurorouter.profileRoute, 
        routeTitle: "Profile",
        page: const ProfilePage(), 
        auth: "yes"
      );
    }
  );
  static Handler todos = Handler(
    handlerFunc: (context, params) {
      return middleware(
        context: context, 
        routeName: Flurorouter.todoRoute, 
        routeTitle: "Todos",
        page: const TodoPage(), 
        auth: "yes"
      );
    }
  );
  static Handler noPageFound = Handler(
    handlerFunc: ( context, params ) {
      return const ErrorPage();
    }
  );  
}

Widget middleware({context, routeName, routeTitle, page, auth}){
  Provider.of<UserProvider>(context!, listen: false).setCurrentPageUrl(routeName: routeName, routeTitle: routeTitle);  
  final authProvider = Provider.of<AuthProvider>(context);
  if(auth != null && authProvider.authStatus != AuthStatus.authenticated) {
    return const HomePage();
  }
  return page;
}