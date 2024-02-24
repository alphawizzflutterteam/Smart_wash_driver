import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Helper/app_colors.dart';
import '../../Helper/constant.dart';
import '../../Model/orderHistoryModel.dart';
import 'orderdetails_screen.dart';
class Orderpage extends StatefulWidget {
  const Orderpage({Key? key}) : super(key: key);

  @override
  State<Orderpage> createState() => _OrderpageState();
}

class _OrderpageState extends State<Orderpage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrder();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        centerTitle: true,
        title: Text('All Orders'),),
body:



getOrderHistryModel?.data?.orders==null||getOrderHistryModel?.data?.orders==''?


Container(
    height: MediaQuery.of(context).size.height,
    child: Center(child: CircularProgressIndicator())):

getOrderHistryModel?.data?.orders?.length==0||getOrderHistryModel!.data!.orders!.isEmpty?

Container(
    height: MediaQuery.of(context).size.height,
    child: Center(child: Text('No Order Found'))):



Padding(
  padding: const EdgeInsets.all(15),
  child:   RefreshIndicator(
    onRefresh: ()
      async {

        return Future<void>.delayed(const Duration(seconds: 2),() {

          getOrder();

        },);
      },

    child:




    ListView.builder(



      physics: AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: getOrderHistryModel?.data?.orders?.length??0,
      itemBuilder: (context, index) {
        return


          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetailsSreen(OrderId:getOrderHistryModel?.data?.orders?[index].id.toString()??''),));

            },
            child: Padding(
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
                            Text('${getOrderHistryModel?.data?.orders?[index].orderCode}'),
                            SizedBox(width: 10,),

                          ],
                        ),

                        Divider(),

                        Row(
                          children: [
                            Text('Order Date : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),),
                            Text('${getOrderHistryModel?.data?.orders?[index].orderedAt}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),),
                            SizedBox(width: 10,),

                          ],
                        ),

                        Divider(),

                        Row(
                          children: [
                            Text('Deliver Date : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),),
                            Text('${getOrderHistryModel?.data?.orders?[index].deliveryDate}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),),
                            SizedBox(width: 10,),

                          ],
                        ),
SizedBox(height: 5,)
,                       Container(width: MediaQuery.of(context).size.width,
                       height:40,
                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),

                         color: AppColors.gold
                         ),

                       child: Center(child: Text('${getOrderHistryModel?.data?.orders?[index].driverStatus}'),),
                       )


                      ],



                    ),

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


  GetOrderHistryModel?getOrderHistryModel;

  Future<void> getOrder() async {

    // var headers = {
    //   'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMGZkOWFmYmFkZjk2Zjc0Nzg4MjlkNzQ4NDZmMTI3ZGU4ZGJkZmRkOGIwMDcwODcxMDQxNWE5MjNjM2JkZWU0NzE2ODliNzg2OWZiNGUzN2YiLCJpYXQiOjE2OTUzNjQxNTQuNzkxMTE2OTUyODk2MTE4MTY0MDYyNSwibmJmIjoxNjk1MzY0MTU0Ljc5MTEyMDA1MjMzNzY0NjQ4NDM3NSwiZXhwIjoxNzI2OTg2NTU0Ljc4ODE3MDA5OTI1ODQyMjg1MTU2MjUsInN1YiI6IjU2Iiwic2NvcGVzIjpbXX0.l9PiO-5M0Ymqi_rTiGmBR-WsPgMaC-rM8gRAn_0Qs1Zg_7XG42QnA5g8fAm1KyYnYzNPhNHGXta4z_HsPRsaBFeKK4gjFlBgvyPxR5GZlxK_Zudr7x3CCg7fdzTi5KgS29N2dapAsjeANShTqy_pYHBb6l1Vp0z3NV_pifWRz_FvFyrQRmX8tMAcOqDvpd6KWx41aqLy8Puf0OwS0wmkrgGXKznlzZ6mIM2GyA8NXvWdKD3S1X4xeq34Nq-dUNnj1Zjqq6O7X9n80WI8hIi2Si7jg_NNBE1KlVHcKII5XMblynH_GRCKc180_0knp86MpnSTF4xopiM-gBP_2LF1CWE5WHbl_BccMmh3GHCjs3-XPu4793Iw9UUSvf0EN8G6h6jmAq8wLFqHy2o1tfZoZqPGvwj8kf8g0djM595cMh13fSoPDYs7RNuML572dtn8gYfDI5cfemQnIJlszhVfMpCwlg69GbapnepjD4pAmuYFmCaA9ZaOv1St47l8LZ_FwQJ6dtBdvTkQtjnk6mMhNGz0TnGlVbDsK-qEXBvKRdhXbOqg9xmSo6XiXpUv1Qu1oXQCro2VleTSTF1kLH2uE8CQ3devdxyt-nkvkTgaGmCPxFMKuaUT_pqlM2SQWBqK7ld64Vm3v9lbeTYoO11BLgZSeOfNNrJnRywk3YgfKrM',
    //   'Cookie': 'XSRF-TOKEN=eyJpdiI6IlFjeTJ6R09GamRETW9uS1Q2MTAySXc9PSIsInZhbHVlIjoiVEw2S0NDYWx6anJxR254T1dKMnhYT0h4azF6VHJpT2U5SElhNFVnRlBNZTFEdGRMYlJCT3pEdlBxNmxQSEhtc1BXRXh0WWFBa3hwQXdYcWlNY3BEemFTZlh4V2ZTQzRaK0tkRXlDc2pHRmZWZkVZNHNFTXNtdWhXdkdLOVJNRWwiLCJtYWMiOiIzYTczMGQ1ZmQzNjM5NGNmNWRjZjliM2JjNWU3NTFkY2NjZGVhYTA4NjQ2ODU4ODEzN2Q1MTQyOTVjYmU0M2E1IiwidGFnIjoiIn0%3D; laundry_session=eyJpdiI6IlZBazhRaUJpL29FdkxkM3JNNXM4aUE9PSIsInZhbHVlIjoidGNBUjRiSmFOWm40Y2Jtd0FVUWw4L1ZleTBtWkx5RHlDL0REK0FvbkRPeFFKT3pWU0ZFdUxQeTdKZXUrTFl1dzRRSjg0aFVqdjBpYml3U3VraitVcFUwOWp2VDFvaGtQNTJxRmFoQnlnTlFybkV2VzhJYXhHeGQ0c0p1djFWdEwiLCJtYWMiOiIzYzBkN2IyM2NmZDk5ODhjNjJiMmMxNGVlN2QwOWNiNTBhOGYyMDY3YjQxM2EyNjZkMTFkMDc0ZTIzNThiNzRhIiwidGFnIjoiIn0%3D'
    // };
    // var request = http.Request('GET', Uri.parse('${AppConfig.baseUrl1}order-histories'));
    //
    // request.headers.addAll(headers);
    //
    // http.StreamedResponse response = await request.send();
    //
    // if (response.statusCode == 200) {
    //   var result=await response.stream.bytesToString();
    //   var finalResult=GetOrderHistryModel.fromJson(jsonDecode(result));
    //   setState(() {
    //     getOrderHistryModel=finalResult;
    //     print("get order history success");
    //   });
    // }
    // else {
    //   print(response.reasonPhrase);
    // }

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      authToken = prefs.getString('authToken');
    });
    var headers = {
      'Authorization':
      'Bearer ${authToken}', };
    var request = http.Request('GET', Uri.parse('${AppConfig.baseUrl1}total-orders?isAccept=1'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
        var result=await response.stream.bytesToString();
        var finalResult=GetOrderHistryModel.fromJson(jsonDecode(result));
        setState(() {
          getOrderHistryModel=finalResult;
          print("get order history success");
        });
      }
      else {
        print(response.reasonPhrase);
      }
  }



}
