import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:saifoo_crud/models/user_model.dart';

class FirebaseRestfulApi {
  /// Firebase Project ID.
  static const String projectId = 'elrizk-crud';

  /// Users Node.
  static const String usersNode = 'users';

  /// the WebAPI key for the firebase project (Can be obtained from FB Settings).
  static const String _apiKey = 'AIzaSyB0qXZdg_OvPZj5F4-E0cG9EKBYtKhs0Eo';

  /// Function that connects to Firebase RealTime database and Returns all Users
  /// Node data as json.
  ///
  /// Parameters : None.
  /// Return: List of [UserModel].
  ///
  /// Throws ApiStatusCode in case of Failed connection.
  Future<List<UserModel>> getAllUsers() async {
    http.Response response =
        await http.get('https://$projectId.firebaseio.com/$usersNode.json');

    // On Successful Get.
    if (response.statusCode == 200) {
      // Decoded Json.
      Map<String, dynamic> decoded = json.decode(response.body);
      // Returned List of Users.
      List<UserModel> _users = List<UserModel>();

      decoded.forEach((key, value) {
        _users..add(UserModel.fromFDatabase(key, value));
      });

      return _users;
    } else {
      // Throw exception with statusCode number.
      throw response.statusCode;
    }
  }
}
