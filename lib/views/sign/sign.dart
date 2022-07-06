import 'dart:convert';
import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:chat_app/routes/app_routes.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:chat_app/controllers/localization_controller.dart';
import 'package:chat_app/controllers/theme_controller.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:chat_app/views/widgets/custom_button.dart';
import 'package:chat_app/views/widgets/custom_text_field.dart';
import 'package:chat_app/views/widgets/top_header.dart';
import 'package:image_picker/image_picker.dart';
String? token;

class Sign extends StatefulWidget {
  const Sign({Key? key}) : super(key: key);

  @override
  _SignState createState() => _SignState();
}

class _SignState extends State<Sign> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _controllerL = Get.find<LocalizationController>();

  final _controllerT = Get.find<ThemeController>();
  String?name,phone,address,email,password,date,id,job,gender;
  XFile? bigImage;
  Map<String,dynamic>? sign_data;
  TextEditingController name_c =TextEditingController();
  TextEditingController phon_c =TextEditingController();
  TextEditingController address_c =TextEditingController();
  TextEditingController email_c =TextEditingController();
  TextEditingController password_c =TextEditingController();
  TextEditingController date_c =TextEditingController();
  TextEditingController id_c =TextEditingController();
  TextEditingController job_c =TextEditingController();
   String Sign_url='https://project-graduation.000webhostapp.com/api/sign-up';


  @override
  void initState() {
    super.initState();
  }
    Future <http.StreamedResponse>? Sign_up_Users (Map<String,dynamic>data )async{

      http.StreamedResponse? response;

    try {
      print(data);
      var request=http.MultipartRequest("POST",Uri.parse(  Sign_url) );

      var multipartFile=await http.MultipartFile.fromPath('photo',data['photo'].path );
      print(multipartFile);
      print(path.basename(data['photo'].path));
      request.files.add(multipartFile);
      request.fields.addAll( <String, String>{"name":data["name"],
        "phone":data["phone"],
        "main_address":data["main_address"],
        "email":data["email"],
        "password":data["password"],
        "date_of_birth":data["date_of_birth"],
        "id_number":data["id_number"],
        "job":data["job"],
        "gender":data["gender"]});
     response= await request.send();
    } on Exception {
      print('error happend');
    }
    return response! ;
    }
  void dispose() {
    name_c.dispose();
    phon_c.dispose();
    address_c.dispose();
    email_c.dispose();
    password_c.dispose();
    date_c.dispose();
    id_c.dispose();
    job_c.dispose();

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

                Text('انشاء حساب',style: TextStyle(
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
                          CustomTextField(

                            hint: 'الاسم كامل',
                            fontSize: w*.03,
                            controller:name_c ,
                            callBackValidor:(s){return s==null || s.isEmpty? 'يلزم ادخال الاسم':null; },
                            onSaved: (s){name=name_c.text;},
                          ),
                         const SizedBox(
                            height: 5,
                          ),
                          CustomTextField(
                            hint: "التليفون",
                            fontSize: w*.03,
                            controller: phon_c,
                            callBackValidor:(s){ return s==null || s.isEmpty? 'يلزم ادخال الفون':null;},
                            onSaved: (s){phone=phon_c.text;},
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          CustomTextField(
                            hint: "العنوان",
                            fontSize:  w*.03,
                            controller: address_c,
                            callBackValidor:(s){ return s==null || s.isEmpty? 'يلزم ادخال العنوان':null;},
                            onSaved: (s){address=address_c.text;},
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          CustomTextField(
                            hint: "البريد الالكترونى",
                            fontSize:  w*.03,
                            controller: email_c,
                            callBackValidor:(s){return s==null || s.isEmpty? 'يلزم ادخال البريد الالكترونى ':null;},
                            onSaved: (s){email=email_c.text;},
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          CustomTextField(
                            hint: "الرقم السرى",
                            fontSize:  w*.03,
                            isPassword: true,
                            controller: password_c,
                            callBackValidor:(s){return s==null || s.isEmpty? 'يلزم ادخال الرقم السرى':null;},
                            onSaved: (s){password=password_c.text;},
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          CustomTextField(
                            hint: "تاريخ الميلاد",
                            fontSize:  w*.03,
                            controller: date_c,
                            callBackValidor:(s){return s==null || s.isEmpty?'يلزم ادخال تاريخ الميلاد ':null;},
                            onSaved: (s){date=date_c.text;},
                          ),

                          SizedBox(
                            height: 5,
                          ),
                          CustomTextField(
                            hint: "الرقم القومى",
                            fontSize:  w*.03,
                            controller: id_c,
                            callBackValidor:(s){return s==null || s.isEmpty?'يلزم ادخال الرقم القومى':null;},
                            onSaved: (s){id=id_c.text;},
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            hint: "الوظيفه",
                            fontSize:  w*.03,
                            controller: job_c,
                            callBackValidor:(s){return s==null || s.isEmpty?'يلزم ادخال الوظيفه':null;},
                            onSaved: (s){job=job_c.text;},
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DropdownButtonFormField(
                            validator: (s){return s==null ?'يلزم اختيار النوع':null;},
                            hint: Text('اختر النوع',style: TextStyle(fontSize:  w*.03),),
                            value: gender,
                           onChanged:(String ?i){
                             gender=i;
                            } ,
                            items: [DropdownMenuItem(child: Text('ذكر',style: TextStyle(fontSize:  w*.03),),value:'1',),
                              DropdownMenuItem(child: Text('انثى',style: TextStyle(fontSize:  w*.03),),value:'0',),
                            ],
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text('اضف صوره شخصيه ',style: TextStyle(
                                fontSize:  w*.04,
                                color: Colors.green[400]
                            ),),
                          ),
                          SizedBox(
                            height: 28,
                          ),
                          GestureDetector(
                            onTap: () async{
                              final i = await ImagePicker().pickImage(source:ImageSource.gallery) ;
                              setState((){
                                if(i!=null)
                                  bigImage= i ;
                                print('image picked $bigImage');
                              });
                            },
                            child: Center(
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                child: (bigImage==null? SizedBox():Image.file(File(bigImage!.path),fit: BoxFit.fill, )),
                                height: MediaQuery.of(context).size.height*0.2,
                                width: MediaQuery.of(context).size.height*0.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: AppConstants.K_GRADIENT_COLOR,
                                ),
                              ),
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10,top: 20,bottom: 20),

                                  child:Container(
                                   // height: h*.04,
                                    width: w*.27,
                                    margin: EdgeInsets.symmetric(horizontal: w * 0.3),
                                    child: CustomButton(
                                      text: 'تسجيل',
                                      p: EdgeInsets.all(12),
                                      onPress: ()  async {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          sign_data = {
                                            'name': name,
                                            'phone': phone,
                                            'main_address': address,
                                            'email': email,
                                            'password': password,
                                            'date_of_birth': date,
                                            'id_number': id,
                                            'job': job,
                                            'gender': gender,
                                            'photo': bigImage != null ? bigImage : '',

                                          };

                                          var data = await Sign_up_Users(
                                              sign_data!);
                                          print(data!.statusCode);
                                          data.stream.transform(utf8.decoder)
                                              .listen((value) {
                                                print(value);
                                            if (jsonDecode(value)["status"] == true) {
                                              var pref=GetStorage();
                                              pref.write("phone", sign_data!["phone"]);
                                              pref.write("password", sign_data!["password"]);
                                              Get.toNamed(Routes.CONTROL);
                                            }
                                            else {
                                              showDialog(context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Text('خطا'),
                                                      content: Text('حدث خطا اثناء التسجيل يرجى ادخال البياتات صحيحه'),);

                                              });
                                            }
                                          });
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
