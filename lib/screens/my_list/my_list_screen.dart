import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:softpro_support/config/global/constants/app_static_data.dart';
import 'package:softpro_support/config/global/constants/image_routes.dart';
import 'package:softpro_support/config/theme/app_theme.dart';
import 'package:softpro_support/screens/my_list/widget/customer_card.dart';
import 'package:softpro_support/screens/explore/widgets/search_and_filter.dart';
import 'package:softpro_support/theme_notifier.dart';
import 'package:provider/provider.dart';

import '../../config/global/widgets/project_app_bar.dart';
import '../../customers_notifier.dart';

class MyListScreen extends StatefulWidget {
  final List<dynamic> customers ;
  const MyListScreen( {Key? key, required this.customers}) : super(key: key);

  @override
  State<MyListScreen> createState() => _MyListScreenState();
}

class _MyListScreenState extends State<MyListScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Consumer<ThemeNotifier>(
      builder: (context, ThemeNotifier themeNotifier, child) => Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 56),
          child: ProjectAppBar(
            appBarTitle: 'Customers',
            actions: [
              SearchAppBarAction(),
            ], isbottomTab: false,
          ),
        ),
        body: SafeArea(
            child: Consumer<CustomerNotifier>(
              builder: (context, model, child) {
                
             return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
            
                      const SearchAndFilter(typeSearch: 'customer'),
                    model.isgettingCus ?
                    
                    Center(child: CircularProgressIndicator(color: theme.primaryColor,strokeWidth: 3,),):
                   Expanded(
                     child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                                 shrinkWrap: true,
                                 itemCount:  model.customers_list.length,
                                 itemBuilder: (context, index) =>
                                  CustomerItem(
                                 
                                     Idstatus: model.customers_list[index]['idStatus'] == null?'1':model.customers_list[index]['idStatus']  ,
                                    idCus: model.customers_list[index]['CusId']  ,
                                    code: model.customers_list[index]['code']  ,
                                    tel:model.customers_list[index]['Tel']  ,
                                 userTel:model.customers_list[index]['userTel']  ,
                                    remainDate:model.customers_list[index]['date_difference']  ,
                                    status:model.customers_list[index]['status_name']==null?'': model.customers_list[index]['status_name'] ,
                                    adress:  model.customers_list[index]['adress'] 
                                   , nameCus: model.customers_list[index]['name_customer'],
                                    index: index,isDeleting: false, 
                                    id_region:model.customers_list[index]['id_region'] ==null?'1':model.customers_list[index]['id_region']  ,
                                    name_region:model.customers_list[index]['name_region'] == null?'':model.customers_list[index]['name_region']
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
