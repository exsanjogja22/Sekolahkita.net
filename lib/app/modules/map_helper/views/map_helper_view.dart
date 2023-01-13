import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../config/app_colors.dart';
import '../controllers/map_helper_controller.dart';

class MapHelperView extends GetView<MapHelperController> {
  const MapHelperView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final t = Get.arguments[0];
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: AppColors.appGreenlight,
        centerTitle: true,
        title: Text(
          'Lokasi Kamu',
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18.sp,
          ),
        ),
      ),
      body: GetBuilder<MapHelperController>(
        builder: (_) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 144.h,
                  child: GoogleMap(
                    markers: {
                      Marker(
                          markerId: const MarkerId("School"),
                          position: LatLng(controller.systemLatitude.value,
                              controller.systemLongitude.value),
                          infoWindow: const InfoWindow(
                            title: 'Titik Presensi',
                            snippet: 'Lokasi Sekolah',
                          ),
                          icon: BitmapDescriptor.defaultMarker)
                    },
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    circles: {
                      Circle(
                        strokeWidth: 3,
                        strokeColor: Colors.green.withOpacity(0.5),
                        fillColor: Colors.green.withOpacity(0.2),
                        circleId: const CircleId("1"),
                        center: LatLng(controller.systemLatitude.value,
                            controller.systemLongitude.value),
                        radius: controller.systemRadius.value.toDouble(),
                      )
                    },
                    initialCameraPosition: CameraPosition(
                      target: LatLng(controller.systemLatitude.value,
                          controller.systemLongitude.value),
                      zoom: 3,
                    ),
                    onMapCreated: (GoogleMapController controllerGoogleMap) {
                      controller.controllerMap.complete(controllerGoogleMap);
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width - 20.w,
        height: 40.h,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(AppColors.appGreenlight),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            )),
          ),
          onPressed: () {
            controller.postDataPresensi(context, t);
          },
          child: Obx(
            () => controller.isLoading.isFalse
                ? Text(
                    "Presensi",
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16.sp,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Loading.... ",
                        style: GoogleFonts.quicksand(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.appColorWhite,
                        ),
                      ),
                      SizedBox(
                        width: 5.h,
                      ),
                      SizedBox(
                        height: 8.h,
                        width: 8.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2.0,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
