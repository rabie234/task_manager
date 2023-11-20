import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:softpro_support/config/global/constants/app_static_data.dart';
import 'package:softpro_support/config/theme/app_colors.dart';
import 'package:softpro_support/config/theme/app_theme.dart';
import 'package:softpro_support/customers_notifier.dart';
import 'package:softpro_support/screens/task/add_task.dart';
import 'package:softpro_support/task_notifier.dart';





class UpdateDialog extends StatefulWidget {
  final String typedigitUpdate;
  final String valueDigitUpdate;
  final Icon iconDigit;

  const UpdateDialog({
    super.key,
    required this.typedigitUpdate,
    required this.valueDigitUpdate,
    required this.iconDigit,
  });

  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  final _digitValue = TextEditingController();
  String valueDropdownStatus = '1';
  @override

addCus() async{
   String? resUpdate;
   resUpdate = await Provider.of<CustomerNotifier>(context, listen: false)
          .addNewCustomer(
       _digitValue.text
      );
       Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        '$resUpdate',
        style: TextStyle(
          color: Colors.white,
          fontSize: 13.0,
        ),
      ),
      backgroundColor: AppColors.blueGray,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      action: SnackBarAction(
        label: 'UNDO',
        onPressed: () {
          // Add your logic here
        },
        textColor: Colors.white,
      ),
    ));
}




  updateCus() async {
    String? resUpdate;
    if (widget.typedigitUpdate == 'status'|| widget.typedigitUpdate == 'region') {
      resUpdate = await Provider.of<CustomerNotifier>(context, listen: false)
          .updateCustomerDetai(
        widget.typedigitUpdate,
        valueDropdownStatus,
      );
    } else
     {
      resUpdate = await Provider.of<CustomerNotifier>(context, listen: false)
          .updateCustomerDetai(
        widget.typedigitUpdate,
        _digitValue.text,
      );
    }
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        '$resUpdate',
        style: TextStyle(
          color: Colors.white,
          fontSize: 13.0,
        ),
      ),
      backgroundColor: AppColors.blueGray,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      action: SnackBarAction(
        label: 'UNDO',
        onPressed: () {
          // Add your logic here
        },
        textColor: Colors.white,
      ),
    ));
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      valueDropdownStatus = widget.valueDigitUpdate;
      _digitValue.text = widget.valueDigitUpdate;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Consumer<CustomerNotifier>(builder: (context, model, child) {
      return Container(
        decoration: widget.typedigitUpdate != 'code'
            ? null
            : BoxDecoration(
                color: AppDynamicColorBuilder.getDark2AndGrey50(context),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.primary, width: 4)),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  widget.typedigitUpdate == 'code' ? 'View' :widget.typedigitUpdate == 'Tasks'? 'Customers\'s Tasks': widget.typedigitUpdate=='Add_persone'? 'Add Customer':'View & Update ',
                  style: theme.textTheme.headlineMedium!.copyWith(
                      color:
                          AppDynamicColorBuilder.getGrey900AndWhite(context)),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  child: widget.iconDigit,
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            widget.typedigitUpdate=='Tasks'?Container():  Text(
              '${widget.typedigitUpdate} : ',
              style: theme.textTheme.bodyLarge!.copyWith(
                  color: AppDynamicColorBuilder.getGrey900AndWhite(context)),
            ),
            SizedBox(
              height: 20,
            ),
           widget.typedigitUpdate=='Tasks'?
           
           

           Consumer<TaskNotifier>(
            builder: (context, modelTask, child) {
              
            
           return Container(
            height: 200,
              child:
              modelTask.tasks_customer_filter.isEmpty?
              Center(child: Text("There is no tasks for this customer yet"),):
               ListView.separated(

                itemCount: modelTask.tasks_customer_filter.length,
                itemBuilder: (BuildContext context, int index) {
                  return    InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                       Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AddTaskPage(
          idSoftware: modelTask.tasks_customer_filter[index]['idSoftware'],
          idDep: modelTask.tasks_customer_filter[index]['idDep'],
          supportUser: modelTask.tasks_customer_filter[index]['iduserToSupport'],
         idCus: modelTask.tasks_customer_filter[index]['idcustomer'],
         customerName: modelTask.tasks_customer_filter[index]['name_customer'],
         isDone: modelTask.tasks_customer_filter[index]['isDone'],
         taskDes: modelTask.tasks_customer_filter[index]['description'],
         taskSolution: modelTask.tasks_customer_filter[index]['Solution'],
         idTask: modelTask.tasks_customer_filter[index]['Id'] ,
        )),
          );
                    },
                    child: AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                               
                                decoration: BoxDecoration(
                                  color: modelTask.tasks_customer_filter[index]['isDone']=='0'?AppColors.primary.withOpacity(0.2):AppDynamicColorBuilder.getGrey100AndDark2(context),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                    color: AppDynamicColorBuilder.getGrey100AndDark2(context),
                    width: 1,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                               
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                    // ignore: prefer_interpolation_to_compose_strings
                    Text('Task : '+ modelTask.tasks_customer_filter[index]['description']),
                    SizedBox(height: 8,),
                    Text("Date : ${modelTask.tasks_customer_filter[index]['dateSupport']}"),
                        SizedBox(height: 8,),
                        modelTask.tasks_customer_filter[index]['Solution'] == ''?Container():
                          Text("Solution : ${modelTask.tasks_customer_filter[index]['Solution']}")
                                  ],
                                ),
                                
                    ),
                  );
                }, separatorBuilder: (BuildContext context, int index) { 
                  return Container(height: 20,);
                 },
              ),
             );
            }
           ):
           
           
           
           
           
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: 60.h,
              decoration: BoxDecoration(
                color: AppDynamicColorBuilder.getGrey100AndDark2(context),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppDynamicColorBuilder.getGrey100AndDark2(context),
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: widget.typedigitUpdate == 'status'
                  ? DropdownButton<String>(
                      isExpanded: true,
                      value: valueDropdownStatus,
                      hint: Text("${widget.typedigitUpdate}"),
                      icon: const Icon(Icons.arrow_drop_down),
                      elevation: 16,
                      //style: const TextStyle(color: AppColors.lightBlue),
                      underline: Container(
                        height: 2,
                        // color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          valueDropdownStatus = value!;
                        });
                      },
                      items: AppStaticData.listStatus
                          .map<DropdownMenuItem<String>>(
                              (e) => DropdownMenuItem(
                                    value: e['id'],
                                    child: Text(e['status_name']),
                                  ))
                          .toList()):widget.typedigitUpdate == 'region'?
                          DropdownButton<String>(
                      isExpanded: true,
                      value: valueDropdownStatus,
                      hint: Text("${widget.typedigitUpdate}"),
                      icon: const Icon(Icons.arrow_drop_down),
                      elevation: 16,
                      //style: const TextStyle(color: AppColors.lightBlue),
                      underline: Container(
                        height: 2,
                        // color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          valueDropdownStatus = value!;
                          print(valueDropdownStatus);
                        });
                      },
                      items: AppStaticData.regionlist
                          .map<DropdownMenuItem<String>>(
                              (e) => DropdownMenuItem(
                                    value: e['id_region'],
                                    child: Text(e['description']),
                                  ))
                          .toList())
                  : TextFormField(
                      controller: _digitValue,
                      readOnly: widget.typedigitUpdate == 'code' ? true : false,
                      style: theme.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppDynamicColorBuilder.getGrey900AndWhite(
                              context)),
                      decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: ' ${widget.typedigitUpdate}',
                          hintStyle: theme.textTheme.bodyMedium!.copyWith(
                              color:
                                  AppDynamicColorBuilder.getGrey600AndGrey400(
                                      context),
                              fontWeight: FontWeight.w500),
                          icon: widget.iconDigit),
                    ),
            ),
            Divider(
              height: 20,
            ),
            SizedBox(
              width: 10,
            ),
            widget.typedigitUpdate == 'code'
                ? Container(
                    width: 250,
                    decoration: BoxDecoration(
                        color: AppDynamicColorBuilder.getDark3AndGrey200(
                            context),
                        borderRadius: BorderRadius.circular(16)),
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Just for read',
                      style: theme.textTheme.bodyLarge!.copyWith(),
                    ))
                : widget.typedigitUpdate=='Tasks'?
                 InkWell(
                   child: Container(
                                 
                      decoration: BoxDecoration(
                          color: AppDynamicColorBuilder.getDark3AndGrey200(
                              context),
                          borderRadius: BorderRadius.circular(16)),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(20),
                      child: Text(
                       'See All Tasks',
                        style: theme.textTheme.bodyLarge!.copyWith(),
                      )),
                 ):
                widget.typedigitUpdate== 'Add_persone'?
                  InkWell(
                   onTap: () {
                    
                    addCus();
                   
                   },
                   child: Container(
                       decoration: BoxDecoration(
                           color:
                               AppDynamicColorBuilder.getDark3AndGrey200(
                                   context),
                           borderRadius: BorderRadius.circular(16)),
                       alignment: Alignment.center,
                       padding: EdgeInsets.all(20),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text(
                             'Save ',
                             style:
                                 theme.textTheme.bodyLarge!.copyWith(),
                           ),
                           SizedBox(
                             width: 10,
                           ),
                           model.isUpdatingCus == false
                               ? Container()
                               : Container(
                                   width: 18,
                                   height: 18,
                                   child: CircularProgressIndicator(
                                       color: AppDynamicColorBuilder
                                           .getDark2AndGrey50(context)),
                                 )
                         ],
                       )),
                 ):
                 InkWell(
                   onTap: () {
                     updateCus();
                   },
                   child: Container(
                       decoration: BoxDecoration(
                           color:
                               AppDynamicColorBuilder.getDark3AndGrey200(
                                   context),
                           borderRadius: BorderRadius.circular(16)),
                       alignment: Alignment.center,
                       padding: EdgeInsets.all(20),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text(
                             'Save Change',
                             style:
                                 theme.textTheme.bodyLarge!.copyWith(),
                           ),
                           SizedBox(
                             width: 10,
                           ),
                           model.isUpdatingCus == false
                               ? Container()
                               : Container(
                                   width: 18,
                                   height: 18,
                                   child: CircularProgressIndicator(
                                       color: AppDynamicColorBuilder
                                           .getDark2AndGrey50(context)),
                                 )
                         ],
                       )),
                 ),
          ],
        ),
      );
    });
  }
}
