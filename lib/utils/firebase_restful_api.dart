import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:saifoo_crud/models/comp_model.dart';
import 'package:saifoo_crud/models/user_model.dart';

class FirebaseRestfulApi {
  /// Firebase Project ID.
  static const String projectId = 'elrizk-crud';

  /// Users Node.
  static const String usersNode = 'users';

  /// Comp Node.
  static const String compNode = 'comp';

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

      decoded?.forEach((key, value) {
        _users..add(UserModel.fromFDatabase(key, value));
      });

      return _users;
    } else {
      // Throw exception with statusCode number.
      throw response.statusCode;
    }
  }

  /// Function that connects to Firebase RealTime database and Submits new User
  /// entry from [UserModel].
  ///
  /// Parameters : [user].
  /// Return: none/void.
  ///
  /// Throws ApiStatusCode in case of Failed connection.
  Future<void> newUser(UserModel user) async {
    http.Response response = await http.post(
      'https://$projectId.firebaseio.com/$usersNode.json',
      body: user.toJson(),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
    } else {
      throw response.statusCode;
    }
  }

  /// Function that connects to Firebase RealTime database and updates User
  /// entry from [UserModel].
  ///
  /// Parameters : [user].
  /// Return: none/void.
  ///
  /// Throws ApiStatusCode in case of Failed connection.
  Future<void> updateUser(UserModel user) async {
    http.Response response = await http.patch(
      'https://$projectId.firebaseio.com/$usersNode/${user.userId}.json',
      body: user.toJson(),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
    } else {
      throw response.statusCode;
    }
  }

  /// Function that connects to Firebase RealTime database and deletes User
  /// entry from [UserModel].
  ///
  /// Parameters : [user].
  /// Return: none/void.
  ///
  /// Throws ApiStatusCode in case of Failed connection.
  Future<void> deleteUser(UserModel user) async {
    http.Response response = await http.delete(
      'https://$projectId.firebaseio.com/$usersNode/${user.userId}.json',
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
    } else {
      throw response.statusCode;
    }
  }

  /// Function that connects to Firebase RealTime database and Returns all Comps
  /// Node data as json.
  ///
  /// Parameters : None.
  /// Return: List of [CompModel].
  ///
  /// Throws ApiStatusCode in case of Failed connection.
  Future<List<CompModel>> getAllComp() async {
    http.Response response =
        await http.get('https://$projectId.firebaseio.com/$compNode.json');

    // On Successful Get.
    if (response.statusCode == 200) {
      // Decoded Json.
      Map<String, dynamic> decoded = json.decode(response.body);
      // Returned List of Users.
      List<CompModel> _comp = List<CompModel>();

      decoded?.forEach((key, value) {
        _comp..add(CompModel.fromFDatabase(key, value));
      });

      return _comp;
    } else {
      // Throw exception with statusCode number.
      throw response.statusCode;
    }
  }

  /// Function that connects to Firebase RealTime database and Submits new User
  /// entry from [CompModel].
  ///
  /// Parameters : [comp].
  /// Return: none/void.
  ///
  /// Throws ApiStatusCode in case of Failed connection.
  Future<void> newComp(CompModel comp) async {
    http.Response response = await http.post(
      'https://$projectId.firebaseio.com/$compNode.json',
      body: comp.toJson(),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
    } else {
      throw response.statusCode;
    }
  }

  /// Function that connects to Firebase RealTime database and updates User
  /// entry from [CompModel].
  ///
  /// Parameters : [comp].
  /// Return: none/void.
  ///
  /// Throws ApiStatusCode in case of Failed connection.
  Future<void> updateComp(CompModel comp) async {
    http.Response response = await http.patch(
      'https://$projectId.firebaseio.com/$compNode/${comp.compId}.json',
      body: comp.toJson(),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
    } else {
      throw response.statusCode;
    }
  }

  /// Function that connects to Firebase RealTime database and deletes User
  /// entry from [CompModel].
  ///
  /// Parameters : [comp].
  /// Return: none/void.
  ///
  /// Throws ApiStatusCode in case of Failed connection.
  Future<void> deleteComp(CompModel comp) async {
    http.Response response = await http.delete(
      'https://$projectId.firebaseio.com/$compNode/${comp.compId}.json',
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
    } else {
      throw response.statusCode;
    }
  }
}
