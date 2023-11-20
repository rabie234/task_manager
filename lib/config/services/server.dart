
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:softpro_support/config/global/constants/app_static_data.dart';

class ServerService {
  static final _baseUrl = Uri.parse(
   'https://api.softpro.me/CustomersAPIs/supportApi/api.php'
     
   );

  static Future<Map<String,dynamic>> getCustomers() async {
  try {
      var map = <String, dynamic>{};
      map['action'] = "GET_CUSTOMER";
 
      final response = await http.post(_baseUrl, body: map);
   
      if (200 == response.statusCode) {
        final data = jsonDecode(response.body);
      return Map<String,dynamic>.from(data);
      } else {
        throw Exception('Failed to load items');
      }
    } catch (e) {
      throw Exception(e);
    }

  }



   static Future<String> addTask(taskId,cusId,taskDes,taskSolution,isDone,idUser,softwareId,typesupportId) async {
      String dateTask =  DateTime.now().toString() ;
    String? responseAdd;
  try {
      var map = <String, dynamic>{};
      map['action'] = "ADD_TASK";
      map['task_id'] = taskId;
      map['task_des'] = taskDes;
      map['task_sol'] = taskSolution;
      map['is_done'] = isDone;
      map['cus_id'] = cusId;
      map['date'] = dateTask;
      map['user_id'] = idUser;
      map['softwareId'] = softwareId;
      map['deppartement'] = typesupportId;
      map['user_id_action'] = UserDetail.id.toString();
      

if (kDebugMode) {
  print(map);
}
      
 
     final response = await http.post(_baseUrl, body: map);
  
      if (200 == response.statusCode) {
        final data = response.body;
       
          responseAdd = data;
      } else{
        print('error server');
      }
    } catch (e) {
      print(e);
      return 'error';
    }return (responseAdd!);
    

  }





   static Future<String> deletTask(taskId) async {
      String dateTask =  DateTime.now().toString() ;
    String? responseAdd;
  try {
      var map = <String, dynamic>{};
      map['action'] = "DELET_TASK";
      map['task_id'] = taskId;
      

if (kDebugMode) {
  print(map);
}
      
 
     final response = await http.post(_baseUrl, body: map);
  
      if (200 == response.statusCode) {
        final data = response.body;
       
          responseAdd = data;
      } else{
        print('error server');
      }
    } catch (e) {
      print(e);
      return 'error';
    }return (responseAdd!);
    

  }




   static Future <Map<String, dynamic>> logIn(userName,password,token) async {

    var responseAdd;
  try {
      var map = <String, dynamic>{};
       map['action'] = "LOG_IN";
       map['userName'] = userName;
       map['password'] = password;
       map['token'] = token;

if (kDebugMode) {
  print(map);
}
      
 
     var response = await http.post(_baseUrl, body: map);
  
      if (200 == response.statusCode) {
        final data = response.body;
        print('response data :');
       print(data);
          responseAdd = jsonDecode(data);
      } else{
        responseAdd = {'res':'errorNetwork'};
    
      }
    } catch (e) {
      responseAdd = {'res':'error'};
    print(e);
     
      
    }return (responseAdd);
    

  }





  
  static Future<List<dynamic>> getTasks() async {
  try {
      var map = <String, dynamic>{};
      map['action'] = "GET_TASKS";
 
      final response = await http.post(_baseUrl, body: map);
     // print(response.body);
      if (200 == response.statusCode) {
        final data = jsonDecode(response.body);
      return List<dynamic>.from(data);
      } else {
        throw Exception('Failed to load items');
      }
    } catch (e) {
      throw Exception(e);
    }

  }


 static Future<String> UpdateCustomer(Map detail) async {
  print(detail);
  try {
      var map = <String, dynamic>{};

      map['action'] = "UPDATE_CUSTOMER";
      map['name'] = detail['name'];
      map['adress'] = detail['Adress'];
      map['status'] = detail['status'];
      map['region'] = detail['region'];
      map['tel'] = detail['Telephone'];
      map['userTel'] = detail['userTel'];
      map['id'] = detail['id'];
 
      final response = await http.post(_baseUrl, body: map);
      print(response.body);
      if (200 == response.statusCode) {
        final data = response.body;
      return data;
      } else {
        throw Exception('Failed to load items');
      }
    } catch (e) {
      throw Exception(e);
    }

  }





 static Future<String> addNewCustomer( name) async {

  try {
      var map = <String, dynamic>{};

      map['action'] = "ADD_NEW_CUSTOMER";
      map['name'] = name;
     
 
      final response = await http.post(_baseUrl, body: map);
      print(response.body);
      if (200 == response.statusCode) {
        final data = response.body;
      return data;
      } else {
        throw Exception('Failed to load items');
      }
    } catch (e) {
      throw Exception(e);
    }

  }








static Future<String> deleteImg(id)async{
  String res = '';
   try {
      var map = <String, dynamic>{};

      map['action'] = "DELETE_PHOTO";
     map['id'] = id;
     
 
      final response = await http.post(_baseUrl, body: map);

  print(response.body);
      if (200 == response.statusCode) {
        final data = response.body;
      return data;
      } else {
        throw Exception('Failed to load items');
      }
    } catch (e) {
      throw Exception(e);
    }
}

  

 static Future<String> uploadImage(image,taskId,kind) async {


String res = '' ;

    if (image == null) {
      return 'No image to upload';
    }else{

    var request = http.MultipartRequest('POST', _baseUrl);

    request.files.add(await http.MultipartFile.fromPath('image', image!.path));
 request.fields['taskId'] = taskId;
  request.fields['kind'] = kind; // Add the user's name

      request.fields['action'] = 'ADD_PHOTO';
    var response = await request.send();

    if (response.statusCode == 200) {
       var responseData = await response.stream.bytesToString();
      print(' Response: $responseData');
      res = 'success';
       
   
  }
      return res;
 }
 }




 static Future<List<dynamic>> getImages(idTask) async {
  print('get images');
  try {
      var map = <String, dynamic>{};
      map['action'] = "GET_IMAGES";
      map['id_task'] = idTask;
 
      final response = await http.post(_baseUrl, body: map);
   
      if (200 == response.statusCode) {
        final data = jsonDecode(response.body);
        List<dynamic> dataImages = data;
      
      return List<dynamic>.from(dataImages);
      } else {
        throw Exception('Failed to load items');
      }
    } catch (e) {
      throw Exception(e);
    }

  }







   static Future<String> addContract(customer,startDate,endDate) async {
        final String dateFormatter = DateFormat('yyyy').format(DateTime.now()).toString();
    String? responseAdd;
  try {
      var map = <String, dynamic>{};
      map['action'] = "ADD_CONTRACT";
      map['customer'] =customer;
      map['startDate'] = startDate;
      map['endDate'] = endDate;
      map['year'] = dateFormatter;

      

if (kDebugMode) {
  print(map);
}
      
 
     final response = await http.post(_baseUrl, body: map);
  
      if (200 == response.statusCode) {
        final data = response.body;
       
          responseAdd = data;
      } else{
        print('error server');
      }
    } catch (e) {
      print(e);
      return 'error';
    }return (responseAdd!);
    

  }




  static Future<List<dynamic>> getContract() async {
  try {
      var map = <String, dynamic>{};
      map['action'] = "GET_CONTRACT";
 print('______________________________________________________');
      final response = await http.post(_baseUrl, body: map);
   print(response.body);
      if (200 == response.statusCode) {
   
        final data = jsonDecode(response.body);
        
      return data;
      } else {
        throw Exception('Failed to load items');
      }
    } catch (e) {
      throw Exception(e);
    }


  }



}
