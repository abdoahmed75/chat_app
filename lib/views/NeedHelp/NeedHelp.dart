import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_app/views/login/login_view.dart';
import 'package:http/http.dart'as http;
import 'package:chat_app/controllers/localization_controller.dart';
import 'package:chat_app/controllers/theme_controller.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:chat_app/views/widgets/custom_button.dart';
import 'package:chat_app/views/widgets/custom_text_field.dart';
import 'package:chat_app/views/widgets/top_header.dart';
class NeedHelp extends StatefulWidget {
  final String? authToken;
  const NeedHelp({Key? key, this.authToken}) : super(key: key);

  @override
  _NeedHelpState createState() => _NeedHelpState();
}

class _NeedHelpState extends State<NeedHelp> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _controllerL = Get.find<LocalizationController>();

  final _controllerT = Get.find<ThemeController>();
  String?name,address,value,helpGender,payGender,personGender;
  Map<String,dynamic>? help_data;
  TextEditingController name_c =TextEditingController();
  TextEditingController value_c =TextEditingController();
  TextEditingController address_c =TextEditingController();
  String Sign_url='https://project-graduation.000webhostapp.com/api/needer/insert-need-money-help';


  @override
  void initState() {
    super.initState();

  }
  Future <http.StreamedResponse>? Sign_up_Users (Map<String,dynamic>data )async{

    http.StreamedResponse? response;

    try {
      print(data);
      var request=http.MultipartRequest("POST",Uri.parse(  Sign_url) );
      request.headers.addAll(<String,String>{"authToken":token!});
      request.fields.addAll( {
        "type_of_help":data["type_of_help"],
        "specific_address":data["specific_address"],
        "value":data["value"],
        "target_help":data["target_help"],
        "another_user_name":data["another_user_name"],
        "provide_help_way":data["provide_help_way"],
       });
      response= await request.send();
    } on Exception {
      print('error happend');
    }
    return response! ;
  }
  void dispose() {
    name_c.dispose();
    value_c.dispose();
    address_c.dispose();
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
                TopHeader(
                  w: w,
                  h: h,
                  isDark: _controllerT.darkTheme,
                  lang: _controllerL.lang,

                ),
                Text('طلب مساعده ماليه',style: TextStyle(
                    fontSize: w*.07,
                    color: Colors.green[400]
                ),),

                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
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
                          DropdownButtonFormField(
                            validator: (s){return s==null ?'يلزم اختيار النوع':null;},
                            hint: Text('اختر نوع المساعده',style: TextStyle(fontSize:  w*.04),),
                            value: helpGender,
                            onChanged:(String ?i){
                              helpGender=i;
                            } ,
                            items: [DropdownMenuItem(child: Text('ماليه',style: TextStyle(fontSize:  w*.03),),value:'ماليه',),
                              DropdownMenuItem(child: Text('طعام',style: TextStyle(fontSize:  w*.03),),value:'طعام',),
                              DropdownMenuItem(child: Text('ايجار',style: TextStyle(fontSize:  w*.03),),value:'ايجار',),
                              DropdownMenuItem(child: Text('تعليم',style: TextStyle(fontSize:  w*.03),),value:'تعليم',),
                            ],
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(

                            hint: 'الاسم',
                            fontSize: w*.04,
                            controller:name_c ,
                            //callBackValidor:(s){return s==null || s.isEmpty? 'يلزم ادخال الاسم':null; },
                            onSaved: (s){name=name_c.text;},
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTextField(
                            hint: "القيمه",
                            fontSize: w*.04,
                            controller: value_c,
                            callBackValidor:(s){ return s==null || s.isEmpty? 'يلزم ادخال القيمه':null;},
                            onSaved: (s){value=value_c.text;},
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          CustomTextField(
                            hint: "العنوان",
                            fontSize:  w*.04,
                            controller: address_c,
                            callBackValidor:(s){ return s==null || s.isEmpty? 'يلزم ادخال العنوان':null;},
                            onSaved: (s){address=address_c.text;},
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          DropdownButtonFormField(
                            validator: (s){return s==null ?'يلزم اختيار طريقة الدفع':null;},
                            hint: Text('اختر طريقة الدفع',style: TextStyle(fontSize:  w*.04),),
                            value: payGender,
                            onChanged:(String ?i){
                              payGender=i;
                            } ,
                            items: [DropdownMenuItem(child: Text('online',style: TextStyle(fontSize:  w*.03),),value:'online',),
                              DropdownMenuItem(child: Text('cash',style: TextStyle(fontSize:  w*.03),),value:'cash',),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DropdownButtonFormField(
                            validator: (s){return s==null ?'يلزم اختيار النوع':null;},
                            hint: Text('لمن المساعده',style: TextStyle(fontSize:  w*.04),),
                            value: personGender,
                            onChanged:(String ?i){
                              personGender=i;
                            } ,
                            items: [DropdownMenuItem(child: Text('for_me',style: TextStyle(fontSize:  w*.03),),value:'for_me',),
                              DropdownMenuItem(child: Text('for_someone',style: TextStyle(fontSize:  w*.03),),value:'for_someone',),
                            ],
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
                                            'another_user_name': name,
                                            'value':value,
                                            'specific_address': address,
                                            'type_of_help':helpGender ,
                                            'target_help':personGender,
                                            'provide_help_way':payGender

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
