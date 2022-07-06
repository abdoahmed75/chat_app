import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_app/views/comments/commentPosts.dart';
import 'package:chat_app/views/login/login_view.dart';
import 'package:http/http.dart'as http;
import 'package:chat_app/controllers/localization_controller.dart';
import 'package:chat_app/controllers/theme_controller.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:chat_app/views/widgets/custom_button.dart';
import 'package:chat_app/views/widgets/custom_text_field.dart';
import 'package:chat_app/views/widgets/top_header.dart';

import '../widgets/app_drawer.dart';
class HomeView extends StatefulWidget {
  final String? authToken;
  const HomeView({Key? key, this.authToken}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _controllerL = Get.find<LocalizationController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _controllerT = Get.find<ThemeController>();
  String?name,helpGender,helptype;
  Map<String,dynamic>? help_data;
  TextEditingController name_c =TextEditingController();
  String Sign_url='https://project-graduation.000webhostapp.com/api/needer/insert-post';


  @override
  void initState() {
    super.initState();
    print(token);
  }
  Stream<List>dataStream()
  {
    return Stream.periodic(Duration(milliseconds: 100)).asyncMap((event){ return fetchLostData();});
  }
  Future<List> fetchLostData() async {
    var response = await http.post(
      Uri.parse('https://project-graduation.000webhostapp.com/api/needer/filter-posts') ,
      headers: {
        "authToken":token!,
      },
      body: {
        "post_type": helptype,
      },
    );
    return jsonDecode(response.body)["data"];
  }
  Future <http.StreamedResponse>? Sign_up_Users (Map<String,dynamic>data )async{

    http.StreamedResponse? response;

    try {
      print(data);
      var request=http.MultipartRequest("POST",Uri.parse(  Sign_url) );
      request.headers.addAll(<String,String>{"authToken":token!});
      request.fields.addAll( {
        "content":data["content"],
        "post_type":data["post_type"],
      });
      response= await request.send();
    } on Exception {
      print('error happend');
    }
    return response! ;
  }
  void dispose() {
    name_c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    var f = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
        key: _scaffoldKey,
        drawer: MyDrawer(),
        body: SingleChildScrollView(
          child: Form(
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
                Text(' طلب خدمات عامه',style: TextStyle(
                    fontSize: w*.07,
                    color: Colors.green[400]
                ),),

                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.all(0),
                    shadowColor: AppConstants.K_Border_COlor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DropdownButtonFormField(
                            validator: (s){return s==null ?'يلزم اختيار النوع':null;},
                            hint: Text('اختر نوع الخدمه',style: TextStyle(fontSize:  w*.04),),
                            value: helpGender,
                            onChanged:(String ?i){
                              helpGender=i;
                            } ,
                            items: [DropdownMenuItem(child: Text('عامه',style: TextStyle(fontSize:  w*.03),),value:'عامه',),
                              DropdownMenuItem(child: Text('زراعه',style: TextStyle(fontSize:  w*.03),),value:'زراعيه',),
                              DropdownMenuItem(child: Text('هندسيه',style: TextStyle(fontSize:  w*.03),),value:'هندسيه',),
                              DropdownMenuItem(child: Text('طبيه',style: TextStyle(fontSize:  w*.03),),value:'طبيه',),
                            ],
                          ),

                          SizedBox(
                            height: 15,
                          ),
                          CustomTextField(
                            hint: 'اكتب الخدمه المطلوبه.......',
                            maxLine: 8,
                            fontSize: w*.04,
                            controller:name_c ,
                            callBackValidor:(s){return s==null || s.isEmpty? 'يلزم ادخال الخدمه المطلوبه':null; },
                            onSaved: (s){name=name_c.text;},
                          ),

                          SizedBox(
                            height: 8,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10,top: 10,bottom: 20),

                                child:Container(
                                  //height: h*.04,
                                  width: w*.27,
                                  margin: EdgeInsets.symmetric(horizontal: w * 0.3),
                                  child: CustomButton(
                                      text: 'نشر',
                                      p: EdgeInsets.all(12),
                                      onPress: ()  async {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          help_data = {
                                            'content': name,
                                            'post_type':helpGender ,

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
                  height: 5,
                ),

                SizedBox(
                  height: 25,
                ),


                Text('خدمات عامه ',style: TextStyle(
                    fontSize: w*.05,
                    color: Colors.green[400]
                ),),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: DropdownButtonFormField(
                      validator: (s){return s==null ?'يلزم اختيار النوع':null;},
                      hint: Text('اختر نوع الخدمه',style: TextStyle(fontSize:  w*.04),),
                      value: helptype,
                      onChanged:(String ?i){
                        helptype=i;
                      } ,
                      items: [
                        DropdownMenuItem(child: Text('الكل',style: TextStyle(fontSize:  w*.03),),value:'الكل',),
                        DropdownMenuItem(child: Text('عامه',style: TextStyle(fontSize:  w*.03),),value:'عامه',),
                        DropdownMenuItem(child: Text('زراعه',style: TextStyle(fontSize:  w*.03),),value:'زراعيه',),
                        DropdownMenuItem(child: Text('هندسيه',style: TextStyle(fontSize:  w*.03),),value:'هندسيه',),
                        DropdownMenuItem(child: Text('طبيه',style: TextStyle(fontSize:  w*.03),),value:'طبيه',),
                      ],
                    ),

                  ),
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
                                post:snapshot.data![index]["content"],
                                name:snapshot.data![index]["user"]["name"],
                                date:snapshot.data![index]["created_at"],
                                post_type:snapshot.data![index]["post_type"],
                                attach:snapshot.data![index]["user"]["photo"],
                                photo:snapshot.data![index]["attach"],
                                id:snapshot.data![index]["id"],
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
        )
    );
  }
}
Widget jobList({

  required String name,date,post,post_type,attach,photo,
  required int?id,

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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                 Expanded(
                   child: CircleAvatar(
                     backgroundImage:attach!=''?NetworkImage(attach):NetworkImage('https://img.freepik.com/free-vector/hand-painted-watercolor-pastel-sky-background_23-2148902771.jpg?w=2000'),
                ),
                 ),
                Expanded(
                  flex: 3,
                  child: Text(name,style: TextStyle(
                      fontSize: 15,
                      color: Colors.black
                  ),),
                ),
                Expanded(
                  child: SizedBox(
                    width: 45,
                  ),
                ),
                Expanded(
                  child: Text(date,style: TextStyle(
                      fontSize: 10,
                      color: Colors.black54,
                  ),),
                ),

              ],
            ),
            Row(
              children: [

                 SizedBox(
                    width: 60,
              ),

                Expanded(
                  child: Text(post_type,style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54
                  ),),
                ),
              ],
            ),

            Divider(),

            Padding(
              padding: const EdgeInsets.only(bottom:60),
              child: Row(
                children: [

                  Expanded(
                    child: Text(post,style: TextStyle(
                        fontSize: 15,
                        color: Colors.black
                    ),),
                  ),
                ],
              ),
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
                child:photo!=''?Image.network(photo):Image.asset('assets/images/icon.jpeg'),
              ),
            ),
      ]
    ),
            Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10,bottom: 10),
                  child: Container(
                    //margin: EdgeInsets.symmetric(horizontal: w * 0.2),
                    child: CustomButton(
                      text: "تعليق",
                      p: EdgeInsets.all(5),
                      onPress: () {
                        Get.to(()=>commentPost(id:id,type:"post",));
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
}