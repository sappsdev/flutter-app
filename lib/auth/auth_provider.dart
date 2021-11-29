import 'package:app/auth/auth_model.dart';
import 'package:app/config/cafe_api.dart';
import 'package:app/config/local_storage.dart';
import 'package:app/config/navigation_service.dart';
import 'package:app/config/notifications_service.dart';
import 'package:app/router/router.dart';
import 'package:flutter/material.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider extends ChangeNotifier {
  AuthStatus authStatus = AuthStatus.checking;
  String authEmail = "";
  String authRol = "";

  AuthProvider() {
    isAuthenticated();
  }

  login({
      required String email,
      required String password
  }) async {   
      authEmail = email;
      authRol = "User";
      authStatus = AuthStatus.authenticated;
      NavigationService.replaceTo(Flurorouter.dashboardRoute);
      notifyListeners();
  }

  loginApi(String email, String password) {
  final data = {'email': email, 'password': password};
    CafeApi.post('/login', data).then((json) {
      final authResponse = AuthResponse.fromMap(json);      
      authRol = authResponse.rol;
      authEmail = authResponse.email;      
      authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('token', authResponse.token);       
      NavigationService.replaceTo(Flurorouter.dashboardRoute);
      CafeApi.configureDio();
      notifyListeners();
    }).catchError((e) {
      NotificationsService.showSnackbarError('Email / Password wrong');
    });
  }

  logout() {
    LocalStorage.prefs.remove('token');
    authStatus = AuthStatus.notAuthenticated;
    NavigationService.replaceTo(Flurorouter.rootRoute);
    CafeApi.configureDio();
    notifyListeners();
  }

  Future<bool> isAuthenticated() async {
    final token = LocalStorage.prefs.getString('token');
    if (token == null) {
      Future.delayed(const Duration(seconds: 5), () {
        authStatus = AuthStatus.notAuthenticated;
        notifyListeners();
      });
      return false;
    }

    try {
      final resp = await CafeApi.httpGet('/auth');
      final authResponse = AuthResponse.fromMap(resp);
      authRol = authResponse.rol;
      authEmail = authResponse.email;
      authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('token', authResponse.token);
      notifyListeners();
      return true;
    } catch (e) {
      Future.delayed(const Duration(seconds: 5), () {
        LocalStorage.prefs.remove('token');
        authStatus = AuthStatus.notAuthenticated;
        notifyListeners();
      });
      return false;
    }
  }
}
