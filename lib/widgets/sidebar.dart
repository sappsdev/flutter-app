import 'package:app/config/navigation_service.dart';
import 'package:app/constants.dart';
import 'package:app/router/router.dart';
import 'package:app/widgets/custom_menu_item.dart';
import 'package:app/widgets/text_variants.dart';
import 'package:app/widgets/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    void navigateTo(String routeName) {
      userProvider.closeMenu();
      NavigationService.replaceTo(routeName);
    }      
    return Container(
      width: 320,
      decoration: buildBoxDecoration(),
      height: double.infinity,
      child: Column(
        children: [
          const SizedBox(height: 70),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomMenuitem(
                    text: 'Dashboard',
                    icon: Icons.grid_view_outlined,
                    onPressed: () {
                      navigateTo(Flurorouter.dashboardRoute);
                    },
                    isActive: userProvider.currentPage == Flurorouter.dashboardRoute
                  ),                             
                  CustomMenuitem(
                    text: 'Todos',
                    icon: Icons.summarize_outlined,
                    onPressed: () {
                      navigateTo(Flurorouter.todoRoute);
                    },
                    isActive: userProvider.currentPage == Flurorouter.todoRoute
                  ),               
                                  
                ],
              ),
            ),
          ),
          Padding(
            padding: 
              const EdgeInsets.only(left: 8, right: 8, top: 24, bottom: 24),
            child: Row(
              children: [
                  const SizedBox(width: 10),
                  TextVariant.h4(
                    text: "Help Center",
                    context: context,
                    color: secondaryColor
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      color: Colors.white,
      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 1)]
  );  
}