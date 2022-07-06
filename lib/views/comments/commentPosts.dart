import 'dart:convert';

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
import '../widgets/app_drawer.dart';
class commentPost extends StatefulWidget {
  final String? authToken;
  final int?id;
  final String?type;
  const commentPost({Key? key, this.authToken, this.id, this.type}) : super(key: key);

  @override
  _commentPostState createState() => _commentPostState();
}

class _commentPostState extends State<commentPost> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _controllerL = Get.find<LocalizationController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _controllerT = Get.find<ThemeController>();
  String?name;
  Map<String,dynamic>? help_data;
  TextEditingController name_c =TextEditingController();
  String Sign_url='https://project-graduation.000webhostapp.com/api/make-comment';


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
      Uri.parse('https://project-graduation.000webhostapp.com/api/get-comments') ,
      headers: {
        "authToken":token!,
      },
      body: <String,String>{
        "post_id":'${widget.id!}',
        "post_type":'${widget.type!}',
      }
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
        "post_id":'${widget.id!}',
        "comment":data["comment"],
        "post_type":'${widget.type!}',
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
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
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

                      Text('التعليقات ',style: TextStyle(
                          fontSize: w*.05,
                          color: Colors.green[400]
                      ),),
                      Padding(
                        padding: const EdgeInsets.only(left: 1,right: 1,bottom: 20),
                        child: StreamBuilder(
                            stream: dataStream(),
                            builder: (context,AsyncSnapshot<List> snapshot) {
                              if (snapshot.hasData)
                                return snapshot.data!.isEmpty ||snapshot.data==null?Center(child: Text('لا يوجد تعليقات '),):ListView.builder(
                                  shrinkWrap: true,
                                  reverse: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {
                                    //هعدلها ب api
                                    return jobList(
                                      post:snapshot.data![index]["comment"],
                                      name:snapshot.data![index]["user"]["name"],
                                      attach:snapshot.data![index]["user"]["photo"],
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
            ),
            SizedBox(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: CustomTextField(
                        hint: 'اكتب تعليق.......',
                        fontSize: w*.04,
                        controller:name_c ,
                        callBackValidor:(s){return s==null || s.isEmpty? 'يلزم كتابة تعليق':null; },
                        onSaved: (s){name=name_c.text;},
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomButton(
                           icon: Icon(Icons.send),
                            p: EdgeInsets.all(12),
                            onPress: ()  async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                help_data = {
                                  'comment': name_c.text,
                                };
                                await Sign_up_Users(help_data!);

                              }
                            }
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }
}
Widget jobList({

  required String name,attach,post,

}){
  return Card(
    color: Colors.white,
    elevation: 0,
    margin: EdgeInsets.all(0),
    shadowColor: AppConstants.K_Border_COlor,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30)),
    child: Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             CircleAvatar(
               backgroundImage:attach!=""?NetworkImage(attach):NetworkImage('assets/images/icon.jpeg'),
             ),
              SizedBox(width: 10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,style: TextStyle(
                      fontSize: 15,
                      color: Colors.black
                  ),),
                  SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(color: Colors.grey,borderRadius:BorderRadius.circular(25)),
                    padding: const EdgeInsets.all(10),
                    child: Text(post,style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),),
                  ),
                ],
              ),

            ],
          ),

   ] ),
  ),
  );
}