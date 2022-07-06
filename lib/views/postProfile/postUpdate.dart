import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

class postUpdate extends StatefulWidget {
  final int?id;
  const postUpdate({Key? key, this.id}) : super(key: key);
  @override
  State<postUpdate> createState() => _postUpdateState();
}
class _postUpdateState extends State<postUpdate> {
  final _controller = Get.find<ThemeController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _controllerL = Get.find<LocalizationController>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _controllerT = Get.find<ThemeController>();

  final _controller2 = Get.find<LocalizationController>();
  String?content;
  XFile?bigImage;
  TextEditingController content_c =TextEditingController();
  Map <String,dynamic>? response_data ;
  http.Response? response;

  String user_url='https://project-graduation.000webhostapp.com/api/needer/get-one-post';

  Future <Map <String,dynamic>?>  JobOfferV ( )async{
    response = await http.post(
      Uri.parse(user_url) ,
      body: <String,String>
      {
        "post_id":'${widget.id!}'
      },
      headers: {
        "authToken": token!,
      },);
    return jsonDecode(response!.body)["data"];
  }
  void DeleteUserW (String id)async
  {
    await http.post(
        Uri.parse('https://project-graduation.000webhostapp.com/api/needer/delete-post'),
        headers: {
          "authToken": token!,
        },
        body: <String,String>
        {
          "post_id":'${widget.id!}',
        }

    );
  }
  Future <http.StreamedResponse>? UpdateJobW (Map<String,dynamic>data )async{
    http.StreamedResponse? response;
    try {
      print(data);
      var request=http.MultipartRequest("POST",Uri.parse('https://project-graduation.000webhostapp.com/api/needer/update-post') );
      var multipartFile=await http.MultipartFile.fromPath('attach',data['attach'].path );
      print(multipartFile);
      print(path.basename(data['attach'].path));
      request.files.add(multipartFile);
      request.headers.addAll(<String,String>{"authToken":token!});
      request.fields.addAll( <String, String>{
        "content":data["content"],
        "post_id":'${widget.id!}',
      });
      response= await request.send();
    } on Exception {
      print('error happend');
    }
    return response! ;
  }
  @override
  void initState() {
    print(widget.id);
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
          future: JobOfferV(),
          builder: (context,AsyncSnapshot <Map <String ,dynamic>? >snapshot) {
            if(!snapshot.hasData) return Center(child: CircularProgressIndicator());
            else{
              content_c.text=snapshot.data!["content"];
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
                          /* color: _controller.darkTheme
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
                                  hint: ' البوست',
                                  maxLine: 5,
                                  fontSize: 18.0,
                                  controller:content_c ,
                                  onSaved: (s){content=content_c.text;},
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
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20,top: 20,bottom: 20),
                            child: Container(
                              child: CustomButton(
                                text: "حذف",
                                p: EdgeInsets.all(12),
                                onPress: () {

                                  DeleteUserW('${widget.id!}');
                                },
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 20,top: 20,bottom: 20),
                            child: Container(
                              child: CustomButton(
                                text: "تعديل",
                                p: EdgeInsets.all(12),
                                onPress: () {
                                  if(_formKey.currentState!.validate())
                                  {
                                    _formKey.currentState!.save();
                                    setState(() {
                                      UpdateJobW( {
                                        "content":content,
                                        "post_id":'${widget.id!}',
                                      'attach': bigImage != null ? bigImage : '',
                                      });
                                    });}
                                },
                              ),
                            ),
                          ),
                        ],
                      )


                    ],
                  ),
                ),
              );}},
        ));
  }
}
