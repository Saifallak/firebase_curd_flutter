import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saifoo_crud/models/comp_model.dart';
import 'package:saifoo_crud/ui/common/loading_model.dart';
import 'package:tiny_widgets/tiny_widgets.dart';

class SelectPos extends StatefulWidget {
  final CompModel compModel;

  const SelectPos({Key key, @required this.compModel}) : super(key: key);
  @override
  _SelectPosState createState() => _SelectPosState();
}

class _SelectPosState extends State<SelectPos> {
  Completer<GoogleMapController> _controller = Completer();
  bool _isLocEnabled;
  LatLng _currentPos;
  LatLng _lastPos;
  Marker _marker;
  String _error = "Loading....";

  void onCameraMove(CameraPosition position) {
    _lastPos = position.target;
    _marker = _marker.copyWith(positionParam: _lastPos);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  _initData() async {
    // Getting permission
    await PermissionHandler().requestPermissions([PermissionGroup.location]);

    // Getting location
    await Geolocator()
        .checkGeolocationPermissionStatus()
        .then((GeolocationStatus val) async {
      if (val != GeolocationStatus.granted) {
        print("لا يمكننا تحديد موقعك بدقة");
        _error = null;
        _isLocEnabled = false;
        _currentPos = LatLng(30.0121517, 31.1952774);
      } else {
        _isLocEnabled = true;
        Position _pos = await Geolocator().getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
        );
        _currentPos = LatLng(_pos.latitude, _pos.longitude);
        print("${_currentPos.latitude} ${_currentPos.longitude}");
        _error = null;
      }
    });

    // Setting up center of screen marker
    _marker = Marker(
      markerId: MarkerId("markerCreatedByDev"),
      position: _currentPos,
    );

    // setting lastPosition to current Position
    _lastPos = _currentPos;

    if (mounted) setState(() {});
  }

  _nextStep(BuildContext context) async {
    try {
      Loading().loading(context);
      widget.compModel.latLng = _lastPos;
      await ApiProvider().sendOrder(widget.compModel);

      MiddleToast.show(
        context,
        "تم ارسال الطلب بنجاح",
      );

      // Delay moving to next step for X Seconds
      Timer(Duration(seconds: 2), () {
        Navigator.of(context).popUntil(ModalRoute.withName('/home_client'));
      });
    } on SocketException catch (_) {
      Navigator.of(context).pop(); // Dismiss Loading.
      MiddleToast.show(
        context,
        "عذرا .. برجاء التأكد من الانترنت و اعادة المحاولة",
        dismissible: true,
      );
    } catch (_) {
      Navigator.of(context).pop(); // Dismiss Loading.
      MiddleToast.show(
        context,
        "حدث خطأ ما .. برجاء اعادة المحاولة",
        dismissible: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "تحديد الموقع",
          textScaleFactor: 1.0,
          style: TextStyle(
            fontSize: 16,
            fontFamily: "Cairo",
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: _error != null
          ? LoadingModel()
          : Stack(
              children: <Widget>[
                GoogleMap(
                  mapType: MapType.normal,
                  myLocationEnabled: _isLocEnabled,
                  myLocationButtonEnabled: _isLocEnabled,
                  initialCameraPosition: CameraPosition(
                    bearing: 192.8334901395799,
                    target: _currentPos,
                    zoom: 19.151926040649414,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: {_marker},
                  onCameraMove: onCameraMove,
                ),
                Positioned(
                  bottom: 0,
                  right: MediaQuery.of(context).size.width * 0.1,
                  child: TinyContainer(
                    maxHeight: MediaQuery.of(context).size.height * 0.25,
                    maxWidth: MediaQuery.of(context).size.width * 0.8,
                    backgroundColor: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300],
                        blurRadius: 5,
                        spreadRadius: 2,
                      ),
                    ],
                    borderRadius: 10,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          if (widget.compModel.orderType !=
                              OrderType.generalOrder) ...[
                            Text(
                              "هل تريد اضافة شئ؟",
                              textAlign: TextAlign.center,
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Cairo",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  labelText: '',
                                  hintText: '',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  errorText: _error,
                                ),
                                onChanged: (val) =>
                                    widget.compModel.description = val,
                              ),
                            ),
                          ],
                          TinyContainer(
                            onTap: () => _nextStep(context),
//                            outerPadding: EdgeInsets.only(
//                              top: MediaQuery.of(context).padding.top,
//                            ),
                            text: "تأكيد الطلب",
                            borderRadius: 10,
                            backgroundColor: Color(0xFFF5730A),
                            textColor: Colors.white,
                            maxWidth: MediaQuery.of(context).size.width * 0.6,
                            fontFamily: "Cairo",
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[200],
                                blurRadius: 5,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
