// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:saifoo_crud/utils/validators.dart';

void main() {
  group("Email Validators Tests", () {
    test("Validator Email (right email)", () {
      var value = Validators.emailValidator("Saifallak@yahoo.com");
      expect(value, null);
    });
    test("Validator Email (wrong email)", () {
      var value = Validators.emailValidator("Saifallakyahoo.com");
      expect(value, Validators.emailErrorMessage);
    });
    test("Validator Email (null email)", () {
      var value = Validators.emailValidator(null);
      expect(value, Validators.emailErrorMessage);
    });
    test("Validator Email (empty email)", () {
      var value = Validators.emailValidator("");
      expect(value, Validators.emailErrorMessage);
    });
  });

  group("name Validators Tests", () {
    test("Validator name (right name)", () {
      var value = Validators.nameValidator("Saif Allah Khaled");
      expect(value, null);
    });
    test("Validator name (wrong name)", () {
      var value = Validators.nameValidator("sa");
      expect(value, Validators.nameErrorMessage);
    });
    test("Validator name (null name)", () {
      var value = Validators.nameValidator(null);
      expect(value, Validators.nameErrorMessage);
    });
    test("Validator name (empty name)", () {
      var value = Validators.nameValidator("");
      expect(value, Validators.nameErrorMessage);
    });
  });

  group("phone Validators Tests", () {
    test("Validator phone (right phone)", () {
      var value = Validators.phoneValidator("01129261195");
      expect(value, null);
    });
    test("Validator phone (wrong phone)", () {
      var value = Validators.phoneValidator("01829261195");
      expect(value, Validators.phoneErrorMessage);
    });
    test("Validator phone (null phone)", () {
      var value = Validators.phoneValidator(null);
      expect(value, Validators.phoneErrorMessage);
    });
    test("Validator phone (empty phone)", () {
      var value = Validators.phoneValidator("");
      expect(value, Validators.phoneErrorMessage);
    });
  });

  group("location Validators Tests", () {
    test("Validator location (right location)", () {
      var value = Validators.locationValidator(
          "https://www.google.com/maps/place/31°06'02.4\"N+29°45'13.1\"E/@31.1191842,29.7627045,12z/data=!4m14!1m7!3m6!1s0x14f59494c2ff244b:0xbf4264187399f398!2sAl+Agamy+Al+Bahri,+Qesm+Ad+Dekhilah,+Alexandria+Governorate,+Egypt!3b1!8m2!3d31.0960168!4d29.7599761!3m5!1s0x14f5948d7bb371fb:0x2bb19ab2aba7abc3!7e2!8m2!3d31.1006616!4d29.7536588");
      expect(value, null);
    });
    test("Validator location (wrong location)", () {
      var value = Validators.locationValidator(
          "le.com/maps/place/31°06'02.4\"N+29°45'13.1\"E/@31.1191842,29.76");
      expect(value, Validators.locationErrorMessage);
    });
    test("Validator location (null location)", () {
      var value = Validators.locationValidator(null);
      expect(value, Validators.locationErrorMessage);
    });
    test("Validator location (empty location)", () {
      var value = Validators.locationValidator("");
      expect(value, Validators.locationErrorMessage);
    });
  });
}
