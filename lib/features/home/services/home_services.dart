import 'dart:convert';

import 'package:complete_amazon_clone_flutter/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../constant/error_handlng.dart';
import '../../../constant/global_variables.dart';
import '../../../constant/utils.dart';

import 'package:http/http.dart' as http;

import '../../../providers/user_provider.dart';

class HomeServices {
  Future<List<ProductModel>> getCategoryProducts({
    required BuildContext context,
    required String category,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ProductModel> productList = [];
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/product?category=$category'),
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

  Future<ProductModel> fetchDealOfDay({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    ProductModel product = ProductModel(
        name: '',
        description: '',
        quantity: 0,
        images: [],
        category: '',
        price: 0);
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/deal-of-day'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.userModel.token,
        },
      );

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          product = ProductModel.fromJson(response.body);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return product;
  }
}
