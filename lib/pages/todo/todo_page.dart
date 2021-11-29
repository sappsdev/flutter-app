import 'package:app/config/responsive.dart';
import 'package:app/constants.dart';
import 'package:app/widgets/custom_elevated_button.dart';
import 'package:app/widgets/custom_table.dart';
import 'package:app/widgets/input_text.dart';
import 'package:flutter/material.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final _search = TextEditingController();
    return SingleChildScrollView(
      child: Card(
        margin: EdgeInsets.all(isMobile ? paddingSmall : paddingLarge),
        child: Column(
          children: [
            const SizedBox(height: defaultSized),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? paddingSmall : paddingLarge
              ),
              child: Row(
                children: [
                  inputSearch(_search),
                  const SizedBox(width: 10),
                  customElevatedButton(
                    width: 100,
                    text: "SEARCH",
                    onPressed: () async {
                    },                  
                  ),                  
                ],
              ),
            ), 
            const SizedBox(height: 20),           
            const CustomTable(
              count: 0,
              listColumns: [
                DataColumn(label: Text("ID")),
                DataColumn(label: Text("NAME")),
                DataColumn(label: Text("COLOR")),
                DataColumn(label: Text("COUNTRY")),
                DataColumn(label: Text("TYPE")),
                DataColumn(label: Text("ACTIVE")),           
                DataColumn(label: Text("MESSAGE")),         
              ],
              listRows: [],
            ),
          ],
        ),
      ),
    );
  }

  InputText inputSearch(TextEditingController _controller) {
    return InputText(
      prefix: Container(
        constraints: const BoxConstraints.tightForFinite(),
        child: const Icon(Icons.search_outlined)
      ),
      dark: false,
      width: 200,
      label: "Search",
      placeholder: "Some",
      controller: _controller,
      onValidate: (value) {
        if (value.length == 0) {
          return 'error';
        }
        return null;
      }
    );
  }
}
