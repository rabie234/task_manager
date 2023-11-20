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

class CustomerItem extends StatefulWidget {
 final int index;
  final bool isDeleting;
  final String nameCus ;
  final String adress;
  final String status;
  final String Idstatus;

  final String tel;
  final String code;
  final String remainDate;
final String idCus;
final String userTel;
// ignore: non_constant_identifier_names
final String name_region;
final String id_region;
  const CustomerItem(
      { Key? key, required this.tel, required this.idCus,
       required this.code, required this.status, 
        required this.adress, required this.index,required this.nameCus, required this.isDeleting, required this.Idstatus, required this.remainDate, required this.userTel, required this.name_region, required this.id_region})
      : super(key: key);

  @override
  State<CustomerItem> createState() => _CustomerItemState();
}

class _CustomerItemState extends State<CustomerItem> {
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
        
            Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CustomerDetail(
          id_region: widget.id_region,
          name_region:  widget.name_region,
          daysLeft: int.parse(widget.remainDate),
        code: widget.code,
        idCus: widget.idCus,
        nameCus: widget.nameCus,
        adress: widget.adress,
              userTel: widget.userTel,
        status: widget.status,
        tel: widget.tel,
        idStatus: widget.Idstatus,
        )),
          );
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
                       
                              Container(
                              decoration: BoxDecoration(
                                 // color: theme.primaryColor.withOpacity(0.1),
                                                color: widget.status=="Activeted"? Colors.green.withOpacity(0.1):widget.status=="Limited"?AppColors.deepOrange.withOpacity(0.1):AppColors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 6.h),
                              child: Text(
                                widget.status,
                                style: theme.textTheme.labelSmall!.copyWith(
                                   // color: theme.primaryColor,
                                               color: widget.status=="Activeted"? Colors.green:widget.status=="Limited"?AppColors.deepOrange:AppColors.primary,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                           
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                         
                              int.parse(widget.remainDate)<90?Container(
                              width: 14,
                              height: 14,
                              decoration: 
                              
                              BoxDecoration(
                                boxShadow: [BoxShadow(color: AppColors.amber,blurRadius: 10,offset: Offset(1, 1))],

                                            color: int.parse(widget.remainDate)<1? AppColors.primary:AppColors.warning,
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(color: AppDynamicColorBuilder.getDark2AndGrey50(context),width: 1,)
                            ),):Container(),
                              int.parse(widget.remainDate)>90?Container(): SizedBox(width: 20,),
                            Text(
                            '${widget.remainDate}  day Left',
                              style: theme.textTheme.bodyMedium!.copyWith(
                                  color: AppDynamicColorBuilder.getGrey800AndGrey300(
                                      context),
                                     
                                  fontWeight: FontWeight.w600),
                            ),
                           
                          ],
                        ),
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

























































