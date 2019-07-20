import 'dart:convert';

class CompModel {
  String compId;
  String name;
  String logo;
  String location;

  /// Default Constructor
  /// Use with caution as all it's variables equals to null
  CompModel();

  /// Firebase Database Constructor
  /// Commonly used when retrieving data from Firebase Database,
  /// or Any Provider that returns JSON/Map.
  CompModel.fromFDatabase(this.compId, Map json) {
    assert(json != null); // Stop executing if returned data corrupted.

    // splitting our json into the corresponding variables.
    name = json['name'];
    logo = json['logo'];
    location = json['location'];
  }

  toJson() {
    return json.encode({
      "name": name,
      "logo": logo,
      "location": location,
    });
  }
}
