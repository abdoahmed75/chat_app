import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_app/routes/app_routes.dart';
import 'package:http/http.dart'as http;
import 'package:chat_app/controllers/localization_controller.dart';
import 'package:chat_app/controllers/theme_controller.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:chat_app/views/widgets/custom_button.dart';
import 'package:chat_app/views/widgets/custom_text_field.dart';
import 'package:chat_app/views/widgets/top_header.dart';
class Contact extends StatefulWidget {
  final String? authToken;
  const Contact({Key? key, this.authToken}) : super(key: key);

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _controllerL = Get.find<LocalizationController>();

  final _controllerT = Get.find<ThemeController>();
  String?email,content;
  Map<String,dynamic>? help_data;
  TextEditingController email_c =TextEditingController();
  TextEditingController content_c =TextEditingController();
  String Sign_url='https://project-graduation.000webhostapp.com/api/contact-us';


  @override
  void initState() {
    super.initState();

  }
  Future <http.StreamedResponse>? Sign_up_Users (Map<String,dynamic>data )async{

    http.StreamedResponse? response;

    try {
      print(data);
      var request=http.MultipartRequest("POST",Uri.parse(  Sign_url) );
      request.fields.addAll( {
        "email":data["email"],
        "message":data["message"],
      });
      response= await request.send();
    } on Exception {
      print('error happend');
    }
    return response! ;
  }
  void dispose() {
    email_c.dispose();
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
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                    height: h*.4,
                    width: double.infinity,
                    child: Image.network('https://media.istockphoto.com/photos/contact-us-sign-on-a-wooden-desk-picture-id1091858450?k=20&m=1091858450&s=612x612&w=0&h=XIYDV34VKElligRzDtSfgOR6HLXmVaGU8-Rhhd5kQSc=',)),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top:3, right: 10),
                  child: Card(
                    elevation: 10,
                    margin: EdgeInsets.all(0),
                    shadowColor: AppConstants.K_Border_COlor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            hint: 'ادخل البريد الالكترونى',
                            fontSize: w*.04,
                            controller:email_c ,
                            //callBackValidor:(s){return s==null || s.isEmpty? 'يلزم ادخال الاسم':null; },
                            onSaved: (s){email=email_c.text;},
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTextField(
                            maxLine: 7,
                            fontSize: w*.04,
                            controller:content_c ,
                            //callBackValidor:(s){return s==null || s.isEmpty? 'يلزم ادخال الاسم':null; },
                            onSaved: (s){content=content_c.text;},
                          ),
                          const SizedBox(
                            height: 5,
                          ),


                          SizedBox(
                            height: 10,
                          ),


                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10,top: 20,bottom: 20),

                                child:Container(
                                  //height: h*.04,
                                  width: w*.27,
                                  margin: EdgeInsets.symmetric(horizontal: w * 0.3),
                                  child: CustomButton(
                                      text: 'ارسال',
                                      p: EdgeInsets.all(12),
                                      onPress: ()  async {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          help_data = {
                                            'email': email,
                                            'message':content,
                                          };

                                          await Sign_up_Users(help_data!);

                                        }
                                      }
                                  ),
                                ),
                              ),

                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),

                SizedBox(
                  height: 25,
                ),

              ],
            ),
          ),
        )
    );
  }
}
