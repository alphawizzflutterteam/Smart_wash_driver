import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Helper/app_colors.dart';
import '../../Helper/constant.dart';
import '../../Model/getNotificationModel.dart';
class getNotification extends StatefulWidget {
  const getNotification({Key? key}) : super(key: key);

  @override
  State<getNotification> createState() => _getNotificationState();
}

class _getNotificationState extends State<getNotification> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getNotification();
  }
  @override
  Widget build(BuildContext context) {
    return    Scaffold(

      appBar: AppBar(
        backgroundColor: AppColors.gold,
        centerTitle: true,
        title: Text('Notification'),

      ),

      body:

      Padding(
        padding: const EdgeInsets.all(15),
        child:   RefreshIndicator(
          onRefresh: ()
          async {

            return Future<void>.delayed(const Duration(seconds: 2),() {

              getNotification();

            },);
          },

          child:


          getNotificationModel?.data.notification==null?


              ListView.builder(
                itemCount: 1,
                itemBuilder:(context, index) {
                return
                  Container(
                      height: MediaQuery.of(context).size.height/2,
                      child: Center(child:

                      CircularProgressIndicator(),

                      ));
              }, )
        :

          getNotificationModel?.data.notification.length==0?


          Container(
            height: MediaQuery.of(context).size.height/2,
            child: Center(child:

            Text('No Notification Found',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: AppColors.black),)),


          ):


          ListView.builder(



            physics: AlwaysScrollableScrollPhysics(),



            shrinkWrap: true,



            itemCount: 50,



            itemBuilder: (context, index) {



              return



                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Card(

                    elevation: 5,



                    child: Container(





                      width: MediaQuery.of(context).size.width,

                      child: Padding(

                        padding:  EdgeInsets.all(10),

                        child: Column(



                          children: [

                            Row(
                              children: [
                                Text('Order Id : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                Text('KHK63863'),
                                SizedBox(width: 10,),

                              ],
                            ),

                            Divider(),

                            Row(
                              children: [
                                Text('Order Date : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),),
                                Text('28-08-2023',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),),
                                SizedBox(width: 10,),

                              ],
                            ),

                            Divider(),

                            Row(
                              children: [
                                Text('Deliver Date : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),),
                                Text('12-5-2024',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),),
                                SizedBox(width: 10,),

                              ],
                            ),

                            Divider(),




                          ],



                        ),

                      ),

                    ),

                  ),
                );









            },),


        ),
      )


    );

  }
  GetNotificationModel?getNotificationModel;
  Future<void> getNotification() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      authToken = prefs.getString('authToken');
    });
    var headers = {
      'Authorization':
      'Bearer ${authToken}', };
    var request = http.Request('GET', Uri.parse('${AppConfig.baseUrl1}notifications'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result=await response.stream.bytesToString();
      var finalResult=GetNotificationModel.fromJson(jsonDecode(result));
      setState(() {
        getNotificationModel=finalResult;
        print("get notification success");
      });
    }
    else {
    print(response.reasonPhrase);
    }


  }
}
