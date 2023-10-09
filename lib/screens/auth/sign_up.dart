import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:social_media_app/data/repository/auth_repo.dart';
import 'package:social_media_app/data/repository/auth_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../Constants.dart';
import '../../data/repository/auth_repo.dart';
import '../../shared_widgets.dart';

OutlineInputBorder border = const OutlineInputBorder(borderSide: BorderSide(color: Constants.kBorderColor, width: 3.0));

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
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
            Center(
              child: Text('Sign Up Here', style: Constants.kLogoText),
            ),
            Padding(padding: EdgeInsets.only(bottom: size.height * 0.02)),
            SizedBox(
                width: size.width * 0.8,
                child: CustomField(
                  controller: nameController,
                  labelText: 'Name',
                )),
            SizedBox(height: size.height * 0.02),
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
            SizedBox(height: size.height * 0.02),
            SizedBox(
              width: size.width * 0.4,
              height: size.height * 0.07,
              child: ElevatedButton.icon(
                onPressed: () async {
                  if (await auth.signUp(emailController.text, passwordController.text, nameController.text, context)) {
                    Navigator.pushReplacementNamed(context, '/toMyFeed');
                  }
                },
                icon: isLoading ? const CircularProgressIndicator() : const Icon(Icons.login),
                label: Text('SIGN UP', style: Constants.kBodyText),
                style: Constants.kButtonStyle,
              ),
            ),
            const SizedBox(height: 60),
            RichText(
              text: TextSpan(
                text: 'Already a user? ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Sign in Here',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.popAndPushNamed(context, '/toSignInScreen');
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
