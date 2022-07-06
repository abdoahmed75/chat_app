import 'dart:convert';
import 'dart:io';
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

import '../Changelost/Changelost.dart';
class Lost extends StatefulWidget {
  final String? authToken;
  const Lost({Key? key, this.authToken}) : super(key: key);

  @override
  _LostState createState() => _LostState();
}

class _LostState extends State<Lost> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _controllerL = Get.find<LocalizationController>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _controllerT = Get.find<ThemeController>();
  String?type,date,position,desc,brand,color1,color2,category;
  XFile? bigImage;
  Map<String,dynamic>? lost_data;
  TextEditingController date_c =TextEditingController();
  TextEditingController position_c =TextEditingController();
  TextEditingController desc_c =TextEditingController();
  TextEditingController brand_c =TextEditingController();

  @override
  void initState() {
    super.initState();

  }

  Future  Lost_send (Map<String,dynamic>data )async{
    http.Response? response;
    try {
      print('data is send ${data}');

      var request=http.MultipartRequest("POST",Uri.parse( 'https://project-graduation.000webhostapp.com/api/needer/make-lost' ));
      var multipartFile=await http.MultipartFile.fromPath('attach',data['attach'].path );
      print(multipartFile);
      print(path.basename(data['attach'].path));
      request.files.add(multipartFile);
      request.headers.addAll(<String,String>{"authToken":token!});
      request.fields.addAll( <String, String>{
        "type":data["type"],
        "expected_lost_date":data["expected_lost_date"],
        "expected_lost_place":data["expected_lost_place"],
        "description":data["description"],
        "first_color":data["first_color"],
        "second_color":data["second_color"],
        "brand":data["brand"],
        "category":data["category"],
      });
      await request.send();

    } on Exception {
      print('error happend');
    }
    print('json data is ${jsonDecode(response!.body)}');
  }
  Stream<List>dataStream()
  {
    return Stream.periodic(Duration(milliseconds: 100)).asyncMap((event){ return fetchLostData();});
  }

  Future<List> fetchLostData() async {
    var response = await http.post(
        Uri.parse('https://project-graduation.000webhostapp.com/api/get-lostes')  ,
        headers: {
          "authToken":token!,
        },
        body:<String, String>{

          "personal": "1" ,
        }
        );
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
                  Text('اعرض تفاصيل ما فقدت',style: TextStyle(
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
                            DropdownButtonFormField(
                              validator: (s){return s==null ?'يلزم اختيار النوع':null;},
                              hint: Text('اختر نوع المفقود',style: TextStyle(fontSize:  w*.04),),
                              value: type,
                              onChanged:(String ?i){
                                type=i;
                              } ,
                              items: [DropdownMenuItem(child: Text('اموال',style: TextStyle(fontSize:  w*.03),),value:'اموال',),
                                DropdownMenuItem(child: Text('مفاتيح',style: TextStyle(fontSize:  w*.03),),value:'مفاتيح',),
                                DropdownMenuItem(child: Text('كتب',style: TextStyle(fontSize:  w*.03),),value:'كتب',),
                                DropdownMenuItem(child: Text('اجهزه كهربيه',style: TextStyle(fontSize:  w*.03),),value:'اجهزه كهربيه',),
                                DropdownMenuItem(child: Text('ادوات منزليه',style: TextStyle(fontSize:  w*.03),),value:'ادوات منزليه',),
                                DropdownMenuItem(child: Text('تحف',style: TextStyle(fontSize:  w*.03),),value:'تحف',),
                                DropdownMenuItem(child: Text('اخرى ',style: TextStyle(fontSize:  w*.03),),value:'اخرى',),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CustomTextField(
                              hint: "تاريخ الفقد",

                              fontSize: w*.04,
                              controller:date_c ,
                              callBackValidor:(s){return s==null || s.isEmpty? 'يلزم ادخال تاريخ الفقد':null; },
                              onSaved: (s){date=date_c.text;},
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CustomTextField(
                              hint: "مكان الفقد",
                              fontSize: w*.04,
                              controller:position_c ,
                              callBackValidor:(s){return s==null || s.isEmpty? 'يلزم ادخال مكان الفقد':null; },
                              onSaved: (s){position=position_c.text;},
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CustomTextField(
                              hint: "الوصف",
                              maxLine: 3,
                              fontSize: w*.04,
                              controller:desc_c ,
                              callBackValidor:(s){return s==null || s.isEmpty? 'يلزم ادخال الوصف':null; },
                              onSaved: (s){desc=desc_c.text;},
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CustomTextField(
                              hint: "اذكر ماركه ما فقدت",
                              fontSize: w*.04,
                              controller:brand_c ,
                              callBackValidor:(s){return s==null || s.isEmpty? 'يلزم ادخال ماركت المفقود':null; },
                              onSaved: (s){brand=brand_c.text;},
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            DropdownButtonFormField(
                              validator: (s){return s==null ?'يلزم اختيار اللون':null;},
                              hint: Text('اختر اللون الاولى',style: TextStyle(fontSize:  w*.04),),
                              value: color1,
                              onChanged:(String ?i){
                                color1=i;
                              } ,
                              items: [DropdownMenuItem(child: Text('ازرق',style: TextStyle(fontSize:  w*.03),),value:'ازرق',),
                                DropdownMenuItem(child: Text('احمر',style: TextStyle(fontSize:  w*.03),),value:'احمر',),
                                DropdownMenuItem(child: Text('اصفر',style: TextStyle(fontSize:  w*.03),),value:'اصفر',),
                                DropdownMenuItem(child: Text('بنفسجى',style: TextStyle(fontSize:  w*.03),),value:'بنفسجى',),
                                DropdownMenuItem(child: Text('اخضر',style: TextStyle(fontSize:  w*.03),),value:'اخضر',),
                                DropdownMenuItem(child: Text('اسود',style: TextStyle(fontSize:  w*.03),),value:'اسود',),
                                DropdownMenuItem(child: Text('اخرى ',style: TextStyle(fontSize:  w*.03),),value:'اخرى',),
                              ],
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            DropdownButtonFormField(
                              validator: (s){return s==null ?'يلزم اختيار اللون':null;},
                              hint: Text('اختر اللون الثانوى',style: TextStyle(fontSize:  w*.04),),
                              value: color2,
                              onChanged:(String ?i){
                                color2=i;
                              } ,
                              items: [DropdownMenuItem(child: Text('ازرق',style: TextStyle(fontSize:  w*.03),),value:'ازرق',),
                                DropdownMenuItem(child: Text('احمر',style: TextStyle(fontSize:  w*.03),),value:'احمر',),
                                DropdownMenuItem(child: Text('اصفر',style: TextStyle(fontSize:  w*.03),),value:'اصفر',),
                                DropdownMenuItem(child: Text('بنفسجى',style: TextStyle(fontSize:  w*.03),),value:'بنفسجى',),
                                DropdownMenuItem(child: Text('اخضر',style: TextStyle(fontSize:  w*.03),),value:'اخضر',),
                                DropdownMenuItem(child: Text('اسود',style: TextStyle(fontSize:  w*.03),),value:'اسود',),
                                DropdownMenuItem(child: Text('اخرى ',style: TextStyle(fontSize:  w*.03),),value:'اخرى',),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DropdownButtonFormField(
                              validator: (s){return s==null ?'يلزم اختيار الفئه':null;},
                              hint: Text('اختر فئةالمفقود ',style: TextStyle(fontSize:  w*.04),),
                              value: category,
                              onChanged:(String ?i){
                                category=i;
                              } ,
                              items: [DropdownMenuItem(child: Text('اموال',style: TextStyle(fontSize:  w*.03),),value:'اموال',),
                                DropdownMenuItem(child: Text('مفاتيح',style: TextStyle(fontSize:  w*.03),),value:'مفاتيح',),
                                DropdownMenuItem(child: Text('كتب',style: TextStyle(fontSize:  w*.03),),value:'كتب',),
                                DropdownMenuItem(child: Text('اجهزه كهربيه',style: TextStyle(fontSize:  w*.03),),value:'اجهزه كهربيه',),
                                DropdownMenuItem(child: Text('ادوات منزليه',style: TextStyle(fontSize:  w*.03),),value:'ادوات منزليه',),
                                DropdownMenuItem(child: Text('تحف',style: TextStyle(fontSize:  w*.03),),value:'تحف',),
                                DropdownMenuItem(child: Text('اخرى ',style: TextStyle(fontSize:  w*.03),),value:'اخرى',),
                              ],
                            ),

                            SizedBox(
                              height: 10,
                            ),
                            Text('اضف صوره المفقود',style: TextStyle(
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

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20,top: 20,bottom: 20),
                                  child: Container(
                                   // height: h*.05,
                                    width: w*.30,
                                    child: CustomButton(
                                      text: "ارسال",
                                      p: EdgeInsets.all(12),
                                      onPress: () async{
                                      if(_formKey.currentState!.validate())
                                      {
                                      _formKey.currentState!.save();
                                      lost_data={
                                      'type':type,
                                      'expected_lost_date':date,
                                      'expected_lost_place':position,
                                      'description':desc,
                                      'brand':brand,
                                      'first_color':color1,
                                      'second_color':color2,
                                      'category':category, 'attach':bigImage!=null?bigImage:'',

                                      //'attach':bigImage!=null? await bigImage!.readAsBytes():'',
                                      };
                                      print('found is ${lost_data}');
                                      await Lost_send  (lost_data!);
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
                  Text('قائمه مفقوداتى',style: TextStyle(
                      fontSize: w*.06,
                      color: Colors.green[400]
                  ),),

                  SizedBox(
                    height: 30,

                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 1,right: 1,bottom: 30),
                    child: StreamBuilder(
                        stream: dataStream(),
                      builder: (context,AsyncSnapshot<List> snapshot) {
                        if (snapshot.hasData)
                          return snapshot.data!.isEmpty ||snapshot.data==null?Center(child: Text('لا يوجد مفقودات حاليا'),):ListView.builder(
                          shrinkWrap: true,
                          reverse: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return mafcodList(
                              type:snapshot.data![index]["type"],
                              date:snapshot.data![index]["expected_lost_date"],
                              street :snapshot.data![index]["expected_lost_place"],
                              detalis:snapshot.data![index]["description"],
                              color1:snapshot.data![index]["first_color"],
                              color2:snapshot.data![index]["second_color"],
                              brand:snapshot.data![index]["brand"],
                              category: snapshot.data![index]["category"],
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
Widget mafcodList({
  required String type,date,street,detalis,color1,color2,brand,category,attach,
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
                Text('  النوع:',style: TextStyle(
                    fontSize: 12,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Text(type,style: TextStyle(
                    fontSize: 20.0,
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
                    fontSize: 20.0,
                    color: Colors.black
                ),),


              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(' الوصف:',style: TextStyle(
                    fontSize: 12,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Text(detalis,style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black
                ),),


              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text('  اللون الاول:',style: TextStyle(
                    fontSize: 12,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Text(color1,style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black
                ),),


              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text('  اللون الثانوى:',style: TextStyle(
                    fontSize: 12,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Text(color2,style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black
                ),),


              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text('  العنوان:',style: TextStyle(
                    fontSize: 12,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Text(street,style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black
                ),),


              ],
            ),

            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text('  الماركه:',style: TextStyle(
                    fontSize: 12,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Text(brand,style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black
                ),),


              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text('  الفئه:',style: TextStyle(
                    fontSize: 12,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Text(category,style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black
                ),),
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
                    //margin: EdgeInsets.symmetric(horizontal: w * 0.2),
                    child: CustomButton(
                      text: "تعديل",
                      p: EdgeInsets.all(12),
                      onPress: () {
                        Get.to(()=>Changelost(id:id));
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