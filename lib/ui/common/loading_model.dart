import 'package:flutter/material.dart';

class LoadingModel extends StatelessWidget {
  /// Color of Loading Bar.
  final Color color;

  /// Constructor
  const LoadingModel(this.color);

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
  /// Loading Overlay that prevents user from doing any op. until it's disposed.
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
