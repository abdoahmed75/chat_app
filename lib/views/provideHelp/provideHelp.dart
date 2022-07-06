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
class provideHelp extends StatefulWidget {
  final String? authToken;
  const provideHelp({Key? key, this.authToken}) : super(key: key);

  @override
  _provideHelpState createState() => _provideHelpState();
}

class _provideHelpState extends State<provideHelp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _controllerL = Get.find<LocalizationController>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _controllerT = Get.find<ThemeController>();
  String?helpGender,payGender;
  Map<String,dynamic>? job_offer;
  @override
  void initState() {
    super.initState();
  }

 /* Future  Job_Offer (Map<String,dynamic>data )async{
    http.Response? response;
    try {
      print('data is send ${data}');

      var request=http.MultipartRequest("POST",Uri.parse( 'https://project-graduation.000webhostapp.com/api/helper/create-provide-jop-post' ));
      request.headers.addAll(<String,String>{"authToken":token!});
      request.fields.addAll( <String, String>{
        "required_qualification":data["required_qualification"],
        "required_skills":data["required_skills"],
        "required_certificates":data["required_certificates"],
      });
      await request.send();

    } on Exception {
      print('error happend');
    }
    print('json data is ${jsonDecode(response!.body)}');
  }*/
  Stream<List>dataStream()
  {
    return Stream.periodic(Duration(milliseconds: 100)).asyncMap((event){ return fetchLostData();});
  }
//return
  Future<List> fetchLostData() async {
    var response = await http.post(
      Uri.parse('https://project-graduation.000webhostapp.com/api/helper/get-all-financial-need') ,
      headers: {
        "authToken":token!,
      },
      body:
      {
        "type_of_help":helpGender,
        "provide_help_way":payGender

      },

    );
    return jsonDecode(response.body)["data"];
  }
  void ProvidHelp (String id)async
  {
    await http.post(
        Uri.parse('https://project-graduation.000webhostapp.com/api/helper/provide-financial-help'),
        headers: {
          "authToken": token!,
        },
        body:<String,String>
        {
          "financial_post_id":id,
        }

    );
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
              Text('تقديم المساعده',style: TextStyle(
                  fontSize: 20,
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
                        DropdownButtonFormField(
                          validator: (s){return s==null ?'يلزم اختيار النوع':null;},
                          hint: Text('اختر نوع المساعده',style: TextStyle(fontSize:  w*.04),),
                          value: helpGender,
                          onChanged:(String ?i){
                            helpGender=i;
                          } ,
                          items: [DropdownMenuItem(child: Text('مساعده ماليه',style: TextStyle(fontSize:  w*.03),),value:'مساعده ماليه',),
                            DropdownMenuItem(child: Text('طعام',style: TextStyle(fontSize:  w*.03),),value:'طعام',),
                            DropdownMenuItem(child: Text('ايجار',style: TextStyle(fontSize:  w*.03),),value:'ايجار',),
                            DropdownMenuItem(child: Text('تبرع بملابس',style: TextStyle(fontSize:  w*.03),),value:'تبرع بملابس',),
                          ],
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        DropdownButtonFormField(
                          validator: (s){return s==null ?'يلزم اختيار طريقة الدفع':null;},
                          hint: Text('اختر طريقة الدفع',style: TextStyle(fontSize:  w*.04),),
                          value: payGender,
                          onChanged:(String ?i){
                            payGender=i;
                          } ,
                          items: [DropdownMenuItem(child: Text('online',style: TextStyle(fontSize:  w*.03),),value:'online',),
                            DropdownMenuItem(child: Text('by_hand',style: TextStyle(fontSize:  w*.03),),value:'by_hand',),
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
                              padding: const EdgeInsets.only(left: 20,top: 20,bottom: 20),
                              child: Container(
                                height: h*.05,
                                width: w*.30,

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
              Text('قائمه طالبى المساعده ',style: TextStyle(
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
                        return snapshot.data!.isEmpty ||snapshot.data==null?Center(child: Text('لا يوجد طالبى مساعده حاليا '),):ListView.builder(
                          shrinkWrap: true,
                          reverse: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            //هعدلها ب api
                            return jobList(
                              type:snapshot.data![index]["type_of_help"],
                              address :snapshot.data![index]["specific_address"],
                              value:snapshot.data![index]["value"],
                              person:snapshot.data![index]["target_help"],
                              pay:snapshot.data![index]["provide_help_way"],
                              name:snapshot.data![index]["another_user_name"],
                              id:snapshot.data![index]["id"],
                              attach: snapshot.data![index]["attach"],
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






Widget jobList({
  required String type,address,person,pay,name,attach,
required int id,value,
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
                Text('نوع المساعده :',style: TextStyle(
                    fontSize: 12,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(type,style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                  ),),
                ),
              ],
            ),
            Divider(),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text('العنوان:',style: TextStyle(
                    fontSize: 12,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(address,style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                  ),),
                ),
              ],
            ),
            Divider(),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(' القيمه :',style: TextStyle(
                    fontSize: 12,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(value.toString(),style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                  ),),
                ),
              ],
            ),
            Divider(),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(' لمن المساعده :',style: TextStyle(
                    fontSize: 12,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(person,style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                  ),),
                ),
              ],
            ),
            Divider(),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(' طريقة الدفع :',style: TextStyle(
                    fontSize: 12,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(pay,style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                  ),),
                ),
              ],
            ),
            Divider(),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(' الاسم :',style: TextStyle(
                    fontSize: 12,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(name,style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                  ),),
                ),
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
                      text: "help",
                      p: EdgeInsets.all(12),
                      onPress: () {
                        ProvidHelp(id.toString());
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,top: 20,bottom: 20),
                  child: Container(
                    child: CustomButton(
                      text: " تعليق",
                      p: EdgeInsets.all(12),
                      onPress: () {
                        Get.to(()=>commentPost(id:id,type:"request_finincial",));
                      },
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
}}