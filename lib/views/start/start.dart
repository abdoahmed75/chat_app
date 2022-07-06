
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:chat_app/views/login/login_view.dart';
import 'package:http/http.dart'as http;
import 'package:chat_app/controllers/localization_controller.dart';
import 'package:chat_app/controllers/theme_controller.dart';
import 'package:chat_app/routes/app_routes.dart';
class Start extends StatefulWidget {
  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  final _controller = Get.find<ThemeController>();

  final _controller2 = Get.find<LocalizationController>();

  String Login_url='https://project-graduation.000webhostapp.com/api/login';

  Future <http.Response>? Login_Users (Map<String,String>data )async{
    http.Response? response;
    try {
      print(data["phone"]);
      print(data["password"]);
      response = await http.post(
        Uri.parse(Login_url) ,

        body: <String, String>{
          "phone":data['phone']!,
          "password":data['password']!,


        },
      );


    } on Exception catch (e) {
      print('error happend');
      print(response!.statusCode);
    }
    return response ;
  }
  @override
  void initState() {
    login(context);
    super.initState(

    );
  }
  void login (BuildContext context) async
  {
    var pref=GetStorage();
    var phone=pref.read("phone")??"";
    var password=pref.read("password")??"";
    if(phone==""||password=="")
      {
        return;
      }

    Map<String,String>data=
    { "phone":phone,
      "password":password,
    };
    var user=await Login_Users(data);
    if(jsonDecode(user!.body)["status"]==true)
    {
      token=jsonDecode(user.body)["msg"]["token"].toString();
      print(token);
      Get.offAndToNamed(Routes.CONTROL);

    }
    else
    {
      showDialog(context: context, builder:(context){return AlertDialog(title: Text('خطا'),content: Text('حدث خطا اثناء المصادقه يرجى ادخال البياتات صحيحه'),);} );
    }
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
    backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               SizedBox(
                   height: h*.8,
                   width: double.infinity,
                   child: Image.asset('assets/images/icon.jpeg',)),

              SizedBox(
  height: h*.05,
  width:double.infinity,
  child:   RaisedButton(

    color: Colors.green,

    onPressed: (){

    Get.toNamed(Routes.LOGIN);
    },
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
    ),

    child: Text('Get Started',
    style: TextStyle(
      color: Colors.white,
      fontSize: w*.05,
    ),

    ),







  ),
)
            ],

          ),
        ),
      ),

    );
  }
}
