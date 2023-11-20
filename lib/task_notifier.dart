import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'config/global/constants/app_static_data.dart';
import 'config/services/server.dart';


class TaskNotifier extends ChangeNotifier {
List<dynamic> task_list = [];
List<dynamic> tasks_forYou = [];
List<dynamic> tasks_notDone = [];
List<dynamic> tasks_customer_filter = [];
bool isUploadImg = false;
bool isUploadImgSol = false;
  File? _image;

   File? _compressImage;
bool isFilterCus = false;
bool isgettingTask = false;
Task? taskDetails ;
bool isAddingTask = false;
String isAddTask = 'Save';
 List<String> imagesTaskShow =[];
 List<String> imagesSolutionShow =[];
  List<dynamic>? imagesTasks =[];
    List<dynamic>? imagesSolution;





searchTask(value){

 task_list =  AppStaticData.taksList.where((element) =>
  element['name_customer']
            .toLowerCase()
            .contains(value.toLowerCase() ) || 
            element['Solution']  .toLowerCase() .contains(value)||
             element['description'].toLowerCase().contains(value)|| element['Id'].contains(value)
            ).toList();
            notifyListeners();
}











Future<String> deleteImg(id,idTask) async{
String res = await ServerService.deleteImg(id);
getImages(idTask);
notifyListeners();
return res;
}




getTask() async {
print('get data');
    AppStaticData.taksList= await ServerService.getTasks();
    task_list = [];
    task_list = AppStaticData.taksList;
    tasks_forYou = AppStaticData.taksList.where((element) => (element['iduserToSupport'] == UserDetail.id 
    || element['iduserToSupport'] == '0' )&& (element['isDone'] == '0')).toList();
     tasks_notDone = AppStaticData.taksList.where((element) => element['isDone'] == '0').toList();
    // isAddingTask = false;
    // isAddTask = "Save";
print(task_list);
    notifyListeners();
}

 Future<String> addTask(taskDes,taskSolution,idTask,idCus,isDone,idUser,softwareId,typeSupportId) async{
  isAddingTask = true;
 isAddTask = 'Saving ...';
notifyListeners();
String res = await  ServerService.addTask(idTask, idCus, taskDes, taskSolution, isDone,idUser,softwareId,typeSupportId);

  isAddingTask = false;
 isAddTask = 'Save';
notifyListeners();
print(res);
getTask();
return res;

}

 Future<String> deletTask(id) async{

String res = await  ServerService.deletTask(id);


notifyListeners();
print(res);
getTask();
return res;

}




filterTasksCustomer(id){
  tasks_customer_filter = AppStaticData.taksList.where((element) => element['idcustomer'] == id).toList();
print(tasks_customer_filter);
}

// import_taskDetails(taskDes,taskDate,idCus,isDone,taskSol){
//   print(idCus);
//  bool isDoneLocal = false;
// if(isDone == "1"){
// isDoneLocal =true;
// }
// taskDetails =  Task(isDone:isDoneLocal,dateTask: taskDate,idCus: idCus,taskDes: taskDes,solution: taskSol  );

// }



// filterCustomer(){
//   if(isFilterCus == false){
//  task_list =  AppStaticData.downloadMoviesName.where((element) => element['status'] == '1').toList();
//   isFilterCus = true;
//             notifyListeners();
//   }else{
//      task_list =  AppStaticData.downloadMoviesName;
//        isFilterCus = false;
//             notifyListeners();

//   }
// }





    emptyImagesValue(){
       imagesTaskShow = [];
    imagesSolutionShow = [];
    imagesTasks = [];
    imagesSolution = [];
    }



   getImages(idTask) async {
    // imagesTaskShow = [];
    // imagesSolutionShow = [];
    // imagesTasks = [];
    // imagesSolution = [];
List<dynamic> responsImage = await ServerService.getImages(idTask);
print(responsImage);
   imagesTaskShow = [];
    imagesSolutionShow = [];
    imagesTasks = [];
    imagesSolution =[];
imagesTasks = responsImage.where((element) => element['knid'] == '1').toList();
imagesSolution = responsImage.where((element) => element['knid'] == '2').toList();
print(imagesTasks);
if(imagesTasks!.isEmpty){

}else{
for (var element in imagesTasks!) {
  imagesTaskShow .add(element['image']) ;
}
}
if(imagesSolution!.isEmpty){

}else{
for (var element in imagesSolution!) {
  imagesSolutionShow .add(element['image']) ;
}
}

notifyListeners();
  }







Future<void> pickImage(idTask,kind) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
   
        _image = File(pickedFile.path);
    compressImage(_image!);
       _image = File(pickedFile.path);
        print('========================================');
         print(_image!.lengthSync());
    XFile? imageCompressed = await compressImage(_image!);
    File imageCompressedFile =  convertXFileToDartFile(imageCompressed!);
print('========================================');
    print(imageCompressedFile.lengthSync());

    String responseUploadeImg = await uploadImgProvider(imageCompressedFile,idTask,kind);

      
    }
  }
  Future<void> selectImage(idTask,kind) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  
    if (pickedFile != null) {
     
        _image = File(pickedFile.path);
        print('========================================');
         print(_image!.lengthSync());
    XFile? imageCompressed = await compressImage(_image!);
    File imageCompressedFile =  convertXFileToDartFile(imageCompressed!);
print('========================================');
    print(imageCompressedFile.lengthSync());

    String responseUploadeImg = await uploadImgProvider(imageCompressedFile,idTask,kind);

      
    }
  }
File convertXFileToDartFile(XFile xFile) {
  File dartFile = File(xFile.path);
  return dartFile;
}



Future<XFile?>  compressImage(File file) async {
    // Get file path
    // eg:- "Volume/VM/abcd.jpeg"
    final filePath = file.absolute.path;
    
    // Create output file path
    // eg:- "Volume/VM/abcd_out.jpeg"
    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

    final  compressedImage = await FlutterImageCompress.compressAndGetFile(
          filePath, 
          outPath,
          minWidth: 200,
          minHeight: 300,
          quality: 80);
          print(file.lengthSync()
          
          );
        
         return compressedImage;
}


Future<String> uploadImgProvider(image,idTask,kind) async{
  if(kind == '1'){
  isUploadImg = true;
  }else{
    isUploadImgSol = true;
  }
  notifyListeners();
   String UploadRes = await ServerService.uploadImage(image,idTask,kind);
   isUploadImg = false;
   isUploadImgSol = false;
   notifyListeners();
   getImages(idTask);
   return UploadRes;
}









}



class Task {
  
  String? idCus;
  String? taskDes;
  String? dateTask;
  bool isDone =false;
  String? solution;
  String? taskId;
  String userId;

Task({
  this.idCus,
  this.taskId,
  this.taskDes,
  this.dateTask,
  required this.isDone,
  this.solution, 
  required this.userId
});

}