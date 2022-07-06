import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_app/routes/app_routes.dart';
import 'package:chat_app/views/findjobprofile/likerJob.dart';
import 'package:chat_app/views/login/login_view.dart';
import 'package:chat_app/views/widgets/prof_drawer.dart';
import 'package:http/http.dart'as http;
import 'package:path/path.dart' as path;
import 'package:chat_app/controllers/localization_controller.dart';
import 'package:chat_app/controllers/theme_controller.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:chat_app/views/widgets/custom_button.dart';
import 'package:chat_app/views/widgets/custom_text_field.dart';

import 'package:chat_app/views/widgets/top_header.dart';
import 'package:image_picker/image_picker.dart';

class FindJobP extends StatefulWidget {
  @override
  State<FindJobP> createState() => _FindJobPState();
}
class _FindJobPState extends State<FindJobP> {
  final _controller = Get.find<ThemeController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _controllerL = Get.find<LocalizationController>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _controllerT = Get.find<ThemeController>();

  final _controller2 = Get.find<LocalizationController>();
  String?qualification;
  String?skills;
  String?summary;
  String?certificate;
  XFile?bigImage;
  TextEditingController qualification_c =TextEditingController();
  TextEditingController skills_c =TextEditingController();
  TextEditingController summary_c =TextEditingController();
  TextEditingController certificate_c =TextEditingController();

  Map <String,dynamic>? response_data ;
  http.Response? response;

  String user_url='https://project-graduation.000webhostapp.com/api/needer/get-my-need-job';

  Future <Map <String,dynamic>?>  User_info ( )async{
    response = await http.get(
      Uri.parse(user_url) ,
      headers: {
        "authToken": token!,
      },);
    return jsonDecode(response!.body)["data"];

  }
 void DeleteJob (String id)async
 {
   await http.post(Uri.parse('https://project-graduation.000webhostapp.com/api/needer/delete-need-job'),
     headers: {
       "authToken": token!,
     },
     body: <String,String>
       {
         "job_id":id,
     }

   );
 }
  Future <http.StreamedResponse>? UpdateJob (Map<String,dynamic>data )async{
    http.StreamedResponse? response;
    try {
      print(data);
      var request=http.MultipartRequest("POST",Uri.parse('https://project-graduation.000webhostapp.com/api/needer/update-need-job') );
      var multipartFile=await http.MultipartFile.fromPath('attach',data['attach'].path );
      print(multipartFile);
      print(path.basename(data['attach'].path));
      request.files.add(multipartFile);
      request.headers.addAll(<String,String>{"authToken":token!});
      request.fields.addAll( <String, String>{
        "qualification":data["qualification"],
        "skills":data["skills"],
        "certificates":data["certificates"],
        "Summary_about_you":data["Summary_about_you"],
        "job_id":data["job_id"],
      });
      response= await request.send();
    } on Exception {
      print('error happend');
    }
    return response! ;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    var f = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
        key: _scaffoldKey,
        drawer: ProfDrawer(),

        body: FutureBuilder(
          future: User_info(),
          builder: (context,AsyncSnapshot <Map <String ,dynamic>? >snapshot) {
            if(!snapshot.hasData) return Center(child: CircularProgressIndicator());
            else{
              qualification_c.text=snapshot.data!["qualification"];
              skills_c.text=snapshot.data!["skills"];
              summary_c.text=snapshot.data!["summary_about_you"];
              certificate_c.text=snapshot.data!["certificates"];
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
                        height: h * 0.03,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height*0.2,
                        width: MediaQuery.of(context).size.height*0.2,
                        child: CircleAvatar(

                          radius: 20.0,
                          backgroundImage: NetworkImage('https://st2.depositphotos.com/3837271/7341/i/950/depositphotos_73414473-stock-photo-change-text-sign.jpg'),
                        ),
                      ),

                      SizedBox(
                        height: h * 0.01,
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                        child: Card(
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
                                  hint: 'المؤهل',
                                  fontSize: 18.0,
                                  controller:qualification_c ,
                                  onSaved: (s){qualification=qualification_c.text;},
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                CustomTextField(
                                  hint: 'مهاراتك',
                                  fontSize: 18.0,
                                  controller:skills_c ,
                                  onSaved: (s){skills=skills_c.text;},

                                ),

                                SizedBox(
                                  height: 7,
                                ),
                                CustomTextField(
                                  hint: 'نبذه عنك',
                                  fontSize: 18.0,
                                  controller:summary_c ,
                                  onSaved: (s){summary=summary_c.text;},

                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                CustomTextField(
                                  hint: 'شهاداتك',
                                  fontSize: 18.0,
                                  controller: certificate_c ,
                                  onSaved: (s){certificate= certificate_c.text;},

                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('تغير الصوره',style: TextStyle(
                                    fontSize: w*.05,
                                    color: Colors.green[400]
                                ),),
                                SizedBox(
                                  height: 10,
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
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 35,top: 20,bottom: 20),
                            child: Container(
                              child: CustomButton(
                                text: "متشابه",
                                p: EdgeInsets.all(12),
                                onPress: () {
                                  Get.to(()=>likerJob(id:snapshot.data!["id"]));
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 35,top: 20,bottom: 20),
                            child: Container(
                              child: CustomButton(
                                text: "حذف",
                                p: EdgeInsets.all(12),
                                onPress: () {
                                 DeleteJob(snapshot.data!["id"].toString());
                                },
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 35,top: 20,bottom: 20),
                            child: Container(
                              child: CustomButton(
                                text: "تعديل",
                                p: EdgeInsets.all(12),
                                onPress: () {
                                  if(_formKey.currentState!.validate())
                                  {
                                    _formKey.currentState!.save();
                                   setState(() {
                                     UpdateJob( {
                                       'qualification':qualification,
                                       'skills':skills,
                                       'certificates':certificate,
                                       'Summary_about_you':summary,
                                       'attach': bigImage != null ? bigImage : '',
                                       'job_id':snapshot.data!["id"].toString(),
                                     });
                                   });
                                  }
                                },
                              ),
                            ),
                          ),


                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(left: 20,top: 10,bottom: 20),
                            child: Container(
                              child: CustomButton(
                                text: "تقديماتى",
                                p: EdgeInsets.all(12),
                                onPress: () {
                                  Get.toNamed(Routes.provideJob);
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:20,top: 10,bottom: 20),
                            child: Container(
                              child: CustomButton(
                                  text: "الوظائف المقبول بيها",
                                  p: EdgeInsets.all(12),
                                  onPress: () {
                                    Get.toNamed(Routes.acceptJob);
                                  }
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );}},
           ),);
  }
}
