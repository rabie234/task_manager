import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:softpro_support/config/global/constants/app_static_data.dart';
import 'package:softpro_support/config/global/utils/show_modal.dart';
import 'package:softpro_support/config/theme/app_colors.dart';
import 'package:softpro_support/screens/Details/customers_details.dart';
import 'package:softpro_support/task_notifier.dart';
import '../../../config/global/constants/image_routes.dart';
import '../../../config/theme/app_theme.dart';

class ContractItem extends StatefulWidget {

  final String nameCus ;
 
  final String status;

  final String startDate ;
 
  final String remainDate;


  ContractItem(
      { Key? key, required this.nameCus,
       required this.status,
        required this.startDate, 
        required this.remainDate, })
      : super(key: key);

  @override
  State<ContractItem> createState() => _ContractItemState();
}

class _ContractItemState extends State<ContractItem> {
  double marginItem =40.h;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     Future.delayed(const Duration(milliseconds: 50), () {
      setState(() {
        marginItem = 0.h;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Consumer<TaskNotifier>(
      builder: (context, model, child) {
        
      
      return AnimatedContainer(
          margin: EdgeInsets.symmetric(horizontal: marginItem),
            duration: const Duration(milliseconds: 300),
        child: GestureDetector(
          onTap:(){
        
      
          },
          child: Container(
          
            padding: EdgeInsets.symmetric(horizontal: 24.w),
           
            child: Row(
              children: [
             
                Expanded(
                  child: Container(
                    
                    decoration: BoxDecoration(border: BorderDirectional(bottom: BorderSide(color: Colors.black12))),
                    padding: EdgeInsets.only(left: 20.w,bottom: 5,top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.nameCus,
                              style: theme.textTheme.titleLarge!.copyWith(
                                color: AppDynamicColorBuilder.getGrey900AndWhite(context),
                              ),
                            ),
        
                          // status=='1' ?
                       
                            //   Container(
                            //   decoration: BoxDecoration(
                            //      // color: theme.primaryColor.withOpacity(0.1),
                            //                     color: widget.status=="Activeted"? Colors.green.withOpacity(0.1):widget.status=="Limited"?AppColors.deepOrange.withOpacity(0.1):AppColors.primary.withOpacity(0.1),
                            //       borderRadius: BorderRadius.circular(6)),
                            //   padding: EdgeInsets.symmetric(
                            //       horizontal: 10.w, vertical: 6.h),
                            //   child: Text(
                            //     widget.status,
                            //     style: theme.textTheme.labelSmall!.copyWith(
                            //        // color: theme.primaryColor,
                            //                    color: widget.status=="Activeted"? Colors.green:widget.status=="Limited"?AppColors.deepOrange:AppColors.primary,
                            //         fontWeight: FontWeight.w600),
                            //   ),
                            // )
                           
                          ],
                        ),
                        const SizedBox(height: 12),
                       
                        const SizedBox(
                          height: 12,
                        ),
                      
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

























































