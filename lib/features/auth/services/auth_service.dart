import 'dart:convert';

import 'package:complete_amazon_clone_flutter/constant/error_handlng.dart';
import 'package:complete_amazon_clone_flutter/constant/global_variables.dart';
import 'package:complete_amazon_clone_flutter/features/home/screens/home_screen.dart';
import 'package:complete_amazon_clone_flutter/models/user_model.dart';
import 'package:complete_amazon_clone_flutter/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/widgets/bottom_bar.dart';
import '../../../constant/utils.dart';

class AuthService {
  // sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserModel user = UserModel(
        id: '',
        name: name,
        password: password,
        email: email,
        address: '',
        type: '',
        token: '',
        cart:[],
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await sharedPreferences.setString(
              'x-auth-token', jsonDecode(res.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
              context, BottomBar.routeName, (route) => false);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void GetUserData({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString('x-auth-token');
      if (token == null) {
        sharedPreferences.setString('x-auth-token', '');
      }
      var tokenRes = await http
          .post(Uri.parse('$uri/tokenIsValid'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token':token!,
      });
var response = jsonDecode(tokenRes.body);
if(response == true){

 http.Response userResponse =  await http.get(Uri.parse('$uri/'), headers: <String, String>{
   'Content-Type': 'application/json; charset=UTF-8',
   'x-auth-token': token,
 });
 var userProvider = Provider.of<UserProvider>(context);
 userProvider.setUser(userResponse.body);
}

    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
