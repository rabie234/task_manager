import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:softpro_support/config/global/constants/app_static_data.dart';
import 'package:softpro_support/config/global/constants/image_routes.dart';
import 'package:softpro_support/config/services/server.dart';
import 'package:softpro_support/config/theme/app_theme.dart';
import 'package:softpro_support/contracts_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:softpro_support/screens/TasksList/task_list_screen.dart';
import 'package:softpro_support/screens/contracts/contract_screen.dart';
import 'package:softpro_support/screens/explore/explore_screen.dart';
import 'package:softpro_support/screens/home/home_screen.dart';
import 'package:softpro_support/screens/profile/profile_screen.dart';
import 'package:softpro_support/task_notifier.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../config/theme/app_colors.dart';
import '../../customers_notifier.dart';
import '../my_list/my_list_screen.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}



class _BaseScreenState extends State<BaseScreen> {
  
_getClient()async{
    Provider.of<CustomerNotifier>(context, listen: false).getClientNotifier(true);
    

    
}
_getTasks()async{
  
      Provider.of<TaskNotifier>(context, listen: false).getTask();
  
    
}
_getContracts()async{
  
      Provider.of<ContractNotifier>(context, listen: false).getContracts();
  
    
}
  int _selectedBottomNavIndex = 0;
  @override
  void initState()  {
    super.initState();

     _getClient();
     _getTasks();
     _getContracts();
     


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: ()async { 
          _getClient();
          _getTasks();
          _getContracts();
         },


        child: IndexedStack(
          index: _selectedBottomNavIndex,
          children: _getLayout(),
        ),
      ),
    

      bottomNavigationBar: Consumer<TaskNotifier>(
        builder: (context, model, child) {
          
        
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: BottomNavigationBar(
                currentIndex: _selectedBottomNavIndex,
                onTap: (value) {
                  setState(() {
                    _selectedBottomNavIndex = value;
                  });
                },
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: AppColors.primary,
                unselectedItemColor: AppColors.grey500,
                items: [
                  BottomNavigationBarItem(
                    
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: SvgPicture.asset(AppImagesRoute.iconHome),
                      ),
                      activeIcon: Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: SvgPicture.asset(AppImagesRoute.iconHomeSelected),
                      ),
                      label: 'Home'),
                  // BottomNavigationBarItem(
                  //     icon: Padding(
                  //       padding: const EdgeInsets.only(bottom: 4),
                  //       child: SvgPicture.asset(AppImagesRoute.iconExplore),
                  //     ),
                  //     activeIcon: Padding(
                  //       padding: const EdgeInsets.only(bottom: 4),
                  //       child:
                  //           SvgPicture.asset(AppImagesRoute.iconExploreSelected),
                  //     ),
                  //     label: 'Explore'),
                  // BottomNavigationBarItem(
                  //     icon: Padding(
                  //       padding: const EdgeInsets.only(bottom: 4),
                  //       child: SvgPicture.asset(AppImagesRoute.iconMyList),
                  //     ),
                  //     activeIcon: Padding(
                  //       padding: const EdgeInsets.only(bottom: 4),
                  //       child:
                  //           SvgPicture.asset(AppImagesRoute.iconMyListSelected),
                  //     ),
                  //     label: 'My List'),
                   BottomNavigationBarItem(
                      icon: Container(
                        padding: EdgeInsets.only(bottom: 4),
                       // child: SvgPicture.asset(AppImagesRoute.iconDone),
                     child:
                        Stack(
                        
                          clipBehavior: Clip.none,
                          children: [
                            Icon(Icons.task_outlined),
                            Positioned(
                              top: -5,
                              right: -20,
                              child: model.tasks_notDone.isEmpty?Container():  Container(
                                alignment: Alignment.center,
                                child: Text('${model.tasks_notDone.length}',style: TextStyle(color: Colors.white),),
                                width: 30,
                                height: 20,
                                decoration: 
                            BoxDecoration(
                              border: Border.all(width: 2,color: AppDynamicColorBuilder.getDark2AndGrey50(context)),
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(50)),))
                          ],
                        )
                           // SvgPicture.asset(AppImagesRoute.iconDone),
                      
                      ),
                      activeIcon: Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child:
                        Stack(
                        
                          clipBehavior: Clip.none,
                          children: [
                            Icon(Icons.task_rounded,color: AppColors.primary,),
                            Positioned(
                             top: -5,
                              right: -20,
                              child: model.tasks_notDone.isEmpty?Container():   Container(
                                alignment: Alignment.center,
                                child: Text('${model.tasks_notDone.length}',style: TextStyle(color: Colors.white),),
                                width: 30,
                                height: 20,
                                decoration: 
                            BoxDecoration(
                              border: Border.all(width: 2,color: AppDynamicColorBuilder.getDark2AndGrey50(context)),
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(50)),))
                          ],
                        )
                           // SvgPicture.asset(AppImagesRoute.iconDone),
                      ),
                      label: 'Tasks'),
                 const BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child:   Icon(Icons.assignment_outlined),
                      ),
                      activeIcon: Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child:
                            Icon(Icons.assignment,color: AppColors.primary,)
                      ),
                      label: 'Contracts'),
                ],
              ),
            ),
          ),
        );
        }
      ),
    );
  }
}

List<Widget> _getLayout() => [
      MyListScreen(customers: AppStaticData.downloadMoviesName ,),

    //  const HomeScreen(),
       //const ExploreScreen(),
   
        TaskScreen(tasks: AppStaticData.taksList,),
        Consumer<CustomerNotifier>
        (builder: (context, model, child) =>
          
      
       ContractScreen(customers: model.customers_list,)
        )
    ];
