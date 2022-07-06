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

class ChangeMafcodP extends StatefulWidget {
  final int?id;
  const ChangeMafcodP({Key? key, this.id}) : super(key: key);
  @override
  State<ChangeMafcodP> createState() => _ChangeMafcodPState();
}
class _ChangeMafcodPState extends State<ChangeMafcodP> {
  final _controller = Get.find<ThemeController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _controllerL = Get.find<LocalizationController>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _controllerT = Get.find<ThemeController>();

  final _controller2 = Get.find<LocalizationController>();
  String?type,date,position,desc,color1,color2,brand,category;
  XFile? bigImage;
  TextEditingController type_c =TextEditingController();
  TextEditingController date_c =TextEditingController();
  TextEditingController position_c =TextEditingController();
  TextEditingController desc_c =TextEditingController();
  TextEditingController color1_c =TextEditingController();
  TextEditingController color2_c =TextEditingController();
  TextEditingController brand_c =TextEditingController();
  TextEditingController category_c =TextEditingController();

  Map <String,dynamic>? response_data ;
  http.Response? response;

  String user_url='https://project-graduation.000webhostapp.com/api/helper/get-one-found';

  Future <Map <String,dynamic>?>  JobOfferV ( )async{
    response = await http.post(
      Uri.parse(user_url) ,
      body: <String,String>
      {
        "found_id":'${widget.id!}'
      },
      headers: {
        "authToken": token!,
      },);
    return jsonDecode(response!.body)["data"];
  }
  void DeleteLostW (String id)async
  {
    await http.post(
        Uri.parse('https://project-graduation.000webhostapp.com/api/helper/delete-found'),
        headers: {
          "authToken": token!,
        },
        body: <String,String>
        {
          "found_id":'${widget.id!}',
        }

    );
  }
  Future <http.StreamedResponse>? UpdateLostW (Map<String,dynamic>data )async{
    http.StreamedResponse? response;
    try {
      print(data);
      var request=http.MultipartRequest("POST",Uri.parse('https://project-graduation.000webhostapp.com/api/helper/update-found') );
      var multipartFile=await http.MultipartFile.fromPath('attach',data['attach'].path );
      print(multipartFile);
      print(path.basename(data['attach'].path));
      request.files.add(multipartFile);
      request.headers.addAll(<String,String>{"authToken":token!});
      request.fields.addAll( <String, String>{
        "type":data["type"],
        "found_date":data["found_date"],
        "found_place":data["found_place"],
        "description":data["description"],
        "first_color":data["first_color"],
        "second_color":data["second_color"],
        "brand":data["brand"],
        "category":data["category"],
        "found_id":'${widget.id!}',
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
              type_c.text=snapshot.data!["type"];
              date_c.text=snapshot.data!["found_date"];
              position_c.text=snapshot.data!["found_place"];
              desc_c.text=snapshot.data!["description"];
              color1_c.text=snapshot.data!["first_color"];
              color2_c.text=snapshot.data!["second_color"];
              brand_c.text=snapshot.data!["brand"];
              category_c.text=snapshot.data!["category"];
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
                                  hint: 'نوع الخدمه',
                                  fontSize: 18.0,
                                  controller:type_c ,
                                  onSaved: (s){type=type_c.text;},
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                CustomTextField(
                                  hint: ' التاريخ ',
                                  fontSize: 18.0,
                                  controller:date_c ,
                                  onSaved: (s){date=date_c.text;},

                                ),

                                SizedBox(
                                  height: 7,
                                ),

                                CustomTextField(
                                  hint: 'المكان ',
                                  fontSize: 18.0,
                                  controller: position_c ,
                                  onSaved: (s){position= position_c.text;},

                                ),
                                CustomTextField(
                                  hint: 'الوصف',
                                  fontSize: 18.0,
                                  controller:desc_c ,
                                  onSaved: (s){desc=desc_c.text;},
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                CustomTextField(
                                  hint: 'اللون الاول',
                                  fontSize: 18.0,
                                  controller:color1_c ,
                                  onSaved: (s){color1=color1_c.text;},
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                CustomTextField(
                                  hint: 'اللون الثانى',
                                  fontSize: 18.0,
                                  controller:color2_c ,
                                  onSaved: (s){color2=color2_c.text;},
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                CustomTextField(
                                  hint: 'الماركه',
                                  fontSize: 18.0,
                                  controller:brand_c ,
                                  onSaved: (s){brand=brand_c.text;},
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                CustomTextField(
                                  hint: 'الفئه',
                                  fontSize: 18.0,
                                  controller:category_c ,
                                  onSaved: (s){category=category_c.text;},
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

                                  DeleteLostW('${widget.id!}');
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
                                      UpdateLostW( {
                                        "type":type,
                                        "found_date":date,
                                        "found_place":position ,
                                        "description":desc,
                                        "first_color":color1 ,
                                        "second_color":color2 ,
                                        "brand":brand ,
                                        "category":category ,
                                        "found_id":'${widget.id!}',
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
