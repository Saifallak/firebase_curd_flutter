class UserModel {
  String userId;
  String name;
  String email;
  String phone;

  /// Default Constructor
  /// Use with caution as all it's variables equals to null
  UserModel();

  /// Firebase Database Constructor
  /// Commonly used when retrieving data from Firebase Database,
  /// or Any Provider that returns JSON/Map.
  UserModel.fromFDatabase(Map json) {
    assert(json != null); // Stop executing if returned data corrupted.

    // splitting our json into the corresponding variables.
    userId = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }
}
