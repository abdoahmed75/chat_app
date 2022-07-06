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

class changeNeed extends StatefulWidget {
  final int?id;
  const changeNeed({Key? key, this.id}) : super(key: key);
  @override
  State<changeNeed> createState() => _changeNeedState();
}
class _changeNeedState extends State<changeNeed> {
  final _controller = Get.find<ThemeController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _controllerL = Get.find<LocalizationController>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _controllerT = Get.find<ThemeController>();

  final _controller2 = Get.find<LocalizationController>();
  String?type,address,pay,name,person;
  String?value;
  XFile?bigImage;
  TextEditingController type_c =TextEditingController();
  TextEditingController address_c =TextEditingController();
  TextEditingController value_c =TextEditingController();
  TextEditingController pay_c =TextEditingController();
  TextEditingController name_c =TextEditingController();
   TextEditingController person_c =TextEditingController();

  Map <String,dynamic>? response_data ;
  http.Response? response;

  String user_url='https://project-graduation.000webhostapp.com/api/needer/get-one-need-money-post';

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
  void DeleteJobW (String id)async
  {
    await http.post(
        Uri.parse('https://project-graduation.000webhostapp.com/api/needer/delete-need-money-post'),
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
      var request=http.MultipartRequest("POST",Uri.parse('https://project-graduation.000webhostapp.com/api/needer/update-need-money-post') );
      var multipartFile=await http.MultipartFile.fromPath('attach',data['attach'].path );
      print(multipartFile);
      print(path.basename(data['attach'].path));
      request.files.add(multipartFile);
      request.headers.addAll(<String,String>{"authToken":token!});
      request.fields.addAll( <String, String>{
        "type_of_help":data["type_of_help"],
        "specific_address":data["specific_address"],
        "value":data["value"],
        "target_help":data["target_help"],
        "another_user_name":data["another_user_name"],
        "provide_help_way":data["provide_help_way"],
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
              type_c.text=snapshot.data!["type_of_help"];
              address_c.text=snapshot.data!["specific_address"];
              value_c.text=snapshot.data!["value"].toString();
               person_c.text=snapshot.data!["target_help"];
              name_c.text=snapshot.data!["another_user_name"];
              pay_c.text=snapshot.data!["provide_help_way"];
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
                                  hint: 'نوع المساعده',
                                  fontSize: 18.0,
                                  controller:type_c ,
                                  onSaved: (s){type=type_c.text;},
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                CustomTextField(
                                  hint: 'القيمه ',
                                  fontSize: 18.0,
                                  controller:value_c ,
                                  onSaved: (s){value=value_c.text;},

                                ),

                                SizedBox(
                                  height: 7,
                                ),

                                CustomTextField(
                                  hint: 'الاسم',
                                  fontSize: 18.0,
                                  controller: name_c ,
                                  onSaved: (s){name= name_c.text;},

                                ),
                                  CustomTextField(
                                  hint: 'العنوان',
                                  fontSize: 18.0,
                                  controller:address_c ,
                                  onSaved: (s){address=address_c.text;},
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                CustomTextField(
                                  hint: 'لمن المساعده',
                                  fontSize: 18.0,
                                  controller:person_c ,
                                  onSaved: (s){person=person_c.text;},
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                CustomTextField(
                                  hint: 'طريقة الدفع',
                                  fontSize: 18.0,
                                  controller:pay_c ,
                                  onSaved: (s){pay=pay_c.text;},
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

                                  DeleteJobW('${widget.id!}');
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
                                        "type_of_help":type,
                                        "specific_address":address,
                                        "value":value.toString() ,
                                        "target_help":person ,
                                        "another_user_name":name ,
                                        "provide_help_way":pay ,
                                        'attach': bigImage != null ? bigImage : '',
                                        "post_id":'${widget.id!}'
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
