import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_media_app/screens/auth/sign_up.dart';

import 'Constants.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    Key? key,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController passwordController;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isObscure = true;
  OutlineInputBorder border = const OutlineInputBorder(borderSide: BorderSide(color: Constants.kBorderColor, width: 3.0));

  @override
  Widget build(BuildContext context) => TextFormField(
        key: const Key('password'),
        controller: widget.passwordController,
        obscureText: _isObscure,
        decoration: InputDecoration(
          filled: true,
          fillColor: Constants.kPrimaryColor,
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          helperText: '''Password should be at least 8 characters with at least one letter and number''',
          suffixIcon: IconButton(
            icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
            onPressed: () => mounted ? setState(() => _isObscure = !_isObscure) : '',
          ),
          helperMaxLines: 2,
          labelText: 'Password',
          prefixIcon: const Padding(
            padding: EdgeInsets.only(top: 12, left: 16),
            child: FaIcon(
              FontAwesomeIcons.lock,
              color: Colors.black,
            ),
          ),
          border: border,
          errorMaxLines: 2,
        ),
      );
}

class EmailField extends StatelessWidget {
  const EmailField({
    Key? key,
    required this.emailController,
  }) : super(key: key);

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) => TextFormField(
      key: const Key('email'),
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Constants.kPrimaryColor,
        prefixIcon: const Padding(
            padding: EdgeInsets.only(top: 12, left: 16),
            child: FaIcon(
              FontAwesomeIcons.user,
              color: Colors.black,
            )),
        labelText: 'Email Address',
        hintText: 'Email',
        prefixIconColor: Colors.black,
        contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        border: border,
      ));
}

class CustomField extends StatelessWidget {
  CustomField({
    Key? key,
    required this.controller,
    required this.labelText,
  }) : super(key: key);

  final TextEditingController controller;
  String labelText;

  @override
  Widget build(BuildContext context) => TextFormField(
      key: const Key('email'),
      keyboardType: TextInputType.emailAddress,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Constants.kPrimaryColor,
        prefixIcon: const Padding(
            padding: EdgeInsets.only(top: 12, left: 16),
            child: FaIcon(
              FontAwesomeIcons.user,
              color: Colors.black,
            )),
        hintText: labelText,
        prefixIconColor: Colors.black,
        contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        border: border,
      ));
}
