








import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:softpro_support/customers_notifier.dart';

import 'config/global/constants/app_static_data.dart';
import 'config/services/server.dart';

 import 'config/services/server.dart';

class ContractNotifier extends ChangeNotifier {
  bool isAddingContract = false;
  bool isgettingContr = false;

List<dynamic> contract_list = [];




getContracts() async {
  
print('get data');
    AppStaticData.contractlist= await ServerService.getContract();
    contract_list = [];
    contract_list = AppStaticData.contractlist;
    
    // isAddingTask = false;
    // isAddTask = "Save";
    print('---------------------------------------------------------');
print(contract_list);

notifyListeners();
   // notifyListeners();
}







Future<String> addContract(customer,startDate,endDate) async{
  isAddingContract = true;

notifyListeners();
String res = await  ServerService.addContract(customer,startDate,endDate);

  isAddingContract = false;
print("la response ext");
notifyListeners();
print(res);
getContracts();

return res;

}








}