import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:softpro_support/config/global/widgets/modal/dialoge_update_add_customersDetails.dart';
import 'package:softpro_support/config/theme/app_colors.dart';
import 'package:softpro_support/customers_notifier.dart';
import 'package:softpro_support/screens/add_contaract.dart/add_contract_screen.dart';
import 'package:softpro_support/screens/contracts/contract_screen.dart';
import 'package:softpro_support/screens/task/add_task.dart';
import 'package:softpro_support/task_notifier.dart';

import '../../../theme_notifier.dart';
import '../../theme/app_theme.dart';
import '../constants/app_static_data.dart';
import '../constants/image_routes.dart';
import 'add_customer_dialog.dart';
















class ProjectAppBar extends StatelessWidget {
  final String appBarTitle;
  final bool isbottomTab;
  final List<Widget>? actions;
   const ProjectAppBar({
    super.key,
    required this.appBarTitle,
     this.actions,
    required this.isbottomTab,
  });







  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Consumer<TaskNotifier>(
      builder: (context, model, child) {
        
      
      return AppBar(
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Text(
            appBarTitle,
            style: theme.textTheme.headlineMedium!
                .copyWith(color: AppDynamicColorBuilder.getGrey900AndWhite(context)),
          ),
        ),
        actions: actions,
       bottom: isbottomTab == false?null:   TabBar(
        labelColor:   AppColors.primary, 
        unselectedLabelColor: AppDynamicColorBuilder.getGrey900AndWhite(context) ,
        dividerColor:AppColors.primary, 
        indicatorColor: AppColors.primary,
            tabs: [
               Tab(icon: Row(
                 children: [
                
                   Text('Tasks')
                 ],
               )),
              Tab(icon: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Row(
                    children: [
                     
                      Text('For You')
                    ],
                  ),
                model.tasks_forYou.isEmpty?Container():  Positioned(
                    right: 10,
                    top: 0,
                    child: Container(width: 10,height: 10, decoration: BoxDecoration(color:AppColors.primary,borderRadius: BorderRadius.circular(50)),))
                ],
              )),
              Tab(icon: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Row(
                    children: [
                     
                      Text('Not Done')
                    ],
                  ),
                model.tasks_notDone.isEmpty?Container():  Positioned(
                    right: 10,
                    top: 0,
                    child: Container(width: 10,height: 10, decoration: BoxDecoration(color:AppColors.primary,borderRadius: BorderRadius.circular(50)),))
                ],
              )),
            ],
          ),
        leading: const Padding(
          padding:  EdgeInsets.only(top: 24, left: 24),
          // child: SvgPicture.asset(
          //   AppImagesRoute.appLogo,
          //   height: 32,
          //   width: 32,
          // ),
          child: CircleAvatar(backgroundImage: AssetImage("assets/images/downloads/0.png")),
        ),
      );
      }
    );
  }
}



class SearchAppBarAction extends StatefulWidget {
  const SearchAppBarAction({super.key});

  @override
  State<SearchAppBarAction> createState() => _SearchAppBarActionState();
}

class _SearchAppBarActionState extends State<SearchAppBarAction> {
  
  String? codeDialog;
  String? valueText;
 Future<void> _displayTextInputDialog(BuildContext context) async {
    return   showDialog(
      
                context: context,
                builder: (BuildContext context) {
                  return LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      return AlertDialog(
                          title: Text("New Customer"),
                          content: AddCustomerDialog()
                      );
                    },
                  );
                },
              );
  }
    _alertD(typeDigit, valueDigit, Icon icon) {
    showDialog(
      context: context,
      builder: (context) => FluidDialog(
        rootPage: FluidDialogPage(
          alignment: Alignment.center,
          builder: (context) => UpdateDialog(
            typedigitUpdate: typeDigit,
            valueDigitUpdate: valueDigit,
            iconDigit: icon,
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
   return Consumer<ThemeNotifier>(
      builder: (context, ThemeNotifier themeNotifier, child) => Padding(
        padding: const EdgeInsets.only(top: 24, right: 24),
        child: Row(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
                   InkWell(onTap: (){

                   }, child: Icon(Icons.notifications_outlined)),
                   SizedBox(width: 30,),
                  UserDetail.isAdmin == false?Container():
           InkWell(onTap: (){
           _alertD('Add_persone', '', Icon(Icons.person_add_alt_1_outlined));
           }, child: Icon(Icons.person_add_alt_outlined)),
  
          ],
        ),
      ),
    );
  }
}









class AddTask extends StatelessWidget {
  const AddTask({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, ThemeNotifier themeNotifier, child) => Padding(
        padding: const EdgeInsets.only(top: 24, right: 24),

        child: InkWell(onTap: () {
           Navigator.push(
  context,
  MaterialPageRoute(builder: (context) =>AddTaskPage(
    customerName: '',idCus:'0',isDone: '0',idTask: '0',)),
);
        }, child: Icon( Icons.add_task,color:AppDynamicColorBuilder.getGrey900AndWhite(context) ,))
      ),
    );
  }
}







class ContractsIconAppBar extends StatelessWidget {
  const ContractsIconAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, ThemeNotifier themeNotifier, child) => Padding(
        padding: const EdgeInsets.only(top: 24, right: 24),

        child: InkWell(onTap: () {
       Navigator.push(
  context,
  MaterialPageRoute(builder: (context) =>AddContractScreen(customerName: 'flk',)),
);
        }, child: Icon( Icons.add,color:AppDynamicColorBuilder.getGrey900AndWhite(context) ,))
      ),
    );
  }
}












