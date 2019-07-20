import 'package:flutter/material.dart';
import 'package:saifoo_crud/models/user_model.dart';
import 'package:saifoo_crud/ui/common/loading_model.dart';
import 'package:saifoo_crud/utils/firebase_restful_api.dart';
import 'package:saifoo_crud/widgets/user_card.dart';

import 'add_new_user.dart';

class ShowUsersAvailable extends StatefulWidget {
  @override
  _ShowUsersAvailableState createState() => _ShowUsersAvailableState();
}

class _ShowUsersAvailableState extends State<ShowUsersAvailable> {
  bool _isLoading = true;
  String _error;
  List<UserModel> _users = List<UserModel>();

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    try {
      _users = await FirebaseRestfulApi().getAllUsers();
    } catch (e) {
      _error = e.toString();
    } finally {
      // make sure screen is still Alive.
      _isLoading = false;
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text("Available Users"),
      ),
      body: _isLoading
          ? LoadingModel(Colors.red)
          : RefreshIndicator(
              child: ListView.builder(
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  return UserCard(
                    userModel: _users[index],
                  );
                },
              ),
              onRefresh: () => _initData(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddNewUser(),
          ),
        ),
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
    );
  }
}
