import 'package:app/widgets/text_variants.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextVariant.h2(
        text: "Hello Dear,",
        context: context, 
      ),
    );
  }
}
