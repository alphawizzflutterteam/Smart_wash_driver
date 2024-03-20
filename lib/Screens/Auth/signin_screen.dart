import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Api Services/allApiscreen.dart';
import '../../Custom Widget/costomTextfield.dart';
import '../../Helper/app_colors.dart';
import '../../Helper/constant.dart';
import '../../Model/signinModel.dart';
import 'package:http/http.dart' as http;

import '../homepage/homePageScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 230,
                  width: 375,
                  child: Center(
                    child: Hero(
                      tag: 'logo',
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 150,
                        width: 195,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                CustomTextField(
                    keyboardtype: TextInputType.number,
                    maxleanthh: 10,
                    controller: emailAndFone,
                    hintt: 'Enter Mobile Number',
                    validation: 'Please Enter Mobile Number'),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    maxleanthh: 15,
                    controller: password,
                    hintt: 'Enter Password',
                    validation: 'Please Enter Password'),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.gold // Background color
                        ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isLoading = false;
                        });
                        loginApi();
                        Future.delayed(
                          Duration(seconds: 5),
                          () {
                            setState(() {
                              _isLoading = true;
                            });
                          },
                        );
                      }
                    },
                    child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child: _isLoading == false
                                ? Text('Waiting....')
                                : Text('Login')))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  var vendorrrid;
  bool _isLoading = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailAndFone = TextEditingController();
  TextEditingController password = TextEditingController();

  SigninModel? signinModel;

  Future<void> loginApi() async {
    var request =
        http.MultipartRequest('POST', Uri.parse('${AppConfig.baseUrl1}login'));
    request.fields
        .addAll({'contact': emailAndFone.text, 'password': password.text});

    print('rq============"${request.url}');
    print('pr============"${request.fields}');

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult1 = jsonDecode(result);

      if (finalResult1['message'] == "Log In Successfull") {
        setState(() {
          vendorrrid = finalResult1['data']['user']['id'].toString();
        });

        var finalResult2 = SigninModel.fromJson(jsonDecode(result));
        setState(() {
          signinModel = finalResult2;
          print("=======vendor login id==${vendorrrid.toString()}");
        });

        await setPreference(
            vendorrrid ?? '', signinModel?.data.access.token ?? '');

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
      } else {
        print('yyyyyyyyy');
        Fluttertoast.showToast(msg: finalResult1['message']);
      }
    }
  }

  Future<void> setPreference(
    String iddd,
    // String firstNamee,
    // String lastNamee,
    // String namee,
    // String emaill,
    // String mobilee,
    // String genderr,
    // String addresss,
    // String profilePhotoPathh,
    // String dateOfBirthh,
    String authToken,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('venderId', iddd);
    // await prefs.setString('firstName', firstNamee);
    // await prefs.setString('lastName', lastNamee);
    // await prefs.setString('name', namee);
    // await prefs.setString('emait', emaill);
    // await prefs.setString('mobileNumber', mobilee);
    // await prefs.setString('gender', genderr);
    // await prefs.setString('address', addresss);
    // await prefs.setString('imageFile', profilePhotoPathh);
    // await prefs.setString('dateOfBirth', dateOfBirthh);
    await prefs.setString('authToken', authToken);
  }
}
