import 'package:flutter/material.dart';

import '../../Custom Widget/costomTextfield.dart';
import '../../Helper/app_colors.dart';
class PaymentRequst extends StatefulWidget {
  const PaymentRequst({Key? key}) : super(key: key);

  @override
  State<PaymentRequst> createState() => _PaymentRequstState();
}

class _PaymentRequstState extends State<PaymentRequst> {
  @override
  Widget build(BuildContext context) {
    return    Scaffold(

      appBar: AppBar(
        backgroundColor: AppColors.gold,
        centerTitle: true,
        title: Text('Payment'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(

          child: Column(children: [


            SizedBox(height: 5,),
            Row(
              children: [
                SizedBox(width: 10,),

                Text('Payment History',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),



              ],
            ),

            SizedBox(height: 5,),

            Container(
              height: MediaQuery.of(context).size.height/1.4,
              child: ListView.builder(

                physics: AlwaysScrollableScrollPhysics(),

                shrinkWrap: true,

                itemCount:40,

                itemBuilder: (context, index) {

                  return

                    InkWell(

                      onTap: () {



                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10,bottom: 15),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),

                          elevation: 5,



                          child:

                          Container(





                            width: MediaQuery.of(context).size.width,

                            child: Padding(

                              padding:  EdgeInsets.all(10),

                              child: Column(



                                children: [

                                  Row(
                                    children: [
                                      Text('Transaction Id : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                      Text('NBNK345BK5667KB'),
                                      SizedBox(width: 10,),

                                    ],
                                  ),

                                  Divider(),

                                  Row(
                                    children: [
                                      Text('Payment Date : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),),
                                      Text('22-04-2022',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),),
                                      SizedBox(width: 10,),

                                    ],
                                  ),

                                  Divider(),

                                  Row(
                                    children: [
                                      Text('Payment Amount : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),),
                                      Text('500 /-',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),),
                                      SizedBox(width: 10,),

                                    ],
                                  ),

                                  Divider(),

Row(children: [

  Container(height: 30,width: MediaQuery.of(context).size.width/1.4,

  decoration: BoxDecoration(

      color: AppColors.gold,
      borderRadius: BorderRadius.circular(75)),

    child: Center(child: Padding(
      padding: const EdgeInsets.all(4),
      child: Text('Success'),
    ),),
  )

],)


                                ],



                              ),

                            ),

                          ),

                        ),
                      ),
                    );





                },),
            )







          ]),
        ),
      ),
bottomSheet:  ElevatedButton(
    style: ElevatedButton.styleFrom(
        primary: AppColors.gold // Background color
    ),
    onPressed: () {

      showAlertDialog(context);


    },
    child: Container(
        height: 50,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Center(child:




        Text('Sent Request For Payment'),


        ))),


    );

  }


  showAlertDialog(BuildContext context) {





    AlertDialog alert = AlertDialog(
      title: Text("Request For Payment"),
      actions: [

       Padding(
         padding: const EdgeInsets.all(8.0),
         child: Form(
           key: _formKey,
           child: Column(children: [
             SizedBox(height: 20,),
             CustomTextField(
                 maxleanthh: 15,
                 controller: amountController,hintt: 'Enter Amount',validation: 'Please Enter Amount'),


             SizedBox(height: 20,),

             ElevatedButton(
                 style: ElevatedButton.styleFrom(
                     primary: AppColors.gold // Background color
                 ),
                 onPressed: () {
if (_formKey.currentState!.validate()) {

Navigator.pop(context);

    }




                 },
                 child: Container(
                     height: 40,
                     width: MediaQuery
                         .of(context)
                         .size
                         .width/1.7,
                     child: Center(child:




                     Text('Sent Request'),


                     ))),


             SizedBox(height: 20,),


           ],),
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
  bool _isLoading = true;
  final _formKey = GlobalKey<FormState>();
TextEditingController amountController=TextEditingController();

}
