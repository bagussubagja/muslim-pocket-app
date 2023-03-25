// ignore_for_file: unused_local_variable

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationService {
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('location_permission_denied'.tr);
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('cant_proccess_user_request_location_forbidden'.tr);
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<String> getSubDistrictLocation(
      double latitude, double longitude) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(latitude, longitude);
    return placemark[0].locality!.split(" ")[1];
  }
}
