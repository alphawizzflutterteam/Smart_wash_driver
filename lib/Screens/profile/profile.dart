import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Api Services/allApiscreen.dart';
import '../../Custom Widget/costomTextfield.dart';
import '../../Helper/app_colors.dart';
import '../../Helper/constant.dart';
import '../../Model/getProfileModel.dart';
import '../../Model/getServiceModel.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getServices();
    getdata();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [

                SizedBox(height: 60,),
                Stack(children :[


                  InkWell(
                    onTap: () {

                      selectImage();
                    },
                    child:
          imageFile==null?
          CircleAvatar(
            backgroundColor: AppColors.gray,


            radius: 50,
            backgroundImage: AssetImage('assets/images/dpppp.jpg'),

          ):
                    CircleAvatar(
                      backgroundColor: AppColors.gray,

                      radius: 50,

                     backgroundImage:NetworkImage('${imageFile}'),
                    //  child: Image.network('${imageFile}'),

                    ),
                  ),


                  Positioned(
                      top: 60,
                      left: 80,
                      right: 60,
                      child: Icon(Icons.camera_alt))



                ]),
                SizedBox(height: 20,),

                Container(
                  height: MediaQuery.of(context).size.height / 1.7,
                  child: SingleChildScrollView(
                    child: Column(children: [
                      SizedBox(
                        height: 8,
                      ),
                      CustomTextField(
                          maxleanthh: 35,
                          controller: firstnameController,
                          hintt: 'Enter First Name',
                          validation: 'Please Enter First Name'),
                      SizedBox(
                        height: 8,
                      ),
                      CustomTextField(
                          maxleanthh: 35,
                          controller: lastnameController,
                          hintt: 'Enter Last Name',
                          validation: 'Please Enter Last Name'),
                      SizedBox(
                        height: 8,
                      ),

                      TextFormField(
                        maxLength: 40,
                        controller:emailController,
                        decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.grey)),
                          hintText:'Enter Email Id',
                          suffixStyle: const TextStyle(color: Colors.grey),
                          counterText: '',
                        ),
readOnly: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Email Id';
                          }
                          return null;
                        },
                      ),
                      // CustomTextField(
                      //     maxleanthh: 40,
                      //     controller: emailController,
                      //     hintt: 'Enter Email Id',
                      //     validation: 'Please Enter Email Id'),
                      SizedBox(
                        height: 8,
                      ),

                      TextFormField(
                        maxLength: 10,
                        controller:mobileController,
                        decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.grey)),
                          hintText:'Enter Mobile Number',
                          suffixStyle: const TextStyle(color: Colors.grey),
                          counterText: '',
                        ),
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Mobile Number';
                          }

                        },
                      ),
                      // CustomTextField(
                      //     maxleanthh: 10,
                      //     controller: mobileController,
                      //     hintt: 'Enter Mobile Number',
                      //     validation: 'Please Enter Mobile Number'),

                      SizedBox(
                        height: 8,
                      ),
                      CustomTextField(
                          maxleanthh: 250,
                          controller: addressController,
                          hintt: 'Enter Address',
                          validation: 'Please Enter Address'),




                      SizedBox(
                        height: 8,
                      ),


                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.grey),borderRadius: BorderRadius.circular(3)),
                        child:

                        ListTile(


                        title:  Text("${dateofBirth}",style: TextStyle(color: Colors.black),overflow:TextOverflow.ellipsis ,maxLines: 1, ),


                          trailing: Icon(Icons.calendar_month),

                        ),
                      ),



                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,


                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3)
                            ,
                            border: Border.all(color: Colors.grey,width: 1)),


                        child:

                        Row(
                          children: [
                            SizedBox(width: 12,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width/1.7,
                              child: TextFormField(
                                decoration: InputDecoration(

                                    border: InputBorder.none,
                                    hintText: 'Select Gender'),
                                controller: genderController,
                              ),
                            ),

                            DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                onChanged: (String? newValue) {
                                  setState(() {
                                    genderController.text = newValue??"";
                                    print("${genderController.text}");
                                  });
                                },
                                items: genderList?.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                            SizedBox(width: 10,),
                          ],
                        )

                        ,),



                      SizedBox(
                        height: 8,
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,


                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3)
                            ,
                            border: Border.all(color: Colors.grey,width: 1)),


                        child:

                        Row(
                          children: [
                            SizedBox(width: 12,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width/2,
                              child: TextFormField(
                                decoration: InputDecoration(

                                    border: InputBorder.none,
                                    hintText: 'Select Delivery Type'),
                                controller: servicespController,
                              ),
                            ),

                            DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                onChanged: (newValue) {
                                  setState(() {
                                    servicespController.text = newValue??"";
                                    print('===========${servicespController.text}');



                                  });
                                },
                                items: services_p?.map<DropdownMenuItem<String>>((value) {
                                  return

                                    DropdownMenuItem<String>(
                                      value: value['type'],
                                      child: Text(value['type']),
                                      onTap:() {
                                        setState(() {
                                          selectDeliveryTypeId=value['id'];
                                          print("DELIVERYtYPE ID===============${selectDeliveryTypeId}");
                                        });

                                      },
                                    );



                                }).toList(),
                              ),
                            ),
                            SizedBox(width: 10,),
                          ],
                        )

                        ,),

                      SizedBox(
                        height: 8,
                      ),
                      InkWell(

                        onTap: () {


                          selectScreen();
                        },


                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.grey),borderRadius: BorderRadius.circular(3)),
                          child:

                          ListTile(

                            title:
                            comma==null?
                            Text("Please Select Services",style: TextStyle(color: Colors.black),overflow:TextOverflow.ellipsis ,maxLines: 1, ):
                            Text("${comma}",style: TextStyle(color: Colors.black),overflow:TextOverflow.ellipsis ,maxLines: 1, ),


                            trailing: Icon(Icons.arrow_drop_down),

                          ),
                        ),
                      ),


                      SizedBox(
                        height: 8,
                      ),

                    ]),
                  ),
                ),


                SizedBox(
                  height: 30,
                ),

                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.gold // Background color
                    ),
                    onPressed: () {

                              setState(() {
                                _isLoading = false;
                              });
                              removeSession();
                              UpdateApi();
getdata();
                              Future.delayed(Duration(seconds: 5), () {
                                setState(() {
                                  _isLoading = true;
                                });
                              },);






                    },
                    child: Container(
                        height: 50,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: Center(child:


                        _isLoading == false ? Text('Waiting....') :

                        Text('Update Profile'),


                        ))),




                SizedBox(
                  height: 70,
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> removeSession() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('firstName');
    await prefs.remove('lastName');
    await prefs.remove('name');
    await prefs.remove('emait');
    await prefs.remove('mobileNumber');
    await prefs.remove('gender');
    await prefs.remove('address');
    await prefs.remove('imageFile');
    await prefs.remove('dateOfBirth');



    print("remove success");

  }

  Future<void> setPreference
      (
      String firstNamee,
      String lastNamee,
      String emaill,
      String mobilee,
      String genderr,
      String addresss,
      String profilePhotoPathh,
      String dateOfBirthh,

      )

  async {


    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstName',firstNamee);
    await prefs.setString('lastName',lastNamee);
    await prefs.setString('emait', emaill);
    await prefs.setString('mobileNumber',mobilee );
    await prefs.setString('gender', genderr);
    await prefs.setString('address',addresss);
    await prefs.setString('imageFile',profilePhotoPathh);
    await prefs.setString('dateOfBirth', dateOfBirthh);

  }


  Future<void> getdata() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {


      venderId=prefs.getString('venderId');
      firstname=prefs.getString('firstName')??'';
      lastName=prefs.getString('lastName')??'';
      name=prefs.getString('name')??'';
      email=prefs.getString('emait')??'';
      mobile=prefs.getString('mobileNumber')??'';
      gender=prefs.getString('gender')??'';
      address=prefs.getString('address')??'';
      imageFile=prefs.getString('imageFile');
      dateofBirth=prefs.getString('dateOfBirth')??'';
      authToken=prefs.getString('authToken')??'';


      firstnameController.text=firstname.toString();
      lastnameController.text=lastName.toString();
      emailController.text=email.toString();
      mobileController.text=mobile.toString();
      genderController.text=gender.toString();
      addressController.text=address.toString();

    });
    print("get data success");

  }
  void selectImage(){

    showModalBottomSheet(
        context: context,
        builder: (builder){
          return

            new Container(
            height: 250,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child:  Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child:Column(children: [


                  SizedBox(height: 10,),
                  Container(height: 5,
                    width: 150,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(75),color: Colors.grey),
                  ),
                  SizedBox(height: 30,),

                    
                    Text('Select Any One Option',style: TextStyle(fontSize: 17,color: Colors.black,fontWeight:FontWeight.bold ),),
                    SizedBox(height: 20,),
                 InkWell(
                   
                   onTap: () {

                     selectFromGallery();

                   },
                   child: Card(
                     elevation: 5,
                     child: Container(width: 200,
                   height: 50,
                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                     child:Center(child:Text('Select From Gallery')),


                   ),),
                 ),


                    SizedBox(height: 30,),
                    InkWell(

                      onTap: () {

                        selectFromCamera();

                      },
                      child: Card(
                        elevation: 5,
                        child: Container(width: 200,
                        height: 50,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                        child:Center(child:Text('Select From Gallery')),


                      ),),
                    )
                    


                ],) ),
          );
        }
    );

  }

  XFile? imagefile;

  Future selectFromGallery() async {

    final picker = ImagePicker();
    Navigator.pop(context);
final XFile? image  =  await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        imagefile = XFile(image.path);
        print("${imagefile!.path.toString()}");
        imageFile=imagefile!.path.toString();

      });
    }


  }


  Future<void> selectFromCamera() async {

    final picker = ImagePicker();
    Navigator.pop(context);
    final XFile? image  =  await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        imagefile = XFile(image.path);
        print("${imagefile!.path.toString()}");

        imageFile=imagefile!.path.toString();

      });
    }

  }
  String ?selectDeliveryTypeId;

  void selectScreen(){



    var result=

    showDialog(context: context, builder: (context) {
      return
        Multiselectrd(items:getServicesModel!.data!.services??[],);
    },);

    if(result!=null)
    {
      setState(() {

        isSelected=result as dynamic;
      });
    }
  }



  bool _isLoading = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController mobileController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController servicespController = TextEditingController();
  TextEditingController servicesController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController passworddController = TextEditingController();
  TextEditingController passworddConfirmController = TextEditingController();

  List<Map<String, dynamic>>services_p = [

    {'type':'Pickup/Drop',
      'id':'1'
    },
    {'type':'On Shop',
      'id':'2'
    },
    {'type':'Both',
      'id':'3'
    },
  ];

  List<String> genderList = [
    'Male',
    'Female',

  ];

  var servicess;

  bool ?valueee=false;
  // Option 2
  // GetProfileModel?getProfileModel;
  Future<void> UpdateApi() async {

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authToken.toString()}',
     'Cookie': 'XSRF-TOKEN=eyJpdiI6InlTTk9VemwvajA5bjdzUWczZkluMVE9PSIsInZhbHVlIjoiN1dMZVFua0N2dlU3RUMzbW9hQUNwd2E1dmFrRGVsSnF3Z0FqZ296enBqRHp4WkVsQ2w1RmtqU1dWci9zT2FlSWYwUnhsckdLZDAyZ1BUZExMUmpKNEJFMlByanRtMzBDTnRaTHA3L1Y0MmIvaGg1b0dlS3pweW9tTFB3ZnN4ZWciLCJtYWMiOiIyOGUwMmNhYTAwNDcwNDdlMmQ4ZDBhOWQ2ZjI5NGQ0ZTQ2NzAzNmNjYWRhMjkyOGM2MzljYmZhMzM1ZWFiYjkwIiwidGFnIjoiIn0%3D; laundry_session=eyJpdiI6IjJPWDl5Rm4vTWZzV1dDSCtqajcyT3c9PSIsInZhbHVlIjoiOTNlSVdEU2N6Qm5hMDBWM09NNGRla2xzQVIra0JzWktKVktLZ0gxWFJlQUd4dGU5dEduMW9TdjRqT0dXRi91M21yUVo1MlRINUQzeHJhZmZFbVJyVlhNOWZicUwzRFJ6cUNFb3pNS0FmNG4vOWU1bjk0VDlpM2Zad1NVK0V1LzkiLCJtYWMiOiI5Y2Y5OGVjZTYzYTY2ZWM4NjkzZjZhMGUzY2M2NTFiMDZkYWE2MzgwMDQxNzMyYmQwMjA0OGRlNjQwYTA4NDFkIiwidGFnIjoiIn0%3D'
    };
    var request = http.Request('POST', Uri.parse(ApiService.updateProfileUrl));
    request.body = json.encode({
      "first_name": firstnameController.text,
      "last_name": lastnameController.text,
      "mobile": mobileController.text,
      "email": emailController.text,
      "address": addressController.text,
      "services": selectedId,
      "service_p": selectDeliveryTypeId,
      "gender": genderController.text
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {

      var result =await response.stream.bytesToString();
      var finalll=jsonDecode(result);

      // var finalResult =GetProfileModel.fromJson(jsonDecode(result));
      //
      // setState(() {
      //   getProfileModel=finalResult;
      //
      //   setPreference(
      //     getProfileModel?.data?.user?.firstName??'',
      //     getProfileModel?.data?.user?.lastName??'',
      //     getProfileModel?.data?.user?.email??'',
      //     getProfileModel?.data?.user?.mobile??'',
      //     getProfileModel?.data?.user?.gender??'',
      //     getProfileModel?.data?.user?.address??'',
      //     getProfileModel?.data?.user?.profilePhotoPath??'',
      //     getProfileModel?.data?.user?.dateOfBirth??'',
      //
      //
      //   );
// Fluttertoast.showToast(msg: finalll['message']);
//
//       });
      print("update success");
    }
    else {
      print(response.reasonPhrase);
    }

  }


  List<String>postServicesList=[];
  GetServicesModel?getServicesModel;

  Future<void> getServices() async {



    var request = http.Request('GET', Uri.parse('${AppConfig.baseUrl2}/services'));


    http.StreamedResponse response = await request.send();


    if (response.statusCode == 200) {

      var result =await response.stream.bytesToString();
      var finalresult=GetServicesModel.fromJson(jsonDecode(result));

      setState(() {
        getServicesModel=finalresult;
        print("get services success");
      });
    }
    else {
      print(response.reasonPhrase);
    }

  }
}
List<String> isSelected = [];
List<String> selectedId=[];

var comma;


class Multiselectrd extends StatefulWidget {
  final List<GetServices>? items;
  const Multiselectrd({super.key,required this.items});

  @override
  State<Multiselectrd> createState() => _MultiselectrdState();
}

class _MultiselectrdState extends State<Multiselectrd> {




  void itmechange(String selectedItem, bool isselectedd) {
    setState(() {
      if (isselectedd) {


        isSelected.add(selectedItem);
        comma=isSelected.join(',');
        print(isSelected);
        print('==============${comma}');
      }
      else {
        isSelected.remove(selectedItem);
        comma=isSelected.join(',');
        print(isSelected);
        print('=========${comma}');
      }
    });
  }
  void itmeID(String selectedIteMID, bool isselectedd) {
    setState(() {
      if (isselectedd) {

        comma=isSelected.join(',');
        selectedId.add(selectedIteMID);
        print(selectedId);
      }
      else {
        selectedId.remove(selectedIteMID);
        print(selectedId);

      }
    });
  }
  void submit(){

    Navigator.pop(context,selectedId);
  }

  @override
  Widget build(BuildContext context) {
    return

      AlertDialog(
        title: Text("Select Services"),
        content: SingleChildScrollView(child: ListBody(children:
        widget.items!.map((item) =>
            CheckboxListTile(


              value: isSelected.contains(item.name),
              title: Text(item.name.toString()),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (isCheck) {

                itmeID(item.id.toString(),isCheck!);
                itmechange(item.name.toString(), isCheck!);
              },
              // =>


            )).toList(),

        ),),
        actions: [
          TextButton(onPressed: () {
            Navigator.pop(context);
          }, child: Text('Back')),
          TextButton(onPressed: () {
            submit();

          }, child: Text('Submit')),


        ],
      );
  }




}

