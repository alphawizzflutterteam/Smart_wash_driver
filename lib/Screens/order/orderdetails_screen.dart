import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Helper/app_colors.dart';
import '../../Helper/constant.dart';
import '../../Model/orderDetailsModel.dart';
import '../trackDriver.dart';

class OrderDetailsSreen extends StatefulWidget {
  final String OrderId;
  OrderDetailsSreen({Key? key, required this.OrderId}) : super(key: key);

  @override
  State<OrderDetailsSreen> createState() => _OrderDetailsSreenState();
}

class _OrderDetailsSreenState extends State<OrderDetailsSreen> {
  var items = [
    'pending',
    'order_confirmed',
    'picked_order',
    'processing',
    'cancelled',
    'delivered'
  ];
  String dropdownvalue = 'pending';
  String? dropdowndrivervalue;
  var totalAmountttt;
  var diliverTypee;
  bool activee = false;
  bool Isactivee = false;
  var Statusss;
  var selectDriverr = '';
  var driverId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrderDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.gold,
        centerTitle: true,
        title: Text('Order Details'),
      ),
      body: getOrderDetailModel?.data?.order == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'Customer Details',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'Name : ',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        '${getOrderDetailModel?.data?.order?.customer.user.name}',
                        style: TextStyle(fontSize: 12),
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
                        'Mobile Number : ',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        '${getOrderDetailModel?.data?.order?.customer.user.mobile}',
                        style: TextStyle(fontSize: 12),
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
                        'Email : ',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        '${getOrderDetailModel?.data?.order?.customer.user.email}',
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Divider(),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        'Order Id : ',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        '${getOrderDetailModel?.data?.order?.id}',
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Order Code : ',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        '${getOrderDetailModel?.data?.order?.orderCode}',
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Order At : ',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        '${getOrderDetailModel?.data?.order?.orderedAt}',
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Deliver Date : ',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        '${getOrderDetailModel?.data?.order?.deliveryDate}',
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Address : ',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        '${getOrderDetailModel?.data?.order?.address.addressName}',
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  getOrderDetailModel!.data!.order!.drivers.isNotEmpty &&
                          getOrderDetailModel!.data!.order!.orderStatus ==
                              "Picked your order"
                      ? InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserMapScreen(
                                    venorlat:
                                        getOrderDetailModel?.data?.order?.lat,
                                    venorlang:
                                        getOrderDetailModel?.data?.order?.lang,
                                    userlat: getOrderDetailModel
                                        ?.data?.order?.address.latitude,
                                    userlang: getOrderDetailModel
                                        ?.data?.order?.address.longitude,
                                    DriverId: getOrderDetailModel
                                        ?.data?.order?.drivers[0].userId,
                                  ),
                                ));
                          },
                          child: Card(
                            elevation: 3,
                            child: Container(
                              height: 40,
                              child: Center(
                                  child: Text(
                                'Track To Order',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      dounloadincoice();
                    },
                    child: Card(
                      elevation: 3,
                      child: Container(
                        height: 40,
                        child: Center(
                            child: Text(
                          'Download Invoice',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        'Update Order Status',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      // value: dropdownvalue,
                      hint: Row(
                        children: [
                          Expanded(
                              child: Statusss == '' || Statusss == null
                                  ? Text(
                                      'Select Status',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  : Text(
                                      '${Statusss}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    )),
                        ],
                      ),
                      // Array list of items

                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                          print(dropdownvalue);
                          Statusss = dropdownvalue;

                          print('==========${Statusss}===============');
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      if (Statusss == '' || Statusss == null) {
                        Fluttertoast.showToast(msg: 'Please Select Status');
                      } else {
                        setState(() {
                          activee = true;
                        });
                        UpdateOrder();
                      }
                      Future.delayed(
                        Duration(seconds: 5),
                        () {
                          setState(() {
                            activee = false;
                          });
                        },
                      );
                    },
                    child: Container(
                      height: 30,
                      width: 150,
                      decoration: BoxDecoration(
                          color: AppColors.gold,
                          borderRadius: BorderRadius.circular(75)),
                      child: Center(
                          child: activee == true
                              ? Text('Waiting...')
                              : Text('Update Status')),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Text(
                        'Product Details',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount:
                        getOrderDetailModel?.data?.order?.products.length,
                    itemBuilder: (context, index) {
                      var item =
                          getOrderDetailModel?.data?.order?.products[index];
                      int qty = quantity['${item?.id}'];
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            '${getOrderDetailModel?.data?.order?.products[index].imagePath}'),
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${getOrderDetailModel?.data?.order?.products[index].name}',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                        '${getOrderDetailModel?.data?.order?.products[index].slug}',
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10),
                                      )),
                                  Text(
                                    'Quantity : ${qty}',
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Text(
                        'Item',
                        style: TextStyle(fontSize: 12),
                      ),
                      Spacer(),
                      Text(
                        '${getOrderDetailModel?.data?.order?.item}',
                        style: TextStyle(fontSize: 12),
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
                        'Order Status',
                        style: TextStyle(fontSize: 12),
                      ),
                      Spacer(),
                      Text(
                        '${getOrderDetailModel?.data?.order?.orderStatus}',
                        style: TextStyle(fontSize: 12),
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
                        'Deliver Type',
                        style: TextStyle(fontSize: 12),
                      ),
                      Spacer(),
                      Text(
                        '${getOrderDetailModel?.data?.order?.deliverType}',
                        style: TextStyle(fontSize: 12),
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
                        'Payment Type',
                        style: TextStyle(fontSize: 12),
                      ),
                      Spacer(),
                      Text(
                        '${getOrderDetailModel?.data?.order?.paymentType}',
                        style: TextStyle(fontSize: 12),
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
                        'Sub Total Amount',
                        style: TextStyle(fontSize: 12),
                      ),
                      Spacer(),
                      Text(
                        '${getOrderDetailModel?.data?.order?.totalAmount}',
                        style: TextStyle(fontSize: 12),
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
                        'Delivery Charge',
                        style: TextStyle(fontSize: 12),
                      ),
                      Spacer(),
                      Text(
                        '${getOrderDetailModel?.data?.order?.deliveryCharge}',
                        style: TextStyle(fontSize: 12),
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
                        'Discount',
                        style: TextStyle(fontSize: 12),
                      ),
                      Spacer(),
                      Text(
                        '${getOrderDetailModel?.data?.order?.discount}',
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Divider(thickness: 3),
                  Row(
                    children: [
                      Text(
                        'Total Amount',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text(
                        '${totalAmountttt}',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ]),
              ),
            ),
    );
  }

  GetOrderDetailModel? getOrderDetailModel;
  var quantity;

  Future<void> getOrderDetails() async {
    var orderId = int.parse(widget.OrderId);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("===============${prefs.getString('authToken')}");

    setState(() {
      authToken = prefs.getString('authToken');
    });
    var headers = {
      'Authorization': 'Bearer ${authToken}',
    };
    var request =
        http.Request('GET', Uri.parse('${AppConfig.baseUrl1}orders/$orderId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print("order details  api=================${request.url}");

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();

      log('rsult=============${result}');

      var finalResult1 = jsonDecode(result);
      print(
          'Quantity===========================${finalResult1['data']['order']['quantity']}');
      if (finalResult1['data']['order']['quantity'] != null) {
        quantity = finalResult1['data']['order']['quantity'];
      }
      var finalResult = GetOrderDetailModel.fromJson(finalResult1);
      setState(() {
        getOrderDetailModel = finalResult;

        diliverTypee = getOrderDetailModel?.data?.order?.deliverType;
        print('DELIVERTTYPE=====================${diliverTypee}');

        if (getOrderDetailModel?.data?.order?.deliveryCharge == 0 &&
            getOrderDetailModel?.data?.order?.discount == 0) {
          setState(() {
            totalAmountttt = getOrderDetailModel?.data!.order!.totalAmount;
          });
        } else {
          setState(() {
            var totalamount =
                int.parse(getOrderDetailModel!.data!.order!.totalAmount);
            var deliverycharge =
                int.parse(getOrderDetailModel!.data!.order!.deliveryCharge);
            var discount =
                int.parse(getOrderDetailModel!.data!.order!.discount);
            totalAmountttt = totalamount + deliverycharge - discount;
          });
        }
        print("get order details success");
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> UpdateOrder() async {
    var orderId = int.parse(widget.OrderId);
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      authToken = prefs.getString('authToken');
    });
    var headers = {
      'Authorization': 'Bearer ${authToken}',
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${AppConfig.baseUrl1}orders/$orderId/update?status=${Statusss}'));
    print(request.url);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());

      Fluttertoast.showToast(msg: 'Status Successfully Update');
      getOrderDetails();
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> dounloadincoice() async {
    var orderId = int.parse(widget.OrderId);
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      authToken = prefs.getString('authToken');
    });
    var headers = {
      'Authorization': 'Bearer ${authToken}',
    };
    var request = http.Request(
        'POST', Uri.parse('${AppConfig.baseUrl2}/getinvoice/${orderId}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = jsonDecode(result);

      setState(() {
        urlpdg = finalresult['pdf_url'];
      });
      downloadPdf();
    } else {
      print(response.reasonPhrase);
    }
  }

  var urlpdg;
  Directory? dir;
  downloadPdf() async {
    Dio dio = Dio();
    try {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        String fileName = urlpdg.toString().split('/').last;
        print("FileName: $fileName");
        dir = Directory('/storage/emulated/0/Download/'); // for android
        if (!await dir!.exists()) dir = await getExternalStorageDirectory();
        String path = "${dir?.path}$fileName";
        await dio.download(
          urlpdg.toString(),
          path,
          onReceiveProgress: (recivedBytes, totalBytes) {
            print(recivedBytes);
          },
          deleteOnError: true,
        ).then((value) async {
          Fluttertoast.showToast(msg: 'Invoice Downloaded Successfully');
        });
      } else {
        launch(urlpdg.toString());
      }
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception(e);
    }
  }
}
