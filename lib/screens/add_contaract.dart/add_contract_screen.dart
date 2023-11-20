import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:softpro_support/config/global/constants/app_static_data.dart';
import 'package:softpro_support/config/theme/app_theme.dart';
import 'package:softpro_support/contracts_notifier.dart';
import 'package:softpro_support/customers_notifier.dart';
import 'package:softpro_support/screens/task/imageCard.dart';
import 'package:softpro_support/task_notifier.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import '../../config/theme/app_colors.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:intl/intl.dart';
import 'package:fluid_dialog/fluid_dialog.dart';





class AddContractScreen extends StatefulWidget {
  final String customerName;
 
   AddContractScreen({super.key, required this.customerName,  });

  @override
  State<AddContractScreen> createState() => _AddContractScreenState();
}

class _AddContractScreenState extends State<AddContractScreen> {
   

  String  selectedCustomer ='0';
      final _searchCus = TextEditingController();
    String startDate  = "Start date";
 String? endDate  = "ent date";

 Future<void> _showDatePicker(kind)async{
    final DateTime? picked=await  showDatePicker(
       context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );
    if(picked != null)
    {
      print(picked);
    }
    setState(() {
      if(kind == 'start'){
   final String dateFormatter = DateFormat('yyyy-MM-dd').format(picked!).toString();
   startDate = dateFormatter;
   }else{
  final String dateFormatter = DateFormat('yyyy-MM-dd').format(picked!).toString();
   endDate = dateFormatter;
   }
      
    });
  }




_addContract()async{
    String resAddCont = await  Provider.of<ContractNotifier>(context, listen: false).addContract(selectedCustomer,startDate,endDate);
 Navigator.of(context).pop();
   Provider.of<CustomerNotifier>(context, listen: false).getClientNotifier(false);
     ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
  content: Text(
    resAddCont,
    style: const TextStyle(
      color: Colors.white,
      fontSize: 13.0,
     
    ),
  ),
  backgroundColor: AppColors.blueGray,
  behavior: SnackBarBehavior.floating,
  duration: const Duration(seconds: 3),
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
)
            );




}
       
    
    
  @override
  Widget build(BuildContext context) {

      ThemeData theme = Theme.of(context);
             return Consumer<TaskNotifier>(
builder: (context, model, child) {
    return Scaffold(
 
      
      appBar:    PreferredSize(
          
          preferredSize: const Size(double.infinity, 80),
          child: Container(
             decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
             bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
              child: BackdropFilter(
                 filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: AppBar(title: 
          Text('New Contract',style:  theme.textTheme.headlineMedium!
              .copyWith(color: AppDynamicColorBuilder.getGrey900AndWhite(context)),), 
                //  actions: [InkWell(onTap: (){
                
                //  }, child: Container(
                //   width: 60,
                //   decoration: BoxDecoration(color: AppColors.blue,
                //   borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20))
                //   ),
                //   // margin: EdgeInsets.only(right: 30),
                //   child: model.isAddingTask == true?Container(width: 10,height: 10, padding: EdgeInsets.symmetric(vertical: 20,horizontal: 14), child: CircularProgressIndicator(color: AppColors.white,)): Icon(Icons.save_outlined,color: AppColors.white,) ,)
                  
                //   )
                //   ],
                  toolbarHeight: 80,))
                  
                  ))
        ),
        body: SingleChildScrollView(
  
  

            child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                
             const SizedBox(height: 30,),
                  Form(
              
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
             Text("Contract details :",style: theme.textTheme.labelLarge!.copyWith(
                                 //color: theme.primaryColor,
                                             color:AppDynamicColorBuilder.getGrey800AndGrey300(context),
                                  fontWeight: FontWeight.w600),),
                const SizedBox(height: 20,),
          
                          const SizedBox(height: 10,),
              AnimatedContainer(
                alignment: Alignment.center,
                   duration: const Duration(milliseconds: 500),
              height: 80.h,
              decoration: BoxDecoration(
                color: AppDynamicColorBuilder.getGrey100AndDark2(context),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color:
                       AppDynamicColorBuilder.getGrey100AndDark2(context),
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
            controller: _searchCus,
            autofocus: true,
            decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: 'Select Customer',
                    hintStyle: theme.textTheme.bodyLarge!.copyWith(
                        color: AppDynamicColorBuilder.getGrey800AndGrey300(context),
                        fontWeight: FontWeight.w500),
                    icon: Icon( Icons.person_add_alt_1_outlined,
                      color:  AppDynamicColorBuilder.getGrey800AndGrey300(context),
                        
                    ),
                  ),
          ),
          suggestionsCallback: (pattern) {
            
            return AppStaticData.downloadMoviesName.where((option) =>
                option['name_customer'].toLowerCase().contains(pattern.toLowerCase()));
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              title: Text(suggestion['name_customer']),
            );
          },
          onSuggestionSelected: (suggestion) {
            setState(() {
              selectedCustomer = suggestion['CusId'];
              print(selectedCustomer);
              if(null == suggestion['endDate']){
                 startDate = '';
              }else{
              startDate = suggestion['endDate'];
              }
              _searchCus.text =suggestion['name_customer'];
            });
          },
        ),
              ),
              const Divider(height: 20,),
            
          AnimatedContainer(
                   duration: const Duration(milliseconds: 500),
              height: 80.h,
              decoration: BoxDecoration(
                color: AppDynamicColorBuilder.getGrey100AndDark2(context),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color:
                       AppDynamicColorBuilder.getGrey100AndDark2(context),
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                  onTap: () {
                    _showDatePicker('start');
                  },
                  child: Container(alignment: Alignment.center, child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                   Text(startDate),
                      const Icon(Icons.arrow_drop_down)
                    ],
                  )),
                )
              ),


  const Divider(height: 20,),
            
          AnimatedContainer(
                   duration: const Duration(milliseconds: 500),
              height: 80.h,
              decoration: BoxDecoration(
                color: AppDynamicColorBuilder.getGrey100AndDark2(context),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color:
                       AppDynamicColorBuilder.getGrey100AndDark2(context),
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                  onTap: () {
                    _showDatePicker('end');
                  },
                  child: Container(alignment: Alignment.center, child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                   Text(endDate!),
                      const Icon(Icons.arrow_drop_down)
                    ],
                  )),
                )
              ),
              const Divider(height: 20,),
               AnimatedContainer(
                alignment: Alignment.center,
                   duration: const Duration(milliseconds: 500),
              height: 80.h,
              decoration: BoxDecoration(
                color: AppDynamicColorBuilder.getGrey100AndDark2(context),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color:
                       AppDynamicColorBuilder.getGrey100AndDark2(context),
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text("Contract year 2023"),
              ),
              const Divider(height: 20,),
               Consumer<ContractNotifier>(
                builder: (context, model, child) {
                  
                
                return AnimatedContainer(
                     duration: const Duration(milliseconds: 500),
                             height: 80.h,
                             decoration: BoxDecoration(
                  color: AppColors.blue,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color:
                         AppDynamicColorBuilder.getGrey100AndDark2(context),
                    width: 1,
                  ),
                             ),
                             padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: InkWell(
                    onTap: () {
                    _addContract();
                    },
                    child: Container(alignment: Alignment.center, child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                     const Text("Save Contract",style: TextStyle(color: AppColors.white),),
                     const SizedBox(width: 20,),
                      model.isAddingContract==true?Container(width: 20,height: 20,child: const CircularProgressIndicator(color: AppColors.white),) :
                       const Icon(Icons.save,color: Colors.white,)
                      ],
                    )),
                  )
                             );
                }
               ),
                  ],
                ),
              )
            ],)
          
          ),
        ),
          );
         }
    );
    
  }
}






