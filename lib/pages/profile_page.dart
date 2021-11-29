import 'package:app/auth/auth_provider.dart';
import 'package:app/config/responsive.dart';
import 'package:app/constants.dart';
import 'package:app/widgets/shape_card.dart';
import 'package:app/widgets/text_variants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final authProvider = Provider.of<AuthProvider>(context);
    return Card(
      shape: shapeAll(),
      margin: EdgeInsets.all(isMobile ? 16.0 : 24.0),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            shape: shapeTop(),
            backgroundColor: primaryColor,
            title: TextVariant.h3(
              text: "User details",
              color: Colors.white,
              context: context, 
            ),
            bottom: const TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(icon: Icon(Icons.assignment_ind_outlined)),
                Tab(icon: Icon(Icons.password_outlined)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: TextVariant.h2(
                  text: authProvider.authRol+" "+authProvider.authEmail,
                  context: context, 
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: TextVariant.h2(
                  text: "Change Password",
                  context: context, 
                ),
              ),
            ],
          ),          
        )
      )
    );
  }
}