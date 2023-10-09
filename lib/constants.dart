import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {
  //colors
  static const kPrimaryColor = Color(0xFFFFFFFF);
  static const kGreyColor = Color(0xFFEEEEEE);
  static const kBlackColor = Color(0xFF000000);
  static const kDarkGreyColor = Color(0xFF9E9E9E);
  static const kDarkBlueColor = Color(0xFF6057FF);
  static const kBorderColor = Color(0xFFEFEFEF);
  static const kBackgroundGrey = Color.fromRGBO(228, 229, 234, 1);
  static const kButtons = Color.fromRGBO(255, 203, 119, 1);
  static const kCards = Color.fromRGBO(254, 109, 115, 1);
  static const kAppBar = Color.fromRGBO(245, 245, 245, 1);
  static const kHeadingColor = Color.fromRGBO(16, 0, 43, 1);
  static const kButtonBg = Color.fromRGBO(217, 217, 217, 1);
  static const kDivider = Color.fromRGBO(203, 215, 225, 1);
  static const kLightGrey = Color.fromRGBO(16, 0, 43, 0.5);

  //text

  static const appName = "Wooph ";
  static const textSignIn = "Sign In";
  static const textSignUpBtn = "Sign Up";
  static const textStart = "Get Started";
  static const textSignInTitle = "Welcome back!";
  static const textSignInManager = "Sign In as Manager!";
  static const textRegister = "Register Below!";
  static const textAcc = "Don't have an account? ";
  static const textSignUp = "SIGN UP";
  static const textAlreadyUser = "Already a User? ";
  static const SignInHere = "Sign in Here";
  static const textHome = "Home";

  static const statusBarColor = SystemUiOverlayStyle(statusBarColor: Constants.kPrimaryColor, statusBarIconBrightness: Brightness.dark);

  static final kButtonStyle = ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(Constants.kBlackColor),
    backgroundColor: MaterialStateProperty.all<Color>(Constants.kHeadingColor),
    side: MaterialStateProperty.all<BorderSide>(BorderSide.none),
  );

  static final kLogoText = GoogleFonts.kronaOne(color: Constants.kHeadingColor, fontWeight: FontWeight.w400, fontSize: 34);

  static final kBodyText = GoogleFonts.kronaOne(color: Constants.kPrimaryColor, fontWeight: FontWeight.w400, fontSize: 16);

  static final kHeadingText = GoogleFonts.montserrat(fontWeight: FontWeight.w400);

  static final kSubHeading = GoogleFonts.montserrat(fontSize: 16, color: const Color.fromRGBO(16, 0, 43, 1), fontWeight: FontWeight.w700);

  static final tableHeading = GoogleFonts.montserrat(fontWeight: FontWeight.w700, fontSize: 12, color: Constants.kHeadingColor);

  static final kLargeText = GoogleFonts.montserrat(fontWeight: FontWeight.w700, fontSize: 36, color: const Color.fromRGBO(16, 0, 43, 0.5));

  OutlineInputBorder border = const OutlineInputBorder(borderSide: BorderSide(color: Constants.kBorderColor, width: 3.0));

//error messages
  static SnackBar error = const SnackBar(content: Text('User Does Not Exist'));
  static SnackBar verify = const SnackBar(content: Text('Please Verify your email'));

  static SnackBar userNotFound = const SnackBar(content: Text('User Does Not Exist'));

  static SnackBar incorrectPassword = const SnackBar(content: Text('Password is incorrect'));

  static SnackBar unknown = const SnackBar(content: Text('An Unknown Error Occured'));
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(this);
  }
}

extension PasswordValidator on String {
  bool isValidPassword() {
    return RegExp(r'^(?=.*?[A-Za-z])(?=.*?[0-9])([!@#\$&*~]?).{8,}$').hasMatch(this);
  }
}
