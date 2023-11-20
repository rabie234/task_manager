import 'dart:convert';
import 'dart:ui';

import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:softpro_support/config/global/constants/app_static_data.dart';
import 'package:softpro_support/config/global/widgets/modal/dialoge_update_add_customersDetails.dart';
import 'package:softpro_support/config/global/widgets/project_app_bar.dart';
import 'package:softpro_support/config/theme/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:softpro_support/config/theme/app_theme.dart';
import 'package:softpro_support/screens/task/add_task.dart';
import 'package:softpro_support/task_notifier.dart';
import '../../customers_notifier.dart';
import 'package:url_launcher/url_launcher.dart';
class CustomerDetail extends StatefulWidget {
  final String adress;
  final String status;
   final int daysLeft;
  final String nameCus;
  final String tel;
  final String code;
  final String idCus;
  final String idStatus;
  final String userTel;
final String name_region;
final String id_region;
  const CustomerDetail(
      {super.key,
      required this.nameCus,
      required this.adress,
  
      required this.status,
      required this.code,
      required this.tel,
      required this.idCus,
      required this.idStatus, required this.daysLeft, required this.userTel, required this.name_region, required this.id_region});

  @override
  State<CustomerDetail> createState() => _CustomerDetailState();
}

class _CustomerDetailState extends State<CustomerDetail> {
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
  void initState() {
    super.initState();
       Provider.of<TaskNotifier>(context, listen: false).filterTasksCustomer(widget.idCus);
    CustomerNotifier.CustomerDetailUpdate['name'] = widget.nameCus;
    CustomerNotifier.CustomerDetailUpdate['Adress'] = widget.adress;
    CustomerNotifier.CustomerDetailUpdate['status'] = widget.idStatus;
    CustomerNotifier.CustomerDetailUpdate['Telephone'] = widget.tel;
    CustomerNotifier.CustomerDetailUpdate['id'] = widget.idCus;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    String name = widget.nameCus;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 80),
          child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black38, spreadRadius: 0, blurRadius: 10),
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
                        title: Text(
                          name,
                          style: theme.textTheme.headlineMedium!.copyWith(
                              color: AppDynamicColorBuilder.getGrey900AndWhite(
                                  context)),
                        ),
                        toolbarHeight: 80,
                        actions: [
                         widget.userTel == ''?Container(): IconButton(color: Colors.blue, onPressed: (){
                           launch("https://wa.me/${widget.userTel}");
                         }, icon: Icon(Icons.phone_forwarded_outlined,)),
                        widget.tel==''?Container():  IconButton(onPressed: () {
                           // ignore: deprecated_member_use
                           launch("https://wa.me/${widget.tel}");
                        }, icon: const Icon(Icons.phone)),
                          const SizedBox(
                            width: 10,
                          ),
                         widget.daysLeft<0?Container(): Container(
                              width: 60,
                              decoration: const BoxDecoration(
                                  color: AppColors.teal,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20))),
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddTaskPage(
                                                customerName: widget.nameCus,
                                                idCus: widget.idCus,
                                                isDone: '0',
                                                idTask: '0',
                                              )),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.add_task,
                                    color: AppColors.white,
                                  )))
                        ],
                      ))))),
      body: SafeArea(
          child: Consumer<CustomerNotifier>(builder: (context, model, child) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(children: [
                const SizedBox(
              height: 20,
                ),
                Text(
              "Customer Detail : ",
              style: theme.textTheme.headlineMedium!.copyWith(
                  color:
                      AppDynamicColorBuilder.getGrey900AndWhite(context)),
                ),
                SizedBox(
              height: 20,
                ),
                ListTile(
              onTap: () {
                _alertD('name', widget.nameCus, const Icon(Icons.person_2));
              },
              title: const Text("Name"),
              trailing: Text(widget.nameCus),
              leading: const Icon(Icons.person_2),
                ),
                const Divider(
              height: 10,
                ),
                ListTile(
              onTap: () {
                _alertD('code', widget.code, const Icon(Icons.code_sharp));
              },
              title: const Text("Code"),
              trailing: Text(widget.code),
              leading: const Icon(Icons.code_sharp),
                ),
                const Divider(
              height: 10,
                ),
                ListTile(
              onTap: () {
                _alertD(
                    'Adress', widget.adress, Icon(Icons.location_history));
              },
              title: Text("Adress"),
              trailing: Text(widget.adress),
              leading: Icon(Icons.location_history),
                ),
                Divider(
              height: 10,
                ),
              
                   ListTile(
              onTap: () {
                _alertD(
                    'region', widget.id_region, Icon(Icons.location_city));
              },
              title: Text("Region"),
              trailing: Text(widget.name_region),
              leading: Icon(Icons.location_city),
                ),
                Divider(
              height: 10,
                ),
              
                const ListTile(
              title: Text("Ammount"),
              trailing: Text(
                '40 \$',
                style: TextStyle(color: AppColors.primary),
              ),
              leading: Icon(Icons.money),
                ),
                const Divider(
              height: 10,
                ),
                ListTile(
              onTap: () {
                _alertD('status', widget.idStatus,
                    const Icon(Icons.donut_large_sharp));
              },
              title: const Text("Status"),
              trailing: Container(
                decoration: BoxDecoration(
                    // color: theme.primaryColor.withOpacity(0.1),
                    color: Colors.greenAccent[100],
                    borderRadius: BorderRadius.circular(6)),
                padding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                child: Text(
                  widget.status,
                  style: theme.textTheme.labelSmall!.copyWith(
                      // color: theme.primaryColor,
                      color: Colors.green,
                      fontWeight: FontWeight.w600),
                ),
              ),
              leading: const Icon(Icons.donut_large_sharp),
                ),
                const Divider(
              height: 10,
                ),
                ListTile(
              onTap: () {
                _alertD('Telephone', widget.tel, Icon(Icons.phone));
              },
              title: const Text("Phone"),
              trailing: Text(widget.tel),
              leading: Icon(Icons.phone),
                ),
                Divider(
              height: 10,
                ),
                   ListTile(
              onTap: () {
                _alertD('userTel', widget.userTel, Icon(Icons.phone_forwarded));
              },
              title: const Text("User Phone"),
              trailing: Text(widget.userTel),
              leading: Icon(Icons.phone_forwarded),
                ),
                Divider(
              height: 10,
                ),
                Container(
                child: ListTile(
              onTap: () {
               _alertD('Tasks', widget.tel, Icon(Icons.task));
              },
              title: Text("Task"),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
              leading: Icon(Icons.add_task),
                )),
                Divider(
              height: 20,
                ),
              ])
            ],
          ),
        );
      })),
    );
  }
}














