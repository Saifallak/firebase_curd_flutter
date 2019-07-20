import 'package:flutter/material.dart';

class LoadingModel extends StatelessWidget {
  final Color color;
  LoadingModel(this.color);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFFEEDB)),
        backgroundColor: color,
      ),
    );
  }
}

class Loading {
  loading(BuildContext context, Color color) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                LoadingModel(color),
              ],
            ),
          ),
        );
      },
    );
  }
}
