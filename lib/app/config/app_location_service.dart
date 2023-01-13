import 'dart:async';
import 'package:location/location.dart';
import '../data/models/user_location_model.dart';

class LocationService {
  Location location = Location();
  StreamController<UserLocation> locationController =
      StreamController<UserLocation>();
  Stream<UserLocation> get locationStream => locationController.stream;

  LocationService() {
    location.requestPermission().then(
      (status) {
        if (status == PermissionStatus.granted) {
          location.onLocationChanged.listen(
            (locationData) {
              if (locationData.latitude != null &&
                  locationData.longitude != null) {
                locationController.add(UserLocation(
                    latitude: locationData.latitude,
                    longtitude: locationData.longitude));
              }
            },
          );
        }
      },
    );
  }

  void dispose() => locationController.close();
}
