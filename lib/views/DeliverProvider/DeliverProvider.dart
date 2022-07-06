import 'dart:convert';
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
class DeliverProvider extends StatefulWidget {
  final String? authToken;
  const DeliverProvider({Key? key, this.authToken}) : super(key: key);

  @override
  _DeliverProviderState createState() => _DeliverProviderState();
}

class _DeliverProviderState extends State<DeliverProvider> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _controllerL = Get.find<LocalizationController>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _controllerT = Get.find<ThemeController>();
  String?from,to,start_d,end_d;
  Map<String,dynamic>? deliver;
  TextEditingController  from_c=TextEditingController();
  TextEditingController to_c =TextEditingController();
  TextEditingController start_d_c =TextEditingController();
  TextEditingController end_d_c =TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  Future  Find_Deliver (Map<String,dynamic>data )async{
    http.Response? response;
    try {
      print('data is send ${data}');

      var request=http.MultipartRequest("POST",Uri.parse( 'https://project-graduation.000webhostapp.com/api/helper/insert-support-thing-to-be-done' ));
     // var multipartFile=await http.MultipartFile.fromPath('attach',data['attach'].path );
     // print(multipartFile);
     // print(path.basename(data['attach'].path));
      //request.files.add(multipartFile);
      request.headers.addAll(<String,String>{"authToken":token!});
      request.fields.addAll( <String, String>{
        "from_place":data["from_place"],
        "to_place":data["to_place"],
        "date":data["date"],
        "note":data["note"],
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
        Uri.parse('https://project-graduation.000webhostapp.com/api/helper/get-all-things-to-be-done')  ,
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
                          hint: 'من',
                          fontSize: w*.04,
                          controller:from_c ,
                          callBackValidor:(s){return s==null || s.isEmpty? 'يلزم ادخالالمكان':null; },
                          onSaved: (s){from=from_c.text;},
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        CustomTextField(
                          hint: "الى",
                          maxLine: 3,
                          fontSize: w*.04,
                          controller:to_c ,
                          callBackValidor:(s){return s==null || s.isEmpty? 'يلزم ادخال المكان':null; },
                          onSaved: (s){to=to_c.text;},
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          hint: "  التاريخ",
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
                          hint: "ملاحظات",
                          maxLine: 3,
                          fontSize: w*.04,
                          controller:end_d_c ,
                          callBackValidor:(s){return s==null || s.isEmpty? 'يلزم ادخال ملاحظات':null; },
                          onSaved: (s){end_d=end_d_c.text;},
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
                                        'from_place':from,
                                        'to_place':to,
                                        'date':start_d,
                                        'note':end_d,
                                      };
                                      print('found is ${deliver}');
                                      await Find_Deliver (deliver!);
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
              Text('قائمه الاشخاص طالبى الخدمه',style: TextStyle(
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
                              service: snapshot.data![index]["type_of_service"],
                              first_point: snapshot.data![index]["from_place"],
                              end_point: snapshot.data![index]["to_place"],
                              cost: snapshot.data![index]["opposite"],
                              date:snapshot.data![index]["from_date"],
                              end_date: snapshot.data![index]["to_date"],
                             // note:snapshot.data![index]["note"],
                              attach: snapshot.data![index]["attach"],
                              name: snapshot.data![index]["needer"]["name"],
                              phone: snapshot.data![index]["needer"]["phone"],
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
  await http.post(Uri.parse('https://project-graduation.000webhostapp.com/api/helper/apply-to-thing-to-done'),
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

  required String service,first_point,end_point,date,end_date,attach,name,phone,
  required int id,cost
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
                Text(' نوع الخدمه:',style: TextStyle(
                    fontSize: 12,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Text(service,style: TextStyle(
                    fontSize: 20,
                    color: Colors.black
                ),),
              ],
            ),
            Divider(),
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
            Divider(),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text('اقصى تاريخ:',style: TextStyle(
                    fontSize: 12,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Text(end_date,style: TextStyle(
                    fontSize: 20,
                    color: Colors.black
                ),),
              ],
            ),
            Divider(),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(' نقطة البدايه:',style: TextStyle(
                    fontSize: 12,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Text(first_point,style: TextStyle(
                    fontSize: 20,
                    color: Colors.black
                ),),
              ],
            ),
            Divider(),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(' نقطة النهايه:',style: TextStyle(
                    fontSize: 12,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Text(end_point,style: TextStyle(
                    fontSize: 20,
                    color: Colors.black
                ),),
              ],
            ),
            Divider(),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text('المقابل:',style: TextStyle(
                    fontSize: 12,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Text(cost.toString(),style: TextStyle(
                    fontSize: 20,
                    color: Colors.black
                ),),
              ],
            ),
            Divider(),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text('اسم العميل:',style: TextStyle(
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
            Divider(),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text('رقم الفون:',style: TextStyle(
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
            Divider(),
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
          ),]),

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
                        Get.to(()=>commentPost(id:id,type:"support_thing_to_be",));
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