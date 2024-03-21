import 'dart:convert';

import 'package:provider/provider.dart';

import '../../../constant/error_handlng.dart';
import '../../../constant/global_variables.dart';
import '../../../constant/utils.dart';
import '../../../models/product_model.dart';
import 'package:flutter/material.dart';

import '../../../providers/user_provider.dart';
import 'package:http/http.dart' as http;
class SearchServices{
  Future<List<ProductModel>> fetchSearchProducts({
    required BuildContext context,

    required String searchQuery,})async{
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ProductModel> productList = [];
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/product/search/$searchQuery'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.userModel.token,
        },
      );

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(response.body).length; i++) {
            productList.add(
              ProductModel.fromJson(
                jsonEncode(
                  jsonDecode(response.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }
}