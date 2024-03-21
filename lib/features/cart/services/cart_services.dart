import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../constant/error_handlng.dart';
import '../../../constant/global_variables.dart';
import '../../../constant/utils.dart';
import '../../../models/product_model.dart';
import '../../../models/user_model.dart';
import '../../../providers/user_provider.dart';

class CartServices {
  void removeFromCart({
    required BuildContext context,
    required ProductModel product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/remove-from-cart/${product.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.userModel.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          UserModel user =
              userProvider.userModel.copyWith(cart: jsonDecode(res.body)['cart']);
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
