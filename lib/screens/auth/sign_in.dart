import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../Constants.dart';
import '../../data/repository/auth_repo.dart';

import '../../shared_widgets.dart';
import 'package:get_it/get_it.dart';

OutlineInputBorder border = const OutlineInputBorder(borderSide: BorderSide(color: Constants.kBorderColor, width: 3.0));

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthServiceImpl auth = GetIt.instance<AuthServiceImpl>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Constants.kBackgroundGrey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.06),
            Center(
              child: Text(Constants.appName, style: Constants.kLogoText),
            ),
            const SizedBox(height: 45),
            Padding(padding: EdgeInsets.only(bottom: size.height * 0.02)),
            SizedBox(
              width: size.width * 0.8,
              child: EmailField(emailController: emailController),
            ),
            SizedBox(height: size.height * 0.02),
            SizedBox(
              width: size.width * 0.8,
              child: PasswordField(passwordController: passwordController),
            ),
            SizedBox(height: size.height * 0.02),
            SizedBox(
              width: size.width * 0.4,
              height: size.height * 0.07,
              child: ElevatedButton.icon(
                onPressed: () async {
                  if (await auth.signIn(emailController.text, passwordController.text, context)) {
                    Navigator.pushReplacementNamed(context, '/toMyFeed');
                  }
                },
                icon: isLoading ? const CircularProgressIndicator() : const Icon(Icons.login),
                label: Text('Sign in', style: Constants.kBodyText),
                style: Constants.kButtonStyle,
              ),
            ),
            const SizedBox(height: 60),
            RichText(
              text: TextSpan(
                text: Constants.textAcc,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Sign up Here',
                      style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.popAndPushNamed(context, '/toSignUpScreen');
                        }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
