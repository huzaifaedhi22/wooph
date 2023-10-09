import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthService {
  Future<bool> signUp(String email, String password, String name, BuildContext context);
  Future<bool> signIn(String email, String password, BuildContext context);
}

class AuthServiceImpl extends AuthService {
  SupabaseClient client;

  AuthServiceImpl({required this.client});
  Future<bool> signUp(String email, String password, String name, BuildContext context) async {
    try {
      Map<String, dynamic> data = {"name": name};
      final AuthResponse res = await client.auth.signUp(
        email: email,
        password: password,
        data: data,
      );

      final Session? session = res.session;
      final User? user = res.user;
      if (session != null && user != null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registered Successfully')));
        return true;
      } else {
        return false;
      }
    } catch (e) {}
    return false;
  }

  Future<bool> signIn(String email, String password, BuildContext context) async {
    try {
      final AuthResponse res = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final Session? session = res.session;
      final User? user = res.user;
      if (session != null && user != null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sign in Successfull')));
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<String> getCurrentUser() async {
    return client.auth.currentUser!.id.toString();
  }
}
