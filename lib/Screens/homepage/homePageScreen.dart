import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Helper/app_colors.dart';
import '../../Helper/constant.dart';
import '../../Model/getOrderModel.dart';
import '../../Model/getPendingOrderModel.dart';
import '../../Model/getProfileModel.dart';
import '../../Model/getTotalOrderModel.dart';
import '../Auth/signin_screen.dart';
import '../notification/getNotification.dart';
import '../order/orderdetails_screen.dart';
import '../order/orderscreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var todayTotalOrder;
  var todayPendingOrder;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getdata();
  }

  void reloadApi() {
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.gold,
          centerTitle: true,
          title: const Text('DashBoard'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => getNotification(),
                      ));
                },
                icon: Icon(Icons.notifications))
          ],
        ),
        drawer: Drawer(
          child: ListView(children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.gold,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),

                      // imageFile==null?
                      // CircleAvatar(
                      //   backgroundColor: AppColors.gray,
                      //   radius: 45,
                      //
                      //
                      //   backgroundImage: AssetImage('assets/images/dpppp.jpg'),
                      // ):
                      // CircleAvatar(
                      //   backgroundColor: AppColors.gray,
                      // radius: 45,
                      //
                      //
                      //   backgroundImage:NetworkImage('${imageFile}'),
                      //   //child: Image.network('${imageFile}'),
                      //   ),

                      Text(
                        '${getProfileModel?.data?.user?.name}',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),

                      SizedBox(
                        width: 50,
                      ),
                      //
                      // IconButton(
                      //   icon: Icon(
                      //     Icons.edit,
                      //   ),
                      //   onPressed: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) => UpdateProfile(),
                      //         ));
                      //   },
                      // )
                      //
                      //
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${getProfileModel?.data?.user?.email}',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // ListTile(
            //   title: Row(
            //     children: [
            //       Icon(Icons.home_filled),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       const Text('Payment Settlement'),
            //     ],
            //   ),
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => PaymentRequst(),
            //         ));
            //   },
            // ),
            SizedBox(
              height: 5,
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.logout),
                  SizedBox(
                    width: 10,
                  ),
                  const Text('LogOut'),
                ],
              ),
              onTap: () {
                removeSession();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ));
              },
            ),
          ]),
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(Duration(seconds: 2), () {
              reloadApi();
            });
          },
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(children: [
                    SizedBox(
                      height: 20,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          elevation: 5,
                          child: Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width / 2.4,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                               const   Text(
                                    'Total Orders',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                           const       SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    '${gettotalOrderModel?.data.total ?? 0}',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 5,
                          child: Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width / 2.4,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Text(
                                    'Today Pending Order',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    '${getPendingOrderModel?.data?.total ?? 0}',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),

                        Text(
                          'Today Orders',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),

                        // getOrderModel?.data?.orders==null||getOrderModel?.data?.orders==''

                        // getOrderModel?.data?.orders?.length==0
                        //   ?SizedBox():
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Orderpage(),
                                  ));
                            },
                            child: Text(
                              'View All Order History',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.gold),
                            )),
                      ],
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    // getOrderModel?.data?.orders==null||getOrderModel?.data?.orders==''

                    getTodayOrderModel?.data?.orders == null
                        ? Container(
                            height: MediaQuery.of(context).size.height / 2,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ))
                        : getTodayOrderModel?.data?.orders?.length == 0
                            ? Container(
                                height: MediaQuery.of(context).size.height / 2,
                                child: Center(
                                    child: Text(
                                  'No Order Found Today',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black),
                                )),
                              )
                            : Container(
                                height:
                                    MediaQuery.of(context).size.height / 1.5,
                                child: ListView.builder(
                                  physics: AlwaysScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      getTodayOrderModel!.data!.orders!.length,
                                  itemBuilder: (context, index) {
                                    return ExpansionTile(
                                      title: Card(
                                        elevation: 5,
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Order Id : ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                    Text(
                                                        '${getTodayOrderModel?.data?.orders?[index].orderCode}'),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                  ],
                                                ),
                                                Divider(),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Order Date : ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10),
                                                    ),
                                                    Text(
                                                      '${getTodayOrderModel?.data?.orders?[index].orderedAt}',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                  ],
                                                ),
                                                Divider(),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Deliver Date : ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10),
                                                    ),
                                                    Text(
                                                      '${getTodayOrderModel?.data?.orders?[index].deliveryDate}',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                  ],
                                                ),
                                                Divider(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: getTodayOrderModel
                                                      ?.data
                                                      ?.orders?[index]
                                                      .acceptRejectDriver ==
                                                  '1'
                                              ? OutlinedButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              OrderDetailsSreen(
                                                                  OrderId: getTodayOrderModel
                                                                          ?.data
                                                                          ?.orders?[
                                                                              index]
                                                                          .id ??
                                                                      ''),
                                                        ));
                                                  },
                                                  child: Container(
                                                      height: 30,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: Center(
                                                        child: Text('Accepted'),
                                                      )),
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    OutlinedButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          statuss = '1';
                                                        });
                                                        acceptorderApi(
                                                            getTodayOrderModel
                                                                    ?.data
                                                                    ?.orders?[
                                                                        index]
                                                                    .id ??
                                                                '',
                                                            statuss);

                                                        reloadApi();
                                                        setState(() {});
                                                      },
                                                      child: Container(
                                                          height: 30,
                                                          child: Center(
                                                            child:
                                                                Text('Accept'),
                                                          )),
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    OutlinedButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            statuss = '0';
                                                          });
                                                          acceptorderApi(
                                                              getTodayOrderModel
                                                                      ?.data
                                                                      ?.orders?[
                                                                          index]
                                                                      .id ??
                                                                  '',
                                                              statuss);

                                                          reloadApi();
                                                          setState(() {});
                                                        },
                                                        child: Container(
                                                            height: 30,
                                                            child: Center(
                                                              child: Text(
                                                                  'Reject'),
                                                            ))),
                                                  ],
                                                ),
                                        )
                                      ],
                                    );
//
//                       InkWell(
//
//                         onTap: () {
//                           showAlertDialog(context);
//
//                         },
//
//
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 10,right: 10),
//                           child: Card(
//
//                             elevation: 5,
//
//
//
//                             child:
//
//                             Container(
//
//
//
//
//
//                               width: MediaQuery.of(context).size.width,
//
//                               child: Padding(
//
//                                 padding:  EdgeInsets.all(10),
//
//                                 child: Column(
//
//
//
//                                   children: [
//
//                                     Row(
//                                       children: [
//                                         Text('Order Id : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
//                                        Text('${getOrderModel?.data?.orders?[index].orderCode}'),
//                                         SizedBox(width: 10,),
//
//                                       ],
//                                     ),
//
// Divider(),
//
//                                     Row(
//                                       children: [
//                                         Text('Order Date : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),),
//                                         Text('${getOrderModel?.data?.orders?[index].orderedAt}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),),
//                                         SizedBox(width: 10,),
//
//                                       ],
//                                     ),
//
//                                     Divider(),
//
//                                     Row(
//                                       children: [
//                                         Text('Deliver Date : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),),
//                                         Text('${getOrderModel?.data?.orders?[index].deliveryDate}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),),
//                                         SizedBox(width: 10,),
//
//                                       ],
//                                     ),
//
//                                     Divider(),
//
//
//
//
//                                   ],
//
//
//
//                                 ),
//
//                               ),
//
//                             ),
//
//                           ),
//                         ),
//                       );
//
//
                                  },
                                ),
                              )
                  ]),
                ),
              );
            },
          ),
        ));
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      // title: Text("Order Status"),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              OutlinedButton(
                  onPressed: () {},
                  child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: Center(
                        child: Text('Accept'),
                      ))),
              SizedBox(
                height: 20,
              ),
              OutlinedButton(
                  onPressed: () {},
                  child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: Center(
                        child: Text('Reject'),
                      ))),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        )
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  var statuss;
  Future<void> getdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      venderId = prefs.getString('venderId');
      // firstname=prefs.getString('firstName');
      // lastName=prefs.getString('lastName');
      // name=prefs.getString('name');
      // email=prefs.getString('emait');
      // mobile=prefs.getString('mobileNumber');
      // gender=prefs.getString('gender');
      // address=prefs.getString('address');
      // imageFile=prefs.getString('imageFile');
      // dateofBirth=prefs.getString('dateOfBirth');
      authToken = prefs.getString('authToken');
      print(venderId);
      print(authToken);
      print('get user details api');

      getdriverDetails();

      getPendingOrder();
      gettoTotalOrder();
      getOrder();
      Future.delayed(Duration(seconds: 5), () async {
        // getUserCurrentLocation();

        _startTimer();
      });
    });
  }

  Future<void> removeSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('venderId');
    await prefs.remove('firstName');
    await prefs.remove('lastName');
    await prefs.remove('name');
    await prefs.remove('emait');
    await prefs.remove('mobileNumber');
    await prefs.remove('gender');
    await prefs.remove('address');
    await prefs.remove('imageFile');
    await prefs.remove('dateOfBirth');
    await prefs.remove('authToken');
  }

  GetProfileModel? getProfileModel;
  Future<void> getdriverDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      authToken = prefs.getString('authToken');
    });
    var headers = {
      'Authorization': 'Bearer ${authToken}',
    };
    var request = http.Request('GET', Uri.parse('${AppConfig.baseUrl1}user'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print("driver details api=================${request.url}");

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = GetProfileModel.fromJson(jsonDecode(result));
      setState(() {
        getProfileModel = finalresult;

        print('Get profiler Success');
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  GetPendingOrderModel? getPendingOrderModel;
  Future<void> getPendingOrder() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      authToken = prefs.getString('authToken');
    });
    var headers = {
      'Authorization': 'Bearer ${authToken}',
    };
    var request =
        http.Request('GET', Uri.parse('${AppConfig.baseUrl1}todays-pending'));
    print(request.url);
    request.headers.addAll(headers);
    log(request.headers.toString());
    http.StreamedResponse response = await request.send();
    print('pending api=====${request.url}');
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      log(result.toString());
      var finalResult = GetPendingOrderModel.fromJson(jsonDecode(result));
      setState(() {
        getPendingOrderModel = finalResult;
        print('get pending Order success');
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  GettotalOrderModel? gettotalOrderModel;
  Future<void> gettoTotalOrder() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      authToken = prefs.getString('authToken');
    });
    var headers = {
      'Authorization': 'Bearer ${authToken}',
    };
    var request = http.Request(
        'GET', Uri.parse('${AppConfig.baseUrl1}total-orders?isAccept=1'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print('pending api=====${request.url}');

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();

      var finalResult = GettotalOrderModel.fromJson(jsonDecode(result));
      setState(() {
        gettotalOrderModel = finalResult;
        print('get total order success');
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  GetTodayOrderModel? getTodayOrderModel;
  Future<void> getOrder() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      authToken = prefs.getString('authToken');
    });
    var headers = {
      'Authorization': 'Bearer ${authToken}',
    };
    var request =
        http.Request('GET', Uri.parse('${AppConfig.baseUrl1}todays/'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print('pending api=====${request.url}');

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = GetTodayOrderModel.fromJson(jsonDecode(result));
      setState(() {
        getTodayOrderModel = finalResult;

        print("get order success");
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> acceptorderApi(String orderId, String Statuss) async {
    var orderIddd = int.parse(orderId);
    var statuss = int.parse(Statuss);
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      authToken = prefs.getString('authToken');
    });
    var headers = {
      'Authorization': 'Bearer ${authToken}',
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6ImZDVm5qQXhoY2J2QjM1UFBOazJpbUE9PSIsInZhbHVlIjoiR3I5NlpraVZsK093bml6Uzg2Ylc2NXlnRUZYVjhsVzE1c3BZVHRIclFPdDIrVzM1dytYMEhWZ3I1OE9QMEJSWHRvc1QvM1UxWUJ6cjJJamFuYW9tOVVlV2dUaGNWUDFvdHRQNlJqaTdLWnRxRlFjUWwrV2E3bC9mRHZJdXZGY3oiLCJtYWMiOiIxYWI1MzlhOTdhNzFhNjYyNTM2YWE4NGNjYzNlZTNiZmVmMTFmYTE0NzE2Nzk2YjFmZjdlZjhjZTdiZWJhODM1IiwidGFnIjoiIn0%3D; laundry_session=eyJpdiI6IklHWkpjbk5jc01jRUVNVHV0QWFuV2c9PSIsInZhbHVlIjoiWTBWRERKMmwwUkpNSEg1bFFtNTgvaHBmK1FvbU5oRG16L1BuMXB1U3NWMjI2TENXSTdjSkhudTM3aGJLdXdTT1JKRGtORkl3Y0JTbTAxWkdMbzRETHE2Z0E0OEY4a1V4RXBueFFmOWUrSkxJbU82SllPSFRmdXo1MjR0Y3hYUTkiLCJtYWMiOiJjZTI4NGY3ODg0MjljYWY3OWU5YTA3YmZiNTVlNGI4MjYzODljMDZkNjc4ZmUxNWQ0MGQzOWM0MTUzZTNhZTc2IiwidGFnIjoiIn0%3D'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${AppConfig.baseUrl1}accept-order/$orderIddd/?isAccept=$statuss'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = jsonDecode(result);
      print('order accept success');
    } else {
      print(response.reasonPhrase);
    }
  }

  // CollectionReference humanCollection =
  //     FirebaseFirestore.instance.collection("driverlocation");

  // Future<void> updateDriverLocation() async {
  //   print("location store function Start===========");

  //   humanCollection.doc('$venderId').set({
  //     'lat': currentLocation?.latitude,
  //     'long': currentLocation?.longitude,
  //   }, SetOptions(merge: true));

  //   print("location store success===========");
  // }

  var lat;
  var long;

  Position? currentLocation;

  Future getUserCurrentLocation() async {
    var status = await Permission.location.request();
    if (status.isDenied) {
    } else if (status.isGranted) {
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((position) {
        if (mounted)
          setState(() {
            currentLocation = position;
            lat = currentLocation?.latitude;
            long = currentLocation?.longitude;
          });
      });
      // updateDriverLocation();
      // addData();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  late Timer _timer;

  void _startTimer() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    venderId = prefs.getString('venderId');
    _timer = Timer.periodic(Duration(seconds: 5), (timer) async {
      await getUserCurrentLocation();
    });
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  var vid;

  // CollectionReference collectionRef=FirebaseFirestore.instance.collection("$venderId");
  //  CollectionReference collectionRef=FirebaseFirestore.instance.collection("driverlocation");
  var docidd;

  Future<void> addData() async {
    print("=====ADDFIREBASE========${venderId}=============");

    try {
      await FirebaseFirestore.instance
          .collection("driverlocation")
          .doc(venderId)
          .set({'lat': lat, 'long': long, 'id': venderId});
      //to get doc id

      // collectionRef.get().then((QuerySnapshot querySnapshot) {
      //   querySnapshot.docs.forEach((doc) {
      //     // print("Document ID: ${doc.id}");
      //     setState(() {
      //       docidd=doc.id;
      //     });
      //     print("Document ID: ${docidd}");
      //
      //   });
      // }).catchError((error) {
      //
      //
      //   print("Error fetching documents: $error");
      // });
      //
      //
      //       collectionRef.where('id', isEqualTo: venderId).get().then((value) {
      //
      //         collectionRef.doc(venderId).update({
      //           'lat': latitude,
      //           'long': longitude,
      //           'id':venderId
      //         }).then((value) {
      //           print('Document updated successfully');
      //         }).catchError((error) {
      //           print('Error updating document: $error');
      //         });
      //
      //
      //      }) ;

      // DocumentSnapshot document = await collectionRef.doc('${docidd}').get();

      // if (document.exists) {

      // double lat1 = document.get('lat'); // Replace with your field name
      // double long1 = document.get('long'); // Replace with your field name
      // print('lat1===========: $lat1');
      // print('long1===========: $long1');

//to update data particuler docs

      // String documentID = '$venderId';

// if()
//           collectionRef.doc(documentID).update({
//             'lat': latitude,
//             'long': longitude,
//             'id':venderId
//           }).then((value) {
//             print('Document updated successfully');
//           }).catchError((error) {
//             print('Error updating document: $error');
//           });
//         // }
//         // else{
//
//           print('3==================$docidd');
//
//
//           print('data not prasent');

      // collectionRef.add({
      //   'lat': latitude,
      //   'long': longitude,
      //   // Add other fields as needed
      // });

      // }
    } catch (e) {
      print('Error adding data: $e');
    }
  }
}
