import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

void isPermissionEnabeled() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
}

Future<bool> smsPermissionGranded() async {
  var status = await Permission.sms.status;
  if (status.isDenied) {
    // We didn't ask for permission yet or the permission has been denied before but not permanently.
    try {
      await Permission.sms.request();
      return true;
    } catch (e) {
      return false;
    }
  } else {
    return true;
  }
}
