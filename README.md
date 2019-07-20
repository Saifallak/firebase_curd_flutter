# Firebase Restful Api Proof of Concept

## Getting Started

this is just a proof of concept that we can use [Firebase](http://firebase.google.com) as [RestfulApi](https://searchmicroservices.techtarget.com/definition/RESTful-API) in Flutter(https://flutter.dev).

### Packages/Plugins and why?

- [http](https://pub.dev/packages/http) for network requests (Get/Post/Patch...etc)
- [firebase_storage](https://pub.dev/packages/firebase_storage) for image uploading to firebase (no restful api for this op.)
- [image_picker](https://pub.dev/packages/image_picker) to select image from phone storage, used for comp. logos.
- [uuid](https://pub.dev/packages/uuid) to generate random IDs (specially v4 ones).

### what does this app do?
- it manages the [CRUD](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete) operations for two types of data:
- - users
- - companies

#### Users:
- Fields: Name, Email and Phone.

#### Companies:
- Fields: Name, Logo, Location on Map.

#### Operations for Users:
- User is so simple. using the Restful Api Code located In [ApiProvider](lib/utils/firebase_restful_api.dart).

#### Operations for Compaines:
- This is a little headache.
- - For Location Map & Name it's easy just a CRUD Operation like Users see :  [ApiProvider](lib/utils/firebase_restful_api.dart).
- - For Logo. after searching awhile in Firebase Docs, there is not Restful api for storage. so here we used [firebase_storage](https://pub.dev/packages/firebase_storage) for image uploading to firebase (no restful api for this op.)
- - TODO: (in Future) we could use [Google Maps](https://pub.dev/packages/google_maps_flutter) to select a location from the map instead of link.

### Screenshots
| Screenshot | Screenshot | Screenshot |
|:-:|:--:|:--:|
| <img src="https://github.com/Saifallak/firebase_curd_flutter/raw/master/screenshots/screenshot1.png" width="200"> | <img src="https://github.com/Saifallak/firebase_curd_flutter/raw/master/screenshots/screenshot2.png" width="200"> | <img src="https://github.com/Saifallak/firebase_curd_flutter/raw/master/screenshots/screenshot3.png" width="200"> |
<img src="https://github.com/Saifallak/firebase_curd_flutter/raw/master/screenshots/screenshot4.png" width="200"> |<img src="https://github.com/Saifallak/firebase_curd_flutter/raw/master/screenshots/screenshot5.png" width="200"> |<img src="https://github.com/Saifallak/firebase_curd_flutter/raw/master/screenshots/screenshot6.png" width="200"> |



### Want to try it ?
#### Just Testing the app ?
head to : [Output Folder](output).
Note: this only have APK, no IPA (might upload it in future).

#### Want to run and generate your own APK/IPA?
head to : [Flutter installing guide](https://flutter.dev/docs/get-started/install) and follow all steps
then 
```
flutter clean
flutter run
```

### Testing
```
flutter test --machine test\unit_test.dart
```

#### in testing we covered the following topics
- Email Validators Tests
- name Validators Tests
- phone Validators Tests
- location Validators Tests
