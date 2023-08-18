import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:womensaftey/utils/permission_set.dart';

Future<Position?> getCurrentLocation() async {
  try {
    isPermissionEnabeled();
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
      forceAndroidLocationManager: true,
    );
    print(position);
    return position;
  } catch (e) {
    return null;
    print("Error getting location: $e");
  }
}

Future<String?> getUrl() async {
  Position? position = await getCurrentLocation();
  print(position);
  if (position != null) {
    final mapUrl =
        await "https://www.google.com/maps?q=${position.latitude},${position.longitude}";
    return mapUrl;
  }
}

void shareLocation() async {
  Position? position = await getCurrentLocation();
  print(position);
  if (position != null) {
    final mapUrl =
        "https://www.google.com/maps?q=${position.latitude},${position.longitude}";
    Uri uri = Uri.parse(mapUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
      print("launch uri");
    } else {
      print("Could not launch $mapUrl");
    }
  }
}
