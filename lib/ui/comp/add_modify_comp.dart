import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saifoo_crud/models/comp_model.dart';
import 'package:saifoo_crud/ui/common/loading_model.dart';
import 'package:saifoo_crud/utils/firebase_restful_api.dart';
import 'package:saifoo_crud/utils/firebase_storage_client.dart';
import 'package:saifoo_crud/utils/validators.dart';
import 'package:uuid/uuid.dart';

class AddModifyComp extends StatefulWidget {
  final CompModel compModel;

  const AddModifyComp({Key key, this.compModel}) : super(key: key);
  @override
  _AddModifyCompState createState() => _AddModifyCompState();
}

class _AddModifyCompState extends State<AddModifyComp> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _storageClient = StorageClient.internal();
  File _galleryFile;
  String _error;
  CompModel _compModel = CompModel();
  bool _isModifying = false;

  @override
  void initState() {
    super.initState();
    if (widget.compModel != null) {
      _isModifying = true;
      _compModel = widget.compModel;
    }
  }

  _submitData(BuildContext context) async {
    try {
      if (_formKey.currentState.validate() &&
          (_galleryFile != null || widget.compModel?.logo != null)) {
        _formKey.currentState.save();

        // reset error
        _error = null;
        // Loading Screen
        Loading().loading(context, Colors.blue);
        // upload logo
        if (_galleryFile != null) {
          await _uploadIMG();
        }
        // Send Request
        _isModifying
            ? await FirebaseRestfulApi().updateComp(_compModel)
            : await FirebaseRestfulApi().newComp(_compModel);
        // Back Twice to all Comps.
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

  Future<void> _uploadIMG() async {
    if (_galleryFile != null) {
      int lastIndex = _galleryFile.path.lastIndexOf('.');
      var ext = _galleryFile.path.substring(lastIndex + 1);
      String url = await _storageClient.uploadFile(
          _galleryFile, "${"users/" + Uuid().v1()}", "$ext");
      _compModel.logo = url;
      print("in " + _compModel.logo);
    }
  }

  Future<void> _imageSelectorGallery() async {
    File galleryFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (mounted) setState(() => _galleryFile = galleryFile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("Add New Comp"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 12)),
                InkWell(
                  onTap: () => _imageSelectorGallery(),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.width * 0.2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: _galleryFile == null
                          ? DecorationImage(
                              image: widget.compModel?.logo != null
                                  ? NetworkImage(widget.compModel?.logo)
                                  : AssetImage("assets/images/logo.png"),
                              fit: BoxFit.contain,
                            )
                          : DecorationImage(
                              image: FileImage(_galleryFile),
                              fit: BoxFit.contain,
                            ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Divider(
                  color: Colors.grey,
                ),
                TextFormField(
                  initialValue: widget.compModel?.name ?? "",
                  onSaved: (val) => _compModel.name = val,
                  validator: Validators.nameValidator,
                  decoration: InputDecoration(
                    hintText: "Name",
                    labelText: "Name",
                  ),
                ),
                TextFormField(
                  initialValue: widget.compModel?.location ?? "",
                  onSaved: (val) => _compModel.location = val,
                  validator: Validators.locationValidator,
                  decoration: InputDecoration(
                    hintText: "Location",
                    labelText: "Location",
                  ),
                ),
                RaisedButton(
                  onPressed: () => _submitData(context),
                  child: Text("Submit Comp"),
                  color: Colors.blue,
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
