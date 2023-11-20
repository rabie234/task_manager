import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:softpro_support/config/global/constants/app_static_data.dart';
import 'package:softpro_support/contracts_notifier.dart';
import 'package:softpro_support/customers_notifier.dart';
import 'package:softpro_support/task_notifier.dart';
import 'package:softpro_support/theme_notifier.dart';
import 'package:provider/provider.dart';
import '../../../config/global/constants/image_routes.dart';
import '../../../config/global/utils/show_modal.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_theme.dart';
import 'modal_item.dart';

class SearchAndFilter extends StatefulWidget {
  final String typeSearch;
  const SearchAndFilter({
    super.key, required this.typeSearch,
  });

  @override
  State<SearchAndFilter> createState() => _SearchAndFilterState();
}

class _SearchAndFilterState extends State<SearchAndFilter> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
    
        child: Row(
          children: [
            SearchField( listSearch: widget.typeSearch,),
            // SizedBox(width: 12),
            // FilterButton(),
          ],
        ),
      
    );
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerNotifier>(
      builder: (context, model, child) {
        
    
      return GestureDetector(
        onTap: () {
         if( model.isSearching) {
          
          model.isntSearching();
         }else{
          model.filterCustomer();
         }
          
        },
        // onTap: () => showAppModal(
        //   context: context,
        //   initChildSize: .7,
        //   minChildSize: .4,
        //   maxChildSize: .9,
        //   modalTitle: 'Sort & Filter',
        //   primaryButtonTitle: 'Apply',
        //   secondaryButtonTitle: 'Reset',
        //   mainModalContent: Card(
        //     color: Colors.transparent,
        //     elevation: 0,
        //     child: ListView.builder(
        //       shrinkWrap: true,
        //       physics: const NeverScrollableScrollPhysics(),
        //       itemCount: AppStaticData.exploreModalTitles.length,
        //       itemBuilder: (context, index) => ExploreModalItem(index: index),
        //     ),
        //   ),
    
        //),
        child: Container(
          width: 56.w,
          height: 56.h,
          padding: EdgeInsets.all(16.h),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: model.isFilterCus?AppColors.primary: AppColors.backgroundBlue,
          ),
          child:  SvgPicture.asset(
           model.isSearching ? AppImagesRoute.iconDone: AppImagesRoute.iconFilter,
            color: model.isFilterCus?AppColors.backgroundBlue: AppColors.primary,
          ),
        ),
      );
      }
    );
  }
}

class SearchField extends StatefulWidget {
  final String listSearch;
  const SearchField({
    super.key, required this.listSearch,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    searchFocusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Consumer<ThemeNotifier>(
      builder: (context, value, child) => Expanded(
        child: Consumer<CustomerNotifier>(
          builder: (context, model, child) {
            
          
          return Consumer<TaskNotifier>(
            builder: (context, taskNot, child) {
              
            
           return Consumer<ContractNotifier>(
            builder: (context, contractNot, child) {
              
            
             return AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: 56.h,
                decoration: BoxDecoration(
                  color: AppDynamicColorBuilder.getGrey100AndDark2(context),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: searchFocusNode.hasFocus
                        ? theme.primaryColor
                        : AppDynamicColorBuilder.getGrey100AndDark2(context),
                    width: 1,
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  onChanged: (value) {
                    widget.listSearch == 'customer'?
                    model.searchCustomer(value):
                      taskNot.searchTask(value);
                  },
                  focusNode: searchFocusNode,
                  style: theme.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppDynamicColorBuilder.getGrey900AndWhite(context)),
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: 'Search',
                    hintStyle: theme.textTheme.bodyMedium!.copyWith(
                        color: AppDynamicColorBuilder.getGrey600AndGrey400(context),
                        fontWeight: FontWeight.w500),
                    icon: SvgPicture.asset(
                      AppImagesRoute.iconSearch,
                      color: searchFocusNode.hasFocus
                          ? theme.primaryColor
                          : AppDynamicColorBuilder.getGrey600AndGrey400(context),
                    ),
                  ),
                ),
              );
            }
           );
            }
          );
          }
        ),
      ),
    );
  }
}



