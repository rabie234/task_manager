import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:softpro_support/config/global/constants/app_static_data.dart';
import 'package:softpro_support/config/global/utils/show_modal.dart';
import 'package:softpro_support/config/global/widgets/project_app_bar.dart';
import 'package:softpro_support/config/theme/app_colors.dart';
import 'package:softpro_support/screens/task/add_task.dart';
import 'package:softpro_support/task_notifier.dart';
import '../../../config/global/constants/image_routes.dart';
import '../../../config/theme/app_theme.dart';

class TaskItem extends StatelessWidget {

  final String nameCus ;
   final String idCus;
 final String taskId;
  final String status;
  final String taskDate ;
  final String taskDes;
  final String taskSol;
  // final String? supportType;
  final String? supportUser;
  final String? softwareId;
  final String? userNameToSupport;
   final String? tel;
    final String? iddeppart;




  const TaskItem(
      { Key? key,
//        required this.taskId, this.softwareId, this.supportUser, required this.status,required this.taskDes, required this.taskDate,
//        required this.idCus,
//        required this.taskSol,
//  this.userNameToSupport, this.tel, this.iddeppart,
  required this.nameCus, required this.idCus, required this.taskId, required this.status, required this.taskDate, required this.taskDes, required this.taskSol, this.supportUser, this.softwareId, this.userNameToSupport, this.tel, this.iddeppart})
      : super(key: key);
     


  

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Consumer<TaskNotifier>(
      builder: (context, model, child) {
        
      

      return Container(
    
           color: idCus!='0'? AppDynamicColorBuilder.getGrey100AndDark2(context):null,
        child: GestureDetector(
         
          onTap: (){
            print('________ depaartme nt _______');
            print(iddeppart);
             //model.import_taskDetails(taskDes, taskDate, idCus, status,taskSol);
              Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddTaskPage(
          idSoftware: softwareId,
          idDep: iddeppart,
          tel: tel,
          supportUser: supportUser,
         idCus: idCus,
       
         customerName: nameCus,
         isDone: status,
         taskDes: taskDes,
         taskSolution: taskSol,
         idTask: taskId ,
        )
        ),
          );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            // margin: !isDeleting
            //     ? EdgeInsets.only(
            //         top: index == 0 ? 32.h : 16.h, bottom: index == 5 ? 32.h : 0)
            //     : null,
            child: Row(
              children: [
                // Stack(
                //   alignment: Alignment.center,
                //   children: [
                //     Image.asset('assets/images/downloads/$index.png', width: 150.w),
                //     SvgPicture.asset(AppImagesRoute.iconPlay, height: 20, width: 20),
                //   ],
                // ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                   
                     // border: BorderDirectional(bottom: BorderSide(color: Colors.black12))
                     ),
                    padding: EdgeInsets.only(left: 20.w,bottom: 5,top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Task : ${taskId}"),
                             Text("$nameCus",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 15),),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                               constraints: BoxConstraints(
    maxWidth: 100,),
                              child: Text(
                            
                               taskDes,
                                overflow: TextOverflow.ellipsis,
                               maxLines: 1,
                                style: theme.textTheme.bodyMedium!.copyWith(
                                  color: AppDynamicColorBuilder.getGrey900AndWhite(context),
                                ),
                              ),
                            ),
                              Text(
                          userNameToSupport! ==UserDetail.name?" (For You) ": userNameToSupport!,
                            style: theme.textTheme.bodyMedium!.copyWith(
                                color:     userNameToSupport! ==UserDetail.name?AppColors.red: AppColors.blue,
                                   
                                fontWeight: FontWeight.w600),
                          ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                             taskDate,
                              style: theme.textTheme.bodyMedium!.copyWith(
                                  color: AppDynamicColorBuilder.getGrey600AndGrey400(
                                      context),
                                     
                                  fontWeight: FontWeight.w600),
                            ),
                            
                              Container(
                              decoration: BoxDecoration(
                                 // color: theme.primaryColor.withOpacity(0.1),
                                                color: status=="1"? Colors.green.withOpacity(0.1):AppColors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 6.h),
                              child: Text(
                                status == '0'?'Not Done':'Done',
                                style: theme.textTheme.labelSmall!.copyWith(
                                   // color: theme.primaryColor,
                                               color: status=="1"? Colors.green:AppColors.primary,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                           

                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        // Row(
                        //   children: [
                        //     Container(
                        //       decoration: BoxDecoration(
                        //           color: theme.primaryColor.withOpacity(0.1),
                        //           borderRadius: BorderRadius.circular(6)),
                        //       padding: EdgeInsets.symmetric(
                        //           horizontal: 10.w, vertical: 6.h),
                        //       child: Text(
                        //         '1.4GB',
                        //         style: theme.textTheme.labelSmall!.copyWith(
                        //             color: theme.primaryColor,
                        //             fontWeight: FontWeight.w600),
                        //       ),
                        //     ),
                        //     const Spacer(),
                        //     if (!isDeleting) ... {
                        //       GestureDetector(
                        //         onTap: () => showAppModal(
                        //             context: context,
                        //             modalTitle: 'Delete',
                        //             primaryButtonTitle: 'Yes, Delete',
                        //             secondaryButtonTitle: 'Cancel',
                        //             mainModalContent: Column(
                        //               mainAxisAlignment: MainAxisAlignment.start,
                        //               children: [
                        //                 const SizedBox(
                        //                   width: double.infinity,
                        //                 ),
                        //                 Text(
                        //                   'Are you sure you want to delete this \nmovie download?',
                        //                   textAlign: TextAlign.center,
                        //                   style:
                        //                   theme.textTheme.headlineSmall!.copyWith(
                        //                     color: AppDynamicColorBuilder
                        //                         .getGrey800AndWhite(context),
                        //                   ),
                        //                 ),
                        //                 SizedBox(
                        //                   height: 24.h,
                        //                 ),
                        //                 Padding(
                        //                   padding:  EdgeInsets.symmetric(
                        //                       horizontal: 40.w),
                        //                   child: TaskItem(
                        //                     index: index,
                        //                     isDeleting: true,
                        //                   ),
                        //                 ),
                        //                 SizedBox(
                        //                   height: 24.h,
                        //                 ),
                        //               ],
                        //             ),
                        //             initChildSize: .51,
                        //             minChildSize: .35,
                        //             maxChildSize: .51),
                        //         child: SvgPicture.asset(AppImagesRoute.iconTrash),
                        //       ),
                        //     },
        
                        //   ],
                        // )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      
      );
      }
    );
  }
}