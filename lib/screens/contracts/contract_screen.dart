import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:softpro_support/config/global/constants/app_static_data.dart';
import 'package:softpro_support/config/global/constants/image_routes.dart';
import 'package:softpro_support/config/theme/app_theme.dart';
import 'package:softpro_support/contracts_notifier.dart';
import 'package:softpro_support/screens/contracts/widget/contract_item.dart';
import 'package:softpro_support/screens/my_list/widget/customer_card.dart';
import 'package:softpro_support/screens/explore/widgets/search_and_filter.dart';
import 'package:softpro_support/theme_notifier.dart';
import 'package:provider/provider.dart';

import '../../config/global/widgets/project_app_bar.dart';
import '../../customers_notifier.dart';

class ContractScreen extends StatefulWidget {
  final List<dynamic> customers ;
  const ContractScreen( {Key? key, required this.customers}) : super(key: key);

  @override
  State<ContractScreen> createState() => _ContractScreenState();
}

class _ContractScreenState extends State<ContractScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Consumer<ThemeNotifier>(
      builder: (context, ThemeNotifier themeNotifier, child) => Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 56),
          child: ProjectAppBar(
            appBarTitle: 'Contracts',
            actions: [
             ContractsIconAppBar()
            ], isbottomTab: false,
          ),
        ),
        body: SafeArea(
            child: Consumer<ContractNotifier>(
              builder: (context, model, child) {
                
             return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
            
                      const SearchAndFilter(typeSearch: 'contract'),
                    model.isgettingContr ?
                    
                    Center(child: CircularProgressIndicator(color: theme.primaryColor,strokeWidth: 3,),):
                   Expanded(
                     child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                                 shrinkWrap: true,
                                 itemCount:  model.contract_list.length,
                                 itemBuilder: (context, index) =>
                                  ContractItem(
                                    nameCus: model.contract_list[index]['name_customer'],
                                    remainDate: model.contract_list[index]['endDate'], 
                                    startDate:  model.contract_list[index]['startDate'],
                                    status: '',
                        
                                    
                                    ),
                               ),
                   ),
            
            
            
            
                  // Image.asset(
                  //   themeNotifier.isDark
                  //       ? AppImagesRoute.emptyListDark
                  //       : AppImagesRoute.emptyListLight,
                  //   height: 220.h,
                  //   fit: BoxFit.fitWidth,
                  // ),
                  // const SizedBox(height: 44),
                  // Text('Your List is Empty',
                  //     style: theme.textTheme.headlineMedium!
                  //         .copyWith(color: theme.primaryColor)),
                  // const SizedBox(height: 16),
                  // Text(
                  //   'It seems that you haven\'t added\n any movies to the list',
                  //   textAlign: TextAlign.center,
                  //   style: theme.textTheme.titleLarge!.copyWith(
                  //       color: AppDynamicColorBuilder.getGrey800AndWhite(context),
                  //       fontWeight: FontWeight.w500,
                  //       height: 1.5),
                  // ),
                ],
              );
              }
            )),
      ),
    );
  }
}
