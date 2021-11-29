import 'package:app/auth/auth_provider.dart';
import 'package:app/constants.dart';
import 'package:app/widgets/custom_elevated_button.dart';
import 'package:app/widgets/input_text.dart';
import 'package:app/widgets/shape_card.dart';
import 'package:app/widgets/text_variants.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final _email = TextEditingController();
    final _password = TextEditingController();
    return Center(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Column(
              children: [
                TextVariant.h3(
                  text: "Log In",
                  context: context, 
                ),
                const SizedBox(height: defaultSized),
                inputEmail(_email),
                const SizedBox(height: defaultSized),
                inputPassword(_password),
                const SizedBox(height: defaultSized),
                customElevatedButton(
                  text: "LOG IN",
                  onPressed: () async {
                    if (_formKey.currentState?.validate() == true) {
                      authProvider.login(
                        email: _email.text, 
                        password: _password.text
                      );
                    }
                  },                  
                ),
                const SizedBox(height: defaultSized),
              ],
            ),
        ),
      ),
    );
  }

  InputText inputEmail(TextEditingController _controller) {
    return InputText(
      label: "email",
      placeholder: "Enter your email",
      controller: _controller,
      onValidate: (value) {
        if (!EmailValidator.validate(value ?? '')) {
          return 'Email wrong';
        }
        return null;
      }
    );
  }

  InputText inputPassword(TextEditingController _controller) {
    return InputText(
      label: "password",
      password: true,
      placeholder: "Enter your password",
      controller: _controller,
      onValidate: (value) {
        if (value.length == 0) {
          return 'Please enter password';
        }
        return null;
      }
    );
  }
}
