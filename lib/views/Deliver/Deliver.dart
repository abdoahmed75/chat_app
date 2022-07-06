import 'dart:convert';
import 'dart:io';
import 'package:chat_app/views/comments/commentPosts.dart';
import 'package:image_picker/image_picker.dart';
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
class Deliver extends StatefulWidget {
  final String? authToken;
  const Deliver({Key? key, this.authToken}) : super(key: key);

  @override
  _DeliverState createState() => _DeliverState();
}

class _DeliverState extends State<Deliver> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _controllerL = Get.find<LocalizationController>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _controllerT = Get.find<ThemeController>();
  String?service,cost,start_d,end_d,first_point,end_point;
  XFile?bigImage;
  Map<String,dynamic>? deliver;
  TextEditingController  service_c=TextEditingController();
  TextEditingController cost_c =TextEditingController();
  TextEditingController start_d_c =TextEditingController();
  TextEditingController end_d_c =TextEditingController();
  TextEditingController first_point_c =TextEditingController();
  TextEditingController end_point_c =TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  Future  Find_Deliver (Map<String,dynamic>data )async{
    http.Response? response;
    try {
      print('data is send ${data}');

      var request=http.MultipartRequest("POST",Uri.parse( 'https://project-graduation.000webhostapp.com/api/needer/insert-thing-to-be-done' ));
      var multipartFile=await http.MultipartFile.fromPath('attach',data['attach'].path );
      print(multipartFile);
      print(path.basename(data['attach'].path));
     request.files.add(multipartFile);
      request.headers.addAll(<String,String>{"authToken":token!});
      request.fields.addAll( <String, String>{
        "type_of_service":data["type_of_service"],
        "from_place":data["from_place"],
        "to_place":data["to_place"],
        "opposite":data["opposite"],
        "from_date":data["from_date"],
        "to_date":data["to_date"],
      });
      await request.send();


    } on Exception catch (e) {
      print('error happend');
    }
   // print('json data is ${jsonDecode(response!.body)}');
  }

  Stream<List>dataStream()
  {
    return Stream.periodic(Duration(milliseconds: 100)).asyncMap((event){ return fetchLostData();});
  }
//return jobs
  Future<List> fetchLostData() async {
    var response = await http.get(
        Uri.parse('https://project-graduation.000webhostapp.com/api/needer/get-all-supports-to-be-done')  ,
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
              Text('توصيل',style: TextStyle(
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
                          hint: 'نوع الخدمه',
                          fontSize: w*.04,
                          controller:service_c ,
                          callBackValidor:(s){return s==null || s.isEmpty? 'يلزم ادخال نوع الخدمه':null; },
                          onSaved: (s){service=service_c.text;},
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        CustomTextField(
                          hint: "المقابل",
                          maxLine: 3,
                          fontSize: w*.04,
                          controller:cost_c ,
                          callBackValidor:(s){return s==null || s.isEmpty? 'يلزم ادخال المقابل':null; },
                          onSaved: (s){cost=cost_c.text;},
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          hint: " من تاريخ",
                          maxLine: 3,
                          fontSize: w*.04,
                          controller:start_d_c ,
                          callBackValidor:(s){return s==null || s.isEmpty? 'يلزم ادخال التاريخ':null; },
                          onSaved: (s){start_d=start_d_c.text;},
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          hint: "اقصى تاريخ",
                          maxLine: 3,
                          fontSize: w*.04,
                          controller:end_d_c ,
                          callBackValidor:(s){return s==null || s.isEmpty? 'يلزم ادخال التاريخ':null; },
                          onSaved: (s){end_d=end_d_c.text;},
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          hint: "نقطة البدايه",
                          maxLine: 3,
                          fontSize: w*.04,
                          controller:first_point_c ,
                          callBackValidor:(s){return s==null || s.isEmpty? 'يلزم ادخال نقطة البدايه':null; },
                          onSaved: (s){first_point=first_point_c.text;},
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          hint: "نقطة النهايه",
                          maxLine: 3,
                          fontSize: w*.04,
                          controller:end_point_c ,
                          callBackValidor:(s){return s==null || s.isEmpty? 'يلزم ادخال نقطة النهايه':null; },
                          onSaved: (s){end_point=end_point_c.text;},
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('اضافة صوره',style: TextStyle(
                            fontSize: w*.05,
                            color: Colors.green[400]
                        ),),
                        SizedBox(
                          height: 20,
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



                        SizedBox(
                          height: 5,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20,top: 20,bottom: 20),
                              child: Container(
                                //height: h*.04,
                                width: w*.30,
                                child: CustomButton(
                                  text: "ارسال",
                                  p: EdgeInsets.all(12),
                                  onPress: () async{
                                    if(_formKey.currentState!.validate())
                                    {
                                      _formKey.currentState!.save();
                                      deliver={
                                        'type_of_service':service,
                                        'from_place':first_point,
                                        'to_place':end_point,
                                        'opposite':cost,
                                        'from_date':start_d,
                                        'to_date':end_d,
                                        'attach':bigImage!=null?bigImage:'',

                                      };
                                      print('found is ${deliver}');
                                      await Find_Deliver  (deliver!);
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
              Text('قائمه الاشخاص المتاحين',style: TextStyle(
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
                              id: snapshot.data![index]["id"],
                              from :snapshot.data![index]["from_place"],
                              to:snapshot.data![index]["to_place"],
                              date:snapshot.data![index]["date"],
                              note: snapshot.data![index]["note"],
                              name: snapshot.data![index]["helper"]["name"],
                              phone: snapshot.data![index]["helper"]["phone"],
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
void ProvidedDeliver (String id)async
{
  await http.post(Uri.parse('https://project-graduation.000webhostapp.com/api/needer/apply-to-support-thing'),
      headers: {
        "authToken": token!,
      },
      body: <String,String>
      {
        "post_id":id,
      }
  );
}
Widget jobList({

  required String from,to,date,note,name,phone,
  required int id,
}){
  return   Padding(
    padding: EdgeInsets.only(left: 20, top: 20, right: 10),
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
                Text('من:',style: TextStyle(
                    fontSize: 12,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Text(from,style: TextStyle(
                    fontSize: 20,
                    color: Colors.black
                ),),
              ],
            ),

            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(' الى:',style: TextStyle(
                    fontSize: 12,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Text(to,style: TextStyle(
                    fontSize: 20,
                    color: Colors.black
                ),),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text('ملاحظه:',style: TextStyle(
                    fontSize: 12,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Text(note,style: TextStyle(
                    fontSize: 20,
                    color: Colors.black
                ),),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(' التاريخ:',style: TextStyle(
                    fontSize: 12,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Text(date,style: TextStyle(
                    fontSize: 20,
                    color: Colors.black
                ),),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(' اسم العميل:',style: TextStyle(
                    fontSize: 12,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Text(name,style: TextStyle(
                    fontSize: 20,
                    color: Colors.black
                ),),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(' رقم الفون:',style: TextStyle(
                    fontSize: 12,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Text(phone,style: TextStyle(
                    fontSize: 20,
                    color: Colors.black
                ),),
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
                        Get.to(()=>commentPost(id:id,type:"thing_to_be_done",));
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
                        ProvidedDeliver(id.toString());

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