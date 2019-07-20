import 'package:flutter/material.dart';
import 'package:saifoo_crud/models/user_model.dart';
import 'package:saifoo_crud/ui/common/loading_model.dart';
import 'package:saifoo_crud/utils/firebase_restful_api.dart';
import 'package:saifoo_crud/utils/validators.dart';

class AddModifyUser extends StatefulWidget {
  final UserModel userModel;

  const AddModifyUser({Key key, this.userModel}) : super(key: key);
  @override
  _AddModifyUserState createState() => _AddModifyUserState();
}

class _AddModifyUserState extends State<AddModifyUser> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _error;
  UserModel _userModel = UserModel();
  bool _isModifying = false;

  @override
  void initState() {
    super.initState();
    if (widget.userModel != null) {
      _isModifying = true;
      _userModel = widget.userModel;
    }
  }

  _submitData(BuildContext context) async {
    try {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();

        // reset error
        _error = null;
        // Loading Screen
        Loading().loading(context, Colors.red);
        // Send Request
        _isModifying
            ? await FirebaseRestfulApi().updateUser(_userModel)
            : await FirebaseRestfulApi().newUser(_userModel);
        // Back Twice to all users
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      }
    } catch (e) {
      // dismiss Loading
      Navigator.of(context).pop();
      _error = "API ERROR ${e.toString()}";
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text("Add New User"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: widget.userModel?.name ?? "",
                  onSaved: (val) => _userModel.name = val,
                  validator: Validators.nameValidator,
                  decoration: InputDecoration(
                    hintText: "Name",
                    labelText: "Name",
                  ),
                ),
                TextFormField(
                  initialValue: widget.userModel?.email ?? "",
                  onSaved: (val) => _userModel.email = val,
                  validator: Validators.emailValidator,
                  decoration: InputDecoration(
                    hintText: "Email",
                    labelText: "Email",
                  ),
                ),
                TextFormField(
                  initialValue: widget.userModel?.phone ?? "",
                  onSaved: (val) => _userModel.phone = val,
                  validator: Validators.phoneValidator,
                  decoration: InputDecoration(
                    hintText: "Phone",
                    labelText: "Phone",
                  ),
                ),
                RaisedButton(
                  onPressed: () => _submitData(context),
                  child: Text("Submit User"),
                  color: Colors.red,
                ),
                if (_error != null) ...[
                  Text("$_error"),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
