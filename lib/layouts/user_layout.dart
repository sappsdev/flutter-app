import 'package:app/auth/auth_provider.dart';
import 'package:app/config/navigation_service.dart';
import 'package:app/config/responsive.dart';
import 'package:app/constants.dart';
import 'package:app/router/router.dart';
import 'package:app/widgets/custom_menu_item.dart';
import 'package:app/widgets/shape_card.dart';
import 'package:app/widgets/sidebar.dart';
import 'package:app/widgets/text_variants.dart';
import 'package:app/widgets/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class UserLayout extends StatefulWidget {
  final Widget child;
  const UserLayout({
    Key? key, 
    required this.child
  }) : super(key: key);

  @override
  State<UserLayout> createState() => _UserLayoutState();
}

class _UserLayoutState extends State<UserLayout> 
  with SingleTickerProviderStateMixin {

  
  @override
  void initState() { 
    super.initState();
    UserProvider.menuController = AnimationController(
      vsync: this, 
      duration: const Duration(milliseconds: 300) 
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);
    final userProvider = Provider.of<UserProvider>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            constraints: const BoxConstraints.expand(),
            child: Column(
              children: [
                Container(
                  color: Colors.black,
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      if (isMobile) ...[
                        IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: (){
                            userProvider.openMenu();
                          }, 
                          icon: const Icon(
                            Icons.menu_outlined,
                            size: 45, 
                            color: Colors.white
                          ),
                        ),
                        const SizedBox(width: defaultSized),
                      ],
                      SvgPicture.asset('assets/images/logo.svg',
                        color: Colors.white,
                        width: 50,
                        semanticsLabel: 'logo'
                      ),
                      const SizedBox(width: defaultSized),
                      TextVariant.h3(
                        text: userProvider.pageTitle,
                        context: context, 
                        color: Colors.white
                      ),
                      Expanded(child: Container()),
                      const AnimateMenuList(),
                      const SizedBox(width: defaultSized),
                    ],
                  ),
                ),
                Expanded(child: Row(
                  children: [
                    if(isDesktop || isTablet)
                      const Sidebar(),
                    Expanded(child: Container(child: widget.child)),
                  ],
                )),
              ],
            )
          ),
          if (isMobile)
            AnimatedBuilder(
              animation: UserProvider.menuController, 
              builder: ( context, _ ) => Stack(
                children: [
                  if( userProvider.sideOpen )
                    Opacity(
                      opacity: UserProvider.opacity.value,
                      child: GestureDetector(
                        onTap: () => userProvider.closeMenu(),
                        child: Container(
                          width: size.width,
                          height: size.height,
                          color: Colors.black26,
                        ),
                      ),
                    ),
                  Transform.translate(
                    offset: Offset( UserProvider.movement.value, 0 ),
                    child: const Sidebar(),
                  ),
                ],
              )
            )            
        ],
      )
    );
  }
}

class AnimateMenuList extends StatefulWidget {
  const AnimateMenuList({
    Key? key 
  }) : super(key: key);

  @override
  _AnimateMenuListState createState() => _AnimateMenuListState();
}

class _AnimateMenuListState extends State<AnimateMenuList> 
  with SingleTickerProviderStateMixin {

  late AnimationController _controllerIcon;

  bool isMenuOpen = false;

  @override
  void initState() { 
    super.initState();
    _controllerIcon = AnimationController(
      vsync: this, 
      duration: const Duration(milliseconds: 100)
    );
  }

  @override
  Widget build(BuildContext context) {
    void openMenu(){
      setState(() {
        isMenuOpen = true;
      });
    }    

    return  PortalEntry(
      visible: isMenuOpen,
      portal: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            isMenuOpen = false;
          });
          _controllerIcon.reverse();
        },
      ),
      child: PortalEntry(
        visible: isMenuOpen,
        portalAnchor: Alignment.topRight,
        childAnchor: Alignment.bottomRight,
        portal: Material(
          shape: shapeButtom(),
          elevation: 8,
          child: listMenu(context),
        ),
        child: buttonMenu(openMenu),
      )
    );
  }

  Widget listMenu(context){
    final authProvider = Provider.of<AuthProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    return Container(
      constraints: const BoxConstraints(maxWidth: 280),
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomMenuitem(
            onPressed: (){
              setState(() {
                isMenuOpen = false;
              });
              _controllerIcon.reverse();
              NavigationService.replaceTo(
                Flurorouter.profileRoute
              );             
            },
            isActive: userProvider.currentPage == Flurorouter.profileRoute,
            text: "Profile"
          ),
          CustomMenuitem(
            onPressed: (){
              setState(() {
                isMenuOpen = false;
              });
              _controllerIcon.reverse();
              authProvider.logout();          
            }, 
            text: "Logout"
          ),
        ],
      ),    
    );
  }

  Widget buttonMenu(Function openMenu){
    return  InkWell(
      onTap: (){
        openMenu();
        _controllerIcon.forward();
      },
      child: AnimatedIcon(
        color: Colors.white,
        size: 30,
        icon: AnimatedIcons.menu_close,
        progress: _controllerIcon,
        semanticLabel: 'Show menu',
      ),
    ); 
  }


}
