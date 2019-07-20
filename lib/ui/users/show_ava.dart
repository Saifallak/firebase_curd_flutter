import 'package:flutter/material.dart';
import 'package:saifoo_crud/models/user_model.dart';
import 'package:saifoo_crud/ui/common/loading_model.dart';
import 'package:saifoo_crud/utils/firebase_restful_api.dart';
import 'package:saifoo_crud/widgets/user_card.dart';

import 'add_modify_user.dart';

class ShowUsersAvailable extends StatefulWidget {
  @override
  _ShowUsersAvailableState createState() => _ShowUsersAvailableState();
}

class _ShowUsersAvailableState extends State<ShowUsersAvailable> {
  /// List of All Available Users Models.
  List<UserModel> _users = List<UserModel>();

  /// indicator indicates weather the page is still loading or not
  /// or exactly the data retrieved or not.
  bool _isLoading = true;

  /// Error Message
  String _error;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  /// Initializes the required data:
  /// - resets error to null
  /// - calls the firebase database to get data.
  Future<void> _initData() async {
    try {
      _error = null;
      _users = await FirebaseRestfulApi().getAllUsers();
    } catch (e) {
      _error = "API ERROR ${e.toString()}";
    } finally {
      // make sure screen is still Alive.
      _isLoading = false;
      if (mounted) setState(() {});
    }
  }

  /// renders the right widget on the screen
  /// - in case of loading => LoadingModel
  /// - in case of error => error text
  /// - else => ListView
  Widget _buildScreenBody() {
    if (_isLoading) {
      // Screen Still loading..
      return LoadingModel(Colors.red);
    } else if (_error != null) {
      // There is an Error
      return Center(child: Text(_error));
    } else {
      // Everything is OK.
      return RefreshIndicator(
        onRefresh: () => _initData(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  return UserCard(
                    userModel: _users[index],
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
  }

  /// Shows the info Dialog.
  Future<AlertDialog> _showInfo() {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Info",
            style: TextStyle(
              fontSize: 14 / MediaQuery.of(context).textScaleFactor,
            ),
          ),
          content: Text(
            "1- HOLD on User to delete\n"
            "2- Press on '+' to add new User\n"
            "3- Pull screen to refersh\n"
            "4- Click on user to modify",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("okay"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text("Available Users"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () => _showInfo(),
          ),
        ],
      ),
      body: _buildScreenBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddModifyUser(),
          ),
        ),
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
    );
  }
}
