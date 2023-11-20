

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:softpro_support/config/global/constants/app_static_data.dart';
import 'package:softpro_support/config/services/server.dart';

import 'package:softpro_support/screens/base/base_screen.dart';
import 'package:softpro_support/screens/logIn/logInScreen.dart';
import '../../config/theme/app_colors.dart';




class CheckLogInScreen extends StatefulWidget {
  const CheckLogInScreen({super.key});

  @override
  State<CheckLogInScreen> createState() => _CheckLogInScreenState();
}

class _CheckLogInScreenState extends State<CheckLogInScreen> {
  bool isLoading = false;
   late String  _username ;
   late String _token;
  late String  _pass ;
            double marginContainer = 30.h;
            

check() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  _username = prefs.getString('username')??'';
  _token = prefs.getString('token')??'';
_pass = prefs.getString('pass')??'';
if(_username.isEmpty|| _pass.isEmpty){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LogInScreen( )),  );
}else{
LogIn();
}
}




          LogIn()async{
            setState(() {
              isLoading = true;
            });
            var responseLogIn = await ServerService.logIn(_username,_pass,_token);
          setState(() {
            isLoading = false;
          });
            print('respons log in page;');
            print(responseLogIn['res']);
            if(responseLogIn['res'] =='success' ){
              UserDetail.id = responseLogIn['id_user'];
               UserDetail.name = responseLogIn['name_user'];
                 if(responseLogIn['isAdmin'] == '0'){
                UserDetail.isAdmin = false;
               }else{
                UserDetail.isAdmin = true;
               }
                 // ignore: use_build_context_synchronously
                 Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BaseScreen( )),  );
            }else{
               // ignore: use_build_context_synchronously
               Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LogInScreen( )),);
            }
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
  content: Text(
     responseLogIn['res']=='success'?

      "${responseLogIn['res']} ! Welcome back ${responseLogIn['name_user']}'":"${responseLogIn['res']}",
    style: const TextStyle(
      color: Colors.white,
      fontSize: 13.0,
     
    ),
  ),
  backgroundColor:responseLogIn['res']=='success'? AppColors.blueGray:AppColors.primary.withOpacity(0.2),
  behavior: SnackBarBehavior.floating,
  duration: const Duration(seconds: 3),
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
    check();
     Future.delayed(const Duration(milliseconds: 50), () {
    setState(() {
      marginContainer = 0.h;
    });
     });
  }
   
  @override
  Widget build(BuildContext context) {
    
      ThemeData theme = Theme.of(context);
    return Scaffold(body:
    Center(
      child: Container(
        width: 300,
      
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage('assets/images/movie_item_image.png'),
           
          ),
        ),
        
      ),
    )
    
    );
  }
}

















