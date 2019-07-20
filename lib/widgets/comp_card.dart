import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saifoo_crud/models/comp_model.dart';
import 'package:saifoo_crud/ui/common/loading_model.dart';
import 'package:saifoo_crud/ui/comp/add_modify_comp.dart';
import 'package:saifoo_crud/utils/firebase_restful_api.dart';

class CompCard extends StatefulWidget {
  final CompModel compModel;
  const CompCard({Key key, @required this.compModel}) : super(key: key);

  @override
  _CompCardState createState() => _CompCardState();
}

class _CompCardState extends State<CompCard> {
  bool _isExist = true;

  _deleteUser(BuildContext context) async {
    try {
      Loading().loading(context, Colors.blue);
      await FirebaseRestfulApi().deleteComp(widget.compModel);
      _isExist = false;
      Navigator.of(context).pop();
    } catch (e) {
      // Nothing.
    } finally {
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _isExist,
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddModifyComp(compModel: widget.compModel),
          ),
        ),
        onLongPress: () => _deleteUser(context),
        child: Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                offset: Offset(2.0, 2.0),
                blurRadius: 5.0,
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(widget.compModel.logo ?? ""),
                backgroundColor: Colors.white70,
                radius: 50.0,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'name: ${widget.compModel.name}',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'location: ${widget.compModel.location}',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'logo: ${widget.compModel.logo}',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'id: ${widget.compModel.compId}',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
