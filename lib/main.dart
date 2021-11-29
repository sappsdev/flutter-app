import 'package:app/auth/auth_provider.dart';
import 'package:app/config/cafe_api.dart';
import 'package:app/config/local_storage.dart';
import 'package:app/config/navigation_service.dart';
import 'package:app/config/notifications_service.dart';
import 'package:app/constants.dart';
import 'package:app/layouts/guest_layout.dart';
import 'package:app/layouts/splash_layout.dart';
import 'package:app/layouts/user_layout.dart';
import 'package:app/router/router.dart';
import 'package:app/widgets/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:app/config/configure_nonweb.dart' 
if (dart.library.html) 'package:app/config/configure_web.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.configurePrefs();
  Flurorouter.configureRoutes();
  CafeApi.configureDio();
  configureApp();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false, 
          create: (_) => AuthProvider()
        ),
        ChangeNotifierProvider(
          lazy: false, 
          create: (_) => UserProvider()
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){ 
  return Portal(
    child: MaterialApp(
      theme: ThemeData(
        primaryColor: primaryColor,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: appName,
      initialRoute: '/',
      onGenerateRoute: Flurorouter.router.generator,      
      navigatorKey: NavigationService.navigatorKey,
      scaffoldMessengerKey: NotificationsService.messengerKey,
      builder: (_, child) {
        final authProvider = Provider.of<AuthProvider>(context);
        if (authProvider.authStatus == AuthStatus.checking) {
          return const SplashLayout();
        }
        if (authProvider.authStatus == AuthStatus.authenticated) {
          return UserLayout(child: child!);
        } else {
          return GuestLayout(child: child!);
        }
      }
    ),
  );
  }
}