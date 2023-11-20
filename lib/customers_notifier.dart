import 'package:flutter/material.dart';

import 'config/global/constants/app_static_data.dart';
import 'config/services/server.dart';


class CustomerNotifier extends ChangeNotifier {
 List<dynamic> customers_list = [];
  String selectedUser= '0';
bool isFilterCus = false;
bool isgettingCus = false;
bool isSearching = false;
bool isUpdatingCus = false;
 static Map CustomerDetailUpdate = {'id':'','name':'','Adress':'','status':'','Telephone':'','region':'','userTel':''};
Map customerDetailPriv = CustomerDetailUpdate;


        // List<dynamic> userList = [ ];




Future<String> addNewCustomer(name) async{

  isUpdatingCus = true;
 
  notifyListeners();
String responseUpdate  =  await ServerService.addNewCustomer(name);
//customers_list[customers_list.indexWhere((element) => element['id'] == CustomerDetailUpdate['id'])]['name_customer'] = 'fldk';
isUpdatingCus = false;

     notifyListeners();
     getClientNotifier(false);
return responseUpdate;

}





Future<String> updateCustomerDetai(digit,value) async{

  isUpdatingCus = true;
 
CustomerDetailUpdate[digit] = value;
 customerDetailPriv = customerDetailPriv;
//  customers_list[customers_list.indexWhere((element) => element['CusId'] == CustomerDetailUpdate['id'])]['']

  notifyListeners();
String responseUpdate  =  await ServerService.UpdateCustomer(CustomerDetailUpdate);
//customers_list[customers_list.indexWhere((element) => element['id'] == CustomerDetailUpdate['id'])]['name_customer'] = 'fldk';
isUpdatingCus = false;

     notifyListeners();
     getClientNotifier(false);
return responseUpdate;

}







getClientNotifier(onLoad) async {
  if(onLoad){
 isgettingCus = true;
  }
Map<String,dynamic> ListData = await ServerService.getCustomers();
    AppStaticData.downloadMoviesName= ListData['Cus'];
      AppStaticData.userList = [ {'Id': '0', 'code': '(None)', 'pass': '', 'isActive': '', 'name': 'none'}];
    AppStaticData.userList.addAll(ListData['User']) ;
    // userList = AppStaticData.userList;
     AppStaticData.softWareList = ListData['SoftWar'];
   //  AppStaticData.deppSupportList = ListData['Type'];
          AppStaticData.deppSupportList = ListData['Type'];
     AppStaticData.regionlist = ListData['Reg'];
    AppStaticData.listStatus = ListData['listStatus'];
     customers_list = AppStaticData.downloadMoviesName;
   print('///////////////////////////////////////////-----------\\\\\\\\\\\\\\\$');
  print(ListData['User']);
    isgettingCus = false;
    notifyListeners();
}


static void getClientNotifierStatic() async {
 
getClientNotifierStatic();
}

searchCustomer(value){
  isSearching = true;

 customers_list =  AppStaticData.downloadMoviesName.where((element) => element['name_customer']
            .toLowerCase()
            .contains(value.toLowerCase() ) || element['Tel'] .contains(value)).toList();
            notifyListeners();

 
}

isntSearching(){
  isSearching = false;
  notifyListeners();
}

filterCustomer(){
  if(isFilterCus == false){
 customers_list =  AppStaticData.downloadMoviesName.where((element) => element['status'] == 'Activeted').toList();
  isFilterCus = true;
            notifyListeners();
  }else{
     customers_list =  AppStaticData.downloadMoviesName;
       isFilterCus = false;
            notifyListeners();

  }
}



// filterUser(idDep,isinitialstate){
 
//  userList =  AppStaticData.userList.where((element) => element['IdDep'] == idDep).toList();
//  if(isinitialstate == true){

//  }else{
  
//     notifyListeners();
//  }
      

// }



}