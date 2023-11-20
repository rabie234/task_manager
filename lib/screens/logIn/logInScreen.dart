import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:softpro_support/config/global/constants/app_static_data.dart';
import 'package:softpro_support/config/services/server.dart';
import 'package:softpro_support/config/theme/app_theme.dart';
import 'package:softpro_support/screens/base/base_screen.dart';
import 'package:softpro_support/task_notifier.dart';

import '../../config/global/constants/image_routes.dart';
import '../../config/theme/app_colors.dart';




class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool isLoading = false;
     final _formKey = GlobalKey<FormState>();
    final _userName = TextEditingController();
     final _password = TextEditingController();
     final FocusNode UserNodeFocus = FocusNode();
            final FocusNode PasswordNode = FocusNode();
            double marginContainer = 30.h;







  String? _token;
  late Stream<String> _tokenStream;

  void setToken(String? token) {
    print('FCM Token: $token');
    setState(() {
      _token = token;
    });
  }

  Future<String> _getToken()async{
    String? token = 
   await FirebaseMessaging.instance
        .getToken(
            vapidKey:
                'BNK7-W6O7uvopUtekGW4elRKAINXN1tCUrDPcNelNYiCTUQmi6hwAUjZbleaT15VVZ-I8PhEIinTxUC9QGk0XyY');
   print("token is :::::::::::");
print(token);
return token!;
   
  
}


 













          LogIn()async{
         
            setState(() {
              isLoading = true;
            });
             String tokenUpd = await  _getToken();
            var responseLogIn = await ServerService.logIn(_userName.text,_password.text,tokenUpd);
          setState(() {
            isLoading = false;
          });
            print('respons log in page;');
            print(responseLogIn['res']);
            if(responseLogIn['res'] =='success' ){
           
              
                       SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('username', _userName.text);
  prefs.setString('pass', _password.text);
  prefs.setString('token', tokenUpd);
              UserDetail.id = responseLogIn['id_user'];
               UserDetail.name = responseLogIn['name_user'];

               UserDetail.token = tokenUpd;
               if(responseLogIn['isAdmin'] == '0'){
                UserDetail.isAdmin = false;
               }else{
                UserDetail.isAdmin = true;
               }
                 Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BaseScreen( )),  );
            }
                ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
  content: Text(
    responseLogIn['res']=='success'?

    "${responseLogIn['res']} ! Welcome back ${responseLogIn['name_user']}'":"${responseLogIn['res']}",
    style: TextStyle(
      color: Colors.white,
      fontSize: 13.0,
     
    ),
  ),
  backgroundColor:responseLogIn['res']=='success'? AppColors.blueGray:AppColors.primary.withOpacity(0.2),
  behavior: SnackBarBehavior.floating,
  duration: Duration(seconds: 3),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  ),
  action: SnackBarAction(
    label: 'close',

    onPressed: () {
      // Add your logic here
    },
    textColor: Colors.white,
  ),
)
            );
          }
            @override
  void initState() {
    // TODO: implement initState

    super.initState();
     Future.delayed(const Duration(milliseconds: 50), () {
    setState(() {
      marginContainer = 0.h;
    });
     });
  }
   
  @override
  Widget build(BuildContext context) {
    
      ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: 
         PreferredSize(
          
          preferredSize: Size(double.infinity, 60),
          child: Container(
             decoration:  BoxDecoration(
                  color: AppDynamicColorBuilder.getWhiteAndDark2(context),
          borderRadius: BorderRadius.only(
             bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
              child: BackdropFilter(
                 filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
     child: AppBar(

        title: Text("LogIn",style:  theme.textTheme.headlineMedium!
                .copyWith(color: AppDynamicColorBuilder.getGrey900AndWhite(context)),),centerTitle: true,),
              ),),),),
      body:Center(
        child: SingleChildScrollView(
        
      
        
      
              child: Container(
               
                margin: EdgeInsets.all(10),
                  

                 decoration:  BoxDecoration(
                  color: AppDynamicColorBuilder.getWhiteAndDark2(context),
          borderRadius: BorderRadius.only(
             bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30),topLeft: Radius.circular(30),topRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
            child: ClipRRect(
              
                borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
             topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
              child: BackdropFilter(
                 filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                 
                child: Container(
                    padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    
                               const SizedBox(height: 30,),
                      Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                               Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text("User Name :",style: theme.textTheme.labelLarge!.copyWith(
                                         //color: theme.primaryColor,
                                                     color:AppDynamicColorBuilder.getGrey900AndWhite(context),
                                          fontWeight: FontWeight.w600),),
                                           
                   ],
                               ),
                    SizedBox(height: 20,),
                            
                             
                  AnimatedContainer(
                       duration: const Duration(milliseconds: 300),
                  height: 50.h,
                  margin: EdgeInsets.only(top: marginContainer),
                  decoration: BoxDecoration(
                    color: AppDynamicColorBuilder.getDark3AndGrey200(context),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color:
                           AppDynamicColorBuilder.getGrey100AndDark2(context),
                      width: 1,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: _userName,
                   
                     
                      focusNode: UserNodeFocus,
                      style: theme.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppDynamicColorBuilder.getGrey900AndWhite(context)),
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'UserName',
                        hintStyle: theme.textTheme.bodyMedium!.copyWith(
                            color: AppDynamicColorBuilder.getGrey600AndGrey400(context),
                            fontWeight: FontWeight.w500),
                        icon: Icon( Icons.person,
                          color:  AppDynamicColorBuilder.getGrey600AndGrey400(context)
                            
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text("Password :",style: theme.textTheme.labelLarge!.copyWith(
                                         //color: theme.primaryColor,
                                                     color:AppDynamicColorBuilder.getGrey900AndWhite(context),
                                          fontWeight: FontWeight.w600),),
                                           
                   ],
                               ),
                    SizedBox(height: 20,),
                            
                             
                  AnimatedContainer(
                       duration: const Duration(milliseconds: 300),
                         margin: EdgeInsets.only(top: marginContainer),
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: AppDynamicColorBuilder.getDark3AndGrey200(context),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color:
                           AppDynamicColorBuilder.getGrey100AndDark2(context),
                      width: 1,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: _password,
                   
                
                     
                      focusNode: PasswordNode,
                      style: theme.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppDynamicColorBuilder.getGrey900AndWhite(context)),
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Enter Your Password',
                        hintStyle: theme.textTheme.bodyMedium!.copyWith(
                            color: AppDynamicColorBuilder.getGrey600AndGrey400(context),
                            fontWeight: FontWeight.w500),
                        icon: Icon( Icons.password,
                          color:  AppDynamicColorBuilder.getGrey600AndGrey400(context)
                            
                        ),
                      ),
                    ),
                  ),
                     SizedBox(height: 20,),
                  Divider(height: 20,),
                
                   
                    SizedBox(height: 20,),
                            
                          
                  AnimatedContainer(
                      margin: EdgeInsets.only(top: marginContainer),
                       duration: const Duration(milliseconds: 300),
                  height: 50.h,
                  decoration: BoxDecoration(
                
                    color: AppDynamicColorBuilder.getDark3AndGrey200(context),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color:
                           AppDynamicColorBuilder.getGrey100AndDark2(context),
                      width: 1,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      
                      onTap: () {
                      LogIn();
                      
                    }, child: Container( child: Row(
                      mainAxisAlignment: MainAxisAlignment.center, 
                      children: [
                        isLoading == true?Container(height: 20,width: 20,child:CircularProgressIndicator(strokeWidth: 5,color: AppDynamicColorBuilder.getGrey600AndGrey400(context),),):Container(),
                       SizedBox(width: 10,),
                        Text("Log In "),
                        Icon(Icons.login_rounded)])),) ,
                    
                  ),
                  SizedBox(height: 50,)
                              
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      ],
                    ),
                  )
                              ],),
                )
              ),
           
          ),
      ), 
        ),
      )
    );
  }
}

















