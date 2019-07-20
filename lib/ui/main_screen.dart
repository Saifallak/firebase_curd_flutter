import 'package:flutter/material.dart';
import 'package:saifoo_crud/ui/users/show_ava.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Choose CRUD Type"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            RaisedButton(
              padding: EdgeInsets.all(16.0),
              color: Colors.red,
              child: Text("CRUD FOR USER"),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ShowUsersAvailable(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
            ),
            RaisedButton(
              padding: EdgeInsets.all(16.0),
              color: Colors.blue,
              child: Text("CRUD FOR COMPANIES"),
              onPressed: () {},
//              onPressed: () => Navigator.of(context).push(
//                MaterialPageRoute(
//                  builder: (context) => ShowCompaniesAvailable(),
//                ),
//              ),
            ),
          ],
        ),
      ),
    );
  }
}
