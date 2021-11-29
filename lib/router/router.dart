import 'package:app/router/router_handlers.dart';
import 'package:fluro/fluro.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static String rootRoute = '/';
  static String dashboardRoute = '/dashboard';
  static String profileRoute = '/profile';
  static String todoRoute = '/todos';

  static void configureRoutes() {

    router.define( 
      rootRoute, 
      handler: RouterHandlers.home, 
      transitionType: TransitionType.materialFullScreenDialog
    );

    router.define( 
      dashboardRoute, 
      handler: RouterHandlers.dashboard, 
      transitionType: TransitionType.materialFullScreenDialog 
    );

    router.define( 
      profileRoute, 
      handler: RouterHandlers.profile, 
      transitionType: TransitionType.materialFullScreenDialog 
    );

    router.define( 
      todoRoute, 
      handler: RouterHandlers.todos, 
      transitionType: TransitionType.materialFullScreenDialog 
    );

    router.notFoundHandler = RouterHandlers.noPageFound;
  }
}