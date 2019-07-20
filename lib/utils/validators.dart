class Validators {
  static String get emailErrorMessage => "Sorry this Field is inValid";
  static String get phoneErrorMessage => "Sorry this Field is inValid";
  static String get nameErrorMessage => "Sorry this Field is inValid";
  static String get locationErrorMessage => "Sorry this Field is inValid";

  static String emailValidator(String email) {
    if ((email?.length ?? 0) < 1)
      return emailErrorMessage;
    else {
      if (email.contains(
          RegExp(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)"))) {
        return null;
      } else {
        return emailErrorMessage;
      }
    }
  }

  static String phoneValidator(String phone) {
    if ((phone?.length ?? 0) < 1)
      return phoneErrorMessage;
    else if (phone.length == 11 &&
        (phone.substring(0, 3) == '010' ||
            phone.substring(0, 3) == '011' ||
            phone.substring(0, 3) == '012' ||
            phone.substring(0, 3) == '015') &&
        !phone.contains(RegExp('[a-z]')) &&
        !phone.contains(RegExp('[A-Z]')))
      return null;
    else
      return phoneErrorMessage;
  }

  static String nameValidator(String name) {
    if ((name?.length ?? 0) < 3)
      return nameErrorMessage;
    else
      return null;
  }

  static String locationValidator(String location) {
    if ((location?.length ?? 0) < 1)
      return locationErrorMessage;
    else {
      if ((location?.length ?? 0) > 7 &&
          location.contains('http') &&
          location.contains('/') &&
          location.contains('.')) {
        return null;
      } else {
        return locationErrorMessage;
      }
    }
  }
}
