import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart'as http;
import 'package:chat_app/controllers/localization_controller.dart';
import 'package:chat_app/controllers/theme_controller.dart';
import 'package:chat_app/routes/app_routes.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:chat_app/views/widgets/custom_button.dart';
import 'package:chat_app/views/widgets/custom_text.dart';
import 'package:chat_app/views/widgets/custom_text_field.dart';
import 'package:chat_app/views/widgets/top_header.dart';

String? token;

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}


class _LoginViewState extends State<LoginView> {
  final _controller = Get.find<ThemeController>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _controller2 = Get.find<LocalizationController>();

  TextEditingController phone_c =TextEditingController();

  TextEditingController password_c =TextEditingController();
  String Login_url='https://project-graduation.000webhostapp.com/api/login';
  String?phone;
  String?password;
  Map<String,String>? login_data;
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
    }
    return response! ;
  }
@override
  void dispose() {
    phone_c.dispose();
    password_c.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    var f = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        key:_formKey,
        child: Column(
          children: [
            TopHeader(
              w: w,
              h: h,
              isDark: _controller.darkTheme,
              lang: _controller2.lang,
            ),

            SizedBox(
              height: h * 0.13,
            ),
            GestureDetector(
              onTap: (){},
              child: FlatButton(
                child:Text( "Create_New_Account".tr,
                  style: TextStyle(fontSize: w*.06),
                ),

                onPressed: (){
                Get.back();
                  Get.toNamed(Routes.sign);
                },
              ),
            ),
            SizedBox(
              height: h * 0.001,
            ),
            GestureDetector(
              onTap: (){},
              child: FlatButton(
                child:Text( 'Forgotten_account?'.tr,
                  style: TextStyle(fontSize: w*.04),
                ),
                onPressed: (){
                  Get.toNamed(Routes.enterEmail);
                },
              ),
            ),

            SizedBox(
              height: 5,
            ),
            Padding(

              padding: EdgeInsets.only(left: 20, top: 20, right: 20),

              child: Card(
               /* color: _controller.darkTheme
                    ? AppDarkConstant.APP_DARK_COLOR
                    : Colors.white,*/
                elevation: 10,
                margin: EdgeInsets.all(0),
                shadowColor: AppConstants.K_Border_COlor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(

                    children: [

                      CustomTextField(
                        hint: "Phone".tr,
                        fontSize: w*.05,
                        suffixIcon: Icon(Icons.phone,size: h*.05,),
                        controller: phone_c,
                        keyboardType:TextInputType.phone,
                        onSaved: (s){phone=phone_c.text;},
                        callBackValidor:(s){ return s==null || s.isEmpty? 'يلزم ادخال الفون':null;},

                      ),
                      SizedBox(
                        height: 7,
                      ),
                      CustomTextField(
                        hint: "Password".tr,
                        fontSize: w*.05,
                        suffixIcon: Icon(Icons.lock,size: h*.05),
                        controller: password_c,
                        onSaved: (s){password=password_c.text;},
                        callBackValidor:(s){ return s==null || s.isEmpty? 'يلزم ادخال كلمة المرور':null;},
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              //height: h*.06,
              margin: EdgeInsets.symmetric(horizontal: w * 0.3),
              child: CustomButton(
                text: 'Sign_in'.tr,
                p: EdgeInsets.all(12),
                onPress: () async{
                   //Get.toNamed(Routes.CONTROL);
                   if (_formKey.currentState!.validate())
                   {
                     _formKey.currentState!.save();
                     print(phone);
                     print(password);
                     login_data=
                     {
                       "phone":phone!,
                       "password":password!
                     };
                     print(login_data);
                     var data=await Login_Users(login_data!);
                    print( jsonDecode(data!.body)!["msg"]);
                    print(data.statusCode);

                     if(jsonDecode(data.body)["status"]==true)
                     {
                       var pref=GetStorage();
                       pref.write("phone", login_data!["phone"]);
                       pref.write("password", login_data!["password"]);

                       token=jsonDecode(data.body)["msg"]["token"].toString();
                       print(token);
                       Get.offAndToNamed(Routes.CONTROL);

                     //Navigator.of(context).push(MaterialPageRoute(builder:(context){return HomeView(authToken:jsonDecode(data!.body)["msg"]["token"].toString());}));
                     }
                     else
                       {
                         showDialog(context: context, builder:(context){return AlertDialog(title: Text('خطا'),content: Text('حدث خطا اثناء المصادقه يرجى ادخال البياتات صحيحه'),);} );
                       }
                   }
                },

              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: 'Continue_with'.tr,
                  fontSize: w*.05,
                  color: _controller.darkTheme ? Colors.white : Color(0xFF13245A),
                  align: Alignment.center,
                ),
                SizedBox(
                  width: 8,
                ),
                Icon(
                  FontAwesomeIcons.facebook,
                  color: _controller.darkTheme ? Color(0xFF546287) : Colors.blue,size: h*.05
                ),
                SizedBox(
                  width: 8,
                ),
                Icon(
                  FontAwesomeIcons.google,size: h*.05,
                  color: Color(0xFF6D7BA0),
                ),
                SizedBox(
                  width: 8,
                ),
                Icon(
                  FontAwesomeIcons.apple,size: h*.05,
                  color: Color(0xFF6D7BA0),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    ));
  }
}
