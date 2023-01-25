import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_street_view/flutter_google_street_view.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as GMap;

class StreetViewPanoramaInitDemo extends StatefulWidget {
  const StreetViewPanoramaInitDemo({super.key});

  @override
  State<StreetViewPanoramaInitDemo> createState() =>
      _StreetViewPanoramaInitDemoState();
}

class _StreetViewPanoramaInitDemoState
    extends State<StreetViewPanoramaInitDemo> {
  final initPos = const LatLng(37.769263, -122.450727);
  final finalPos = const LatLng(37.769534307233826, -122.45072957128286);

  final gmapInitPos = const GMap.LatLng(37.769263, -122.450727);
  final gmapFinalPos =
      const GMap.LatLng(37.769534307233826, -122.45072957128286);

  final initBearing = 352.54852294921875;

  final initTilt = -8.747010231018066;

  final initZoom = 0.01421491801738739;

  bool streatView = true;

  void togleViewMode() {
    setState(() {
      streatView = !streatView;
    });
  }

  final Completer<GMap.GoogleMapController> _controller =
      Completer<GMap.GoogleMapController>();

  final GMap.CameraPosition _kGooglePlex = const GMap.CameraPosition(
    target: GMap.LatLng(37.769263, -122.450727),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              streatView
                  ? FlutterGoogleStreetView(
                      markers: {
                        Marker(
                          markerId: const MarkerId("sadsdaa"),
                          position: initPos,
                        ),
                        Marker(
                          markerId: const MarkerId("dde"),
                          position: finalPos,
                        ),
                      },
                      onCameraChangeListener: (camera) {
                        print(camera.toMap());
                      },
                      /**
                 * It not necessary but you can set init position
                 * choice one of initPos or initPanoId
                 * do not feed param to both of them, or you should get assert error
                 */
                      initPos: initPos,
                      //initPanoId: "WddsUw1geEoAAAQIt9RnsQ",

                      /**
                 *  It is worked while you set initPos or initPanoId.
                 *  initSource is a filter setting to filter panorama
                 */
                      initSource: StreetViewSource.outdoor,

                      /**
                 *  It is worked while you set initPos or initPanoId.
                 *  initBearing can set default bearing of camera.
                 */
                      initBearing: initBearing,

                      /**
                 *  It is worked while you set initPos or initPanoId.
                 *  initTilt can set default tilt of camera.
                 */
                      initTilt: initTilt,

                      /**
                 *  It is worked while you set initPos or initPanoId.
                 *  initZoom can set default zoom of camera.
                 */
                      initZoom: initZoom,

                      /**
                 *  iOS Only
                 *  It is worked while you set initPos or initPanoId.
                 *  initFov can set default fov of camera.
                 */
                      //initFov: 120,

                      /**
                 *  Set street view can panning gestures or not.
                 *  default setting is true
                 */
                      //panningGesturesEnabled: false,

                      /**
                 *  Set street view shows street name or not.
                 *  default setting is true
                 */
                      //streetNamesEnabled: false,

                      /**
                 *  Set street view can allow user move to other panorama or not.
                 *  default setting is true
                 */
                      //userNavigationEnabled: false,

                      /**
                 *  Set street view can zoom gestures or not.
                 *  default setting is true
                 */
                      //zoomGesturesEnabled: false,

                      /**
                 *  To control street view after street view was initialized.
                 *  You should set [StreetViewCreatedCallback] to onStreetViewCreated.
                 *  And you can using [StreetViewController] object(controller) to control street view.
                 */
                      onStreetViewCreated: (controller) async {
                        controller.animateTo(
                          duration: 50,
                          camera: StreetViewPanoramaCamera(
                            bearing: initBearing,
                            tilt: initTilt,
                            zoom: initZoom,
                          ),
                        );
                      },
                    )
                  : SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: GMap.GoogleMap(
                        polylines: {
                          GMap.Polyline(
                              polylineId: const GMap.PolylineId("sdfffsdf"),
                              points: [gmapInitPos, gmapFinalPos])
                        },
                        onTap: ((argument) {
                          print(argument);
                        }),
                        markers: {
                          GMap.Marker(
                            markerId: const GMap.MarkerId("sadsaa"),
                            position: gmapInitPos,
                          ),
                          GMap.Marker(
                            markerId: const GMap.MarkerId("sdradsaa"),
                            position: gmapFinalPos,
                          ),
                        },
                        mapType: GMap.MapType.normal,
                        initialCameraPosition: _kGooglePlex,
                        onMapCreated: (GMap.GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      ),
                    ),
              Positioned(
                top: 0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Time Left",
                              style: TextStyle(
                                  color: streatView
                                      ? Colors.white70
                                      : Colors.black,
                                  fontWeight: FontWeight.w900),
                            ),
                            Text(
                              "00:05.26",
                              style: TextStyle(
                                  color: streatView
                                      ? Colors.white70
                                      : Colors.black,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: togleViewMode,
                          child: Container(
                            height: 150,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      streatView ? mapview : streateview),
                                  fit: BoxFit.cover),
                              border: Border.all(
                                width: 2,
                                color: call.withOpacity(0.5),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        gradient1,
                        gradient2,
                        gradient3,
                      ],
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    call.withOpacity(0.4),
                                    call.withOpacity(0.6),
                                    call.withOpacity(0.8),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: call.withOpacity(0.5),
                                    spreadRadius: 0.1,
                                    blurRadius: 5,
                                  )
                                ],
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                color: call,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  CupertinoIcons.phone,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(profile),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    message.withOpacity(0.4),
                                    message.withOpacity(0.6),
                                    message.withOpacity(0.8),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: message.withOpacity(0.5),
                                    spreadRadius: 0.1,
                                    blurRadius: 5,
                                  )
                                ],
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                color: message,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  CupertinoIcons.chat_bubble_2,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "James Willson",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                "DK2249",
                                style: TextStyle(color: Colors.white60),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(1.0),
                                  child: Icon(
                                    CupertinoIcons.star_fill,
                                    size: 15,
                                    color: Colors.amber,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(
                                    "4.9",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15, bottom: 8, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  "Delivery",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Container(
                                  height: 2,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                )
                              ],
                            ),
                            const Text(
                              "Order Info",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Text(
                              "Payment",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  boxShadow: [
                                    BoxShadow(
                                      color: call.withOpacity(0.5),
                                      blurRadius: 2,
                                      spreadRadius: 2,
                                    )
                                  ]),
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.restaurant_menu,
                                  color: Colors.white60,
                                ),
                              ),
                            ),
                            const Text(
                              "||||||||||||||||",
                              style: TextStyle(color: Colors.white24),
                            ),
                            const Icon(
                              Icons.delivery_dining_rounded,
                              color: Colors.amber,
                            ),
                            const Text(
                              "||||||||||||||||",
                              style: TextStyle(color: Colors.white24),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                        color: call.withOpacity(0.5),
                                        blurRadius: 2,
                                        spreadRadius: 2,
                                      )
                                    ]),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.location_pin,
                                    color: Colors.white60,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Crate Cafe",
                              style: TextStyle(color: Colors.white60),
                            ),
                            Text(
                              "46 Leister st.",
                              style: TextStyle(color: Colors.white60),
                            ),
                          ],
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

Color call = const Color(0XFF258CFB); // ->call
Color message = const Color(0XFF965EFF); //->message

Color gradient1 = const Color(0XFF20469B); // ->gradient
Color gradient2 = const Color(0XFF0F347C); // ->gradient
Color gradient3 = const Color(0XFF4441AC); // ->gradient

//022770 ->bottom container

String profile = "https://avatars.githubusercontent.com/u/37832937?v=4";
String mapview =
    "https://static.vecteezy.com/system/resources/previews/002/920/438/original/abstract-city-map-seamless-pattern-roads-navigation-gps-use-for-pattern-fills-surface-textures-web-page-background-wallpaper-illustration-free-vector.jpg";
String streateview =
    "https://static1.anpoimages.com/wordpress/wp-content/uploads/2017/11/nexus2cee_Google-Street-View-Generic-Hero.png";



// Please A Sub is enough for the channel