import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../customers_notifier.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../constants/app_static_data.dart';

class AddCustomerDialog extends StatefulWidget {

  const AddCustomerDialog({
    super.key,
   
  });

  @override
  State<AddCustomerDialog> createState() => _AddCustomerDialogState();
}

class _AddCustomerDialogState extends State<AddCustomerDialog> {
  final _digitValue = TextEditingController();
  String valueDropdownStatus = '1';
  @override


  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Consumer<CustomerNotifier>(builder: (context, model, child) {
      return Scaffold(
        body:Container(child: Column(children: [
                            Divider(),
                            Form(child: Column(children: [
                               AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            height: 60.h,
                            decoration: BoxDecoration(
                              color: AppDynamicColorBuilder.getGrey100AndDark2(
                                  context),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppDynamicColorBuilder.getGrey100AndDark2(
                                    context),
                                width: 1,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                           
                              style: theme.textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color:
                                      AppDynamicColorBuilder.getGrey900AndWhite(
                                          context)),
                              decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  hintText: 'Add Name',
                                  hintStyle: theme.textTheme.bodyMedium!.copyWith(
                                      color: AppDynamicColorBuilder
                                          .getGrey600AndGrey400(context),
                                      fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                            ],))
                          ]),),
      );
    });
  }
}
