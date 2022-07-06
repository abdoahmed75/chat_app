import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_app/views/login/login_view.dart';
import 'package:chat_app/views/widgets/prof_drawer.dart';
import 'package:http/http.dart'as http;
import 'package:chat_app/controllers/localization_controller.dart';
import 'package:chat_app/controllers/theme_controller.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:chat_app/views/widgets/custom_button.dart';
import 'package:chat_app/views/widgets/custom_text.dart';
import 'package:chat_app/views/widgets/custom_text_field.dart';
import 'package:chat_app/views/widgets/top_header.dart';
class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _controllerL = Get.find<LocalizationController>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _controllerT = Get.find<ThemeController>();
  String?address;
  String?phone;
  String?age;
  String?email,photo;
  TextEditingController phone_c =TextEditingController();
  TextEditingController address_c =TextEditingController();
  TextEditingController age_c =TextEditingController();
  TextEditingController email_c =TextEditingController();

Map <String,dynamic>? response_data ;
  http.Response? response;

String user_url='https://project-graduation.000webhostapp.com/api/user';

  Future <Map <String,dynamic>?>  User_info ( )async{
      response = await http.post(
        Uri.parse(user_url) ,
        headers: {
          "authToken": token!,
        },);
  return jsonDecode(response!.body);

  }
  void UpdateJobW (Map<String,dynamic>data)async
  {
    await http.post(
        Uri.parse('https://project-graduation.000webhostapp.com/api/update-user-info'),
        headers: {
          "authToken": token!,
        },
        body: <String,dynamic>
        {
          "email":data["email"],
          "phone":data["phone"],
          "date_of_birth":data["date_of_birth"],
          "main_address":data["main_address"],
        }

    );
  }
  @override
  void initState() {
    super.initState();
  }

      @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _scaffoldKey,
        drawer: ProfDrawer(),
        body: FutureBuilder(
          future: User_info(),
          builder: (context,AsyncSnapshot <Map <String ,dynamic>? >snapshot) {
           if(!snapshot.hasData) return Center(child: CircularProgressIndicator());
            else{
              phone_c.text=snapshot.data!["phone"];
              address_c.text=snapshot.data!["main_address"];
              age_c.text=snapshot.data!["date_of_birth"];
              email_c.text=snapshot.data!["email"];
              return SingleChildScrollView(
            child:Form(
            key: _formKey,
            child: Column(
            children: [
              TopHeaderWithCart(
                w: w,
                h: h,
                isDark: _controllerT.darkTheme,
                lang: _controllerL.lang,
                onClick: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
            SizedBox(
            height: h * 0.001,
            ),


            Container(
            // height: MediaQuery.of(context).size.height*0.2,
            // width: MediaQuery.of(context).size.height*0.2,
              child: CircleAvatar(
                backgroundImage:photo!=''?NetworkImage('${snapshot.data!["photo"]}'):NetworkImage('https://img.freepik.com/free-vector/hand-painted-watercolor-pastel-sky-background_23-2148902771.jpg?w=2000'),
                radius: MediaQuery.of(context).size.width*0.15,
            ),
            ),

            SizedBox(
            height: h * 0.01,
            ),
            CustomText(
            text: '${snapshot.data!["name"]}',
            //
           /* color: _controller.darkTheme
            ? Colors.white70
                : TextColors.FORGET_ACCOUNT,*/
            align: Alignment.center,
            fontSize: w*.07,


            ),
             SizedBox(
            height: h * 0.01,
            ),
            SizedBox(
            height: h * 0.01,
            ),
            CustomText(
            text: '${snapshot.data!["job"]}',
           //
            /*color: _controller.darkTheme
            ? Colors.white
                : TextColors.FORGET_ACCOUNT,*/
            align: Alignment.center,
            fontSize: w*.06,
            ),
            SizedBox(
            height: 5,
            ),
            Padding(
            padding: EdgeInsets.only(left: 20, top: 20, right: 20),
            child: Card(
              //
            /*color: _controller.darkTheme
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
            hint: 'الفون',
            fontSize:w*.05,
            controller:phone_c ,
            onSaved: (s){phone=phone_c.text;},
            ),
            SizedBox(
            height: 7,
            ),
            CustomTextField(
            hint: 'العنوان',
            fontSize: w*.05,
            controller:address_c ,
            onSaved: (s){address=address_c.text;},

            ),
            SizedBox(
            height: 7,
            ),
            CustomTextField(
            hint: 'العمر',
            fontSize: w*.05,
            controller:age_c ,
            onSaved: (s){age=age_c.text;},

            ),
            SizedBox(
            height: 7,
            ),
            CustomTextField(
            hint: 'البريد الالكترونى',
            fontSize: w*.05,
            controller:email_c ,
            onSaved: (s){email=email_c.text;},

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
              //height: h*.04,
            margin: EdgeInsets.symmetric(horizontal: w * 0.3),
            child: CustomButton(
            text: 'تعديل',
            p: EdgeInsets.all(12),
            onPress: ()
            {
              if(_formKey.currentState!.validate())
              {
                _formKey.currentState!.save();
                setState(() {
                  UpdateJobW( {
                    "email":email,
                    "phone":phone,
                    "date_of_birth":age ,
                    "main_address":address,

                  });
                });}
            },
            ),
            ),
            SizedBox(
            height: 25,
            ),


            ],
            ),
            ),
            );}
            }, ));
  }
}
