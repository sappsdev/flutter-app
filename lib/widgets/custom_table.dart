import 'package:app/config/responsive.dart';
import 'package:app/constants.dart';
import 'package:app/widgets/custom_empty.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
class CustomTable extends StatelessWidget {
  final int count;
  final List<DataColumn> listColumns;
  final List<DataRow> listRows;
  const CustomTable({
     required this.count,
     required this.listColumns,
     required this.listRows,
    Key? key 
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal : isMobile ? tPaddingSmall : tPaddingLarge),
      child: Column(
        children: [
          DataTable2(
            headingTextStyle: const TextStyle(color: thTextColor),
            columnSpacing: 12,
            horizontalMargin: 12,
            minWidth: 650,
            headingRowHeight: 40,
            dataRowHeight: 60,
            headingRowColor: MaterialStateColor.resolveWith(
              (states) => thBgColor
            ),              
            columns:  listColumns,
            rows: listRows,
          ),
          if(count == 0)
            customEmpty(),
        ],
      ),
    );
  }
}