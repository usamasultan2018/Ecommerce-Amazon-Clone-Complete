import 'package:complete_amazon_clone_flutter/models/user_model.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  UserModel _userModel = UserModel(
      id: '',
      name: '',
      email: '',
      password: '',
      address: '',
      type: '',
      cart: [],
      token: '');
  UserModel get userModel =>_userModel;
  void setUser(String userModel ){
    _userModel = UserModel.fromJson(userModel);
    notifyListeners();
  }
  void setUserFromModel(UserModel user) {
    _userModel = user;
    notifyListeners();
  }
}
