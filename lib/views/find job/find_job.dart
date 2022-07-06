import 'dart:convert';
import 'dart:io';
import 'package:chat_app/views/comments/commentPosts.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_app/views/login/login_view.dart';
import 'package:http/http.dart'as http;
import 'package:chat_app/controllers/localization_controller.dart';
import 'package:chat_app/controllers/theme_controller.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:chat_app/views/widgets/app_drawer.dart';
import 'package:chat_app/views/widgets/custom_button.dart';
import 'package:chat_app/views/widgets/custom_text_field.dart';
import 'package:chat_app/views/widgets/top_header.dart';
import 'package:image_picker/image_picker.dart';
class FindJob extends StatefulWidget {
  final String? authToken;
  const FindJob({Key? key, this.authToken}) : super(key: key);

  @override
  _FindJobState createState() => _FindJobState();
}

class _FindJobState extends State<FindJob> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _controllerL = Get.find<LocalizationController>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _controllerT = Get.find<ThemeController>();
  String?qualification,skills,summary,certificate;
  XFile? certificate2;
  Map<String,dynamic>? find_job;
  TextEditingController qualification_c =TextEditingController();
  TextEditingController skills_c =TextEditingController();
  TextEditingController summary_c =TextEditingController();
  TextEditingController certificate_c =TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  Future  Find_Job (Map<String,dynamic>data )async{
    http.Response? response;
    try {
      print('data is send ${data}');

      var request=http.MultipartRequest("POST",Uri.parse( 'https://project-graduation.000webhostapp.com/api/needer/create-need-jop-post' ));
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
      });
      await request.send();


    } on Exception catch (e) {
      print('error happend');
    }
    print('json data is ${jsonDecode(response!.body)}');
  }

  Stream<List>dataStream()
  {
    return Stream.periodic(Duration(milliseconds: 100)).asyncMap((event){ return fetchLostData();});
  }
//return jobs
  Future<List> fetchLostData() async {
    var response = await http.get(
        Uri.parse('https://project-graduation.000webhostapp.com/api/needer/get-provide-jobs')  ,
        headers: {
          "authToken":token!,
        });
    return jsonDecode(response.body)["data"];
  }


  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      drawer: MyDrawer(),

      body:

      SingleChildScrollView(
        child:Form(
          key:_formKey,
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
              Text('البحث عن وظيفه',style: TextStyle(
                  fontSize: w*.07,
                  color: Colors.green[400]
              ),),

              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, top: 20, right: 10),
                child: Card(
                  elevation: 10,
                  margin: EdgeInsets.all(0),
                  shadowColor: AppConstants.K_Border_COlor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        CustomTextField(
                          //if you want to active en and ar lang
                          // hint: "Full_Name".tr,
                          hint: 'المؤهل',
                          fontSize: w*.04,
                          controller:qualification_c ,
                          callBackValidor:(s){return s==null || s.isEmpty? 'يلزم ادخال المؤهل':null; },
                          onSaved: (s){qualification=qualification_c.text;},
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        CustomTextField(
                          hint: "مهاراتك",
                          maxLine: 3,
                          fontSize: w*.04,
                          controller:skills_c ,
                          callBackValidor:(s){return s==null || s.isEmpty? 'يلزم ادخال مهاراتك':null; },
                          onSaved: (s){skills=skills_c.text;},
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          hint: "نبذه عنك",
                          maxLine: 3,
                          fontSize: w*.04,
                          controller:summary_c ,
                          callBackValidor:(s){return s==null || s.isEmpty? 'يلزم ادخال نبذه عنك':null; },
                          onSaved: (s){summary=summary_c.text;},
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          hint: "شهاداتك",
                          maxLine: 3,
                          fontSize: w*.04,
                          controller:certificate_c ,
                          callBackValidor:(s){return s==null || s.isEmpty? 'يلزم ادخال نبذه عنك':null; },
                          onSaved: (s){certificate=certificate_c.text;},
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        Text('اضف شهاده',style: TextStyle(
                            fontSize: w*.05,
                            color: Colors.green[400]
                        ),),
                        SizedBox(
                          height: 28,
                        ),
                        GestureDetector(
                          onTap: () async{
                            final i = await ImagePicker().pickImage(source:ImageSource.gallery) ;
                            setState((){
                              if(i!=null)
                                certificate2= i ;
                              print('image picked $certificate2');
                            });
                          },
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            child: (certificate2==null? SizedBox():Image.file(File(certificate2!.path),fit: BoxFit.fill, )),
                            height: MediaQuery.of(context).size.height*0.2,
                            width: MediaQuery.of(context).size.height*0.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: AppConstants.K_GRADIENT_COLOR,
                            ),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20,top: 20,bottom: 20),
                              child: Container(
                                //height: h*.05,
                                width: w*.30,
                                child: CustomButton(
                                  text: "ارسال",
                                  p: EdgeInsets.all(12),
                                  onPress: () async{
                                    if(_formKey.currentState!.validate())
                                    {
                                      _formKey.currentState!.save();
                                      find_job={
                                        'qualification':qualification,
                                        'skills':skills,
                                        'Summary_about_you':summary,
                                        'certificates':certificate,
                                         'attach':certificate2!=null?certificate2:'',
                                      };
                                      print('found is ${find_job}');
                                      await Find_Job  (find_job!);
                                    }},
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
              Text('قائمه الوظائف المتاحه',style: TextStyle(
                  fontSize: w*.05,
                  color: Colors.green[400]
              ),),

              SizedBox(
                height: 30,

              ),

              Padding(
                padding: const EdgeInsets.only(left: 1,right: 1,bottom: 20),
                child: StreamBuilder(
                    stream: dataStream(),
                    builder: (context,AsyncSnapshot<List> snapshot) {
                      if (snapshot.hasData)
                        return snapshot.data!.isEmpty ||snapshot.data==null?Center(child: Text('لا يوجد وظائف متاحه حاليا'),):ListView.builder(
                          shrinkWrap: true,
                          reverse: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return jobList(
                              education :snapshot.data![index]["required_qualification"],
                              skills:snapshot.data![index]["required_skills"],
                              cirtific:snapshot.data![index]["required_certificates"],
                              attach: snapshot.data![index]["attach"],
                              id: snapshot.data![index]["id"],
                            );

                          },
                          itemCount: snapshot.data!.length,
                        );
                      else return Center(child: CircularProgressIndicator(),);
                    }
                ),
              ),
            ],

          ),
        ),
      ),
    );

  }
}
void ProvidedJob (String id)async
{
  await http.post(Uri.parse('https://project-graduation.000webhostapp.com/api/needer/apply-to-provide-job'),
      headers: {
        "authToken": token!,
      },
      body: <String,String>
      {
        "job_id":id,
      }

  );
}




Widget jobList({

  required String education,skills,cirtific,attach,
  required int id,
}){
  return   Padding(
    padding: EdgeInsets.only(left: 20, top: 20, right: 5),
    child: Card(
      color: Colors.white,
      elevation: 10,
      margin: EdgeInsets.all(0),
      shadowColor: AppConstants.K_Border_COlor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            Row(
              children: [
                Text('مستوى التعليم:',style: TextStyle(
                    fontSize: 12,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(education,style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                  ),),
                ),
              ],
            ),

            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(' المهارات المظلوبه:',style: TextStyle(
                    fontSize: 12,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(skills,style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                  ),),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(' الشهادات المطلوبه:',style: TextStyle(
                    fontSize: 12,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(cirtific,style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                  ),),
                ) ,
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Divider(),
            Divider(),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child:attach!=''?Image.network(attach):Image.asset('assets/images/icon.jpeg'),
                  ),
                ),


              ],
            ),

            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20,top: 20,bottom: 20),
                  child: Container(
                    child: CustomButton(
                      text: " تعليق",
                      p: EdgeInsets.all(12),
                      onPress: () {
                        Get.to(()=>commentPost(id:id,type:"need_job",));
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,top: 20,bottom: 20),
                  child: Container(
                    //margin: EdgeInsets.symmetric(horizontal: w * 0.2),
                    child: CustomButton(
                      text: "التقديم",
                      p: EdgeInsets.all(12),
                      onPress: () {
                        ProvidedJob(id.toString());

                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,top: 20,bottom: 20),
                  child: Container(
                    child: CustomButton(
                      text: "محادثه",
                      p: EdgeInsets.all(12),
                      onPress: () {},
                    ),
                  ),
                ),
              ],
            )

          ],
        ),
      ),
    ),
  );
}