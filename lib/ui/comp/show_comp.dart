import 'package:flutter/material.dart';
import 'package:saifoo_crud/models/comp_model.dart';
import 'package:saifoo_crud/ui/common/loading_model.dart';
import 'package:saifoo_crud/utils/firebase_restful_api.dart';
import 'package:saifoo_crud/widgets/comp_card.dart';

import 'add_modify_comp.dart';

class ShowCompaniesAvailable extends StatefulWidget {
  @override
  _ShowCompaniesAvailableState createState() => _ShowCompaniesAvailableState();
}

class _ShowCompaniesAvailableState extends State<ShowCompaniesAvailable> {
  List<CompModel> _comps = List<CompModel>();
  bool _isLoading = true;
  String _error;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    try {
      _error = null;
      _comps = await FirebaseRestfulApi().getAllComp();
    } catch (e) {
      _error = "API ERROR ${e.toString()}";
    } finally {
      // make sure screen is still Alive.
      _isLoading = false;
      if (mounted) setState(() {});
    }
  }

  Widget _buildScreenBody() {
    if (_isLoading) {
      // Screen Still loading..
      return LoadingModel(Colors.blue);
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
                itemCount: _comps.length,
                itemBuilder: (context, index) {
                  return CompCard(
                    compModel: _comps[index],
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
  }

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
            "1- HOLD on Comp to delete\n"
            "2- Press on '+' to add new Comp\n"
            "3- Pull screen to refersh\n"
            "4- Click on Comp to modify",
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
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("Available Comps"),
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
            builder: (context) => AddModifyComp(),
          ),
        ),
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
