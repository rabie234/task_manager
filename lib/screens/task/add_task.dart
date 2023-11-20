import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:softpro_support/config/global/constants/app_static_data.dart';
import 'package:softpro_support/config/theme/app_theme.dart';
import 'package:softpro_support/customers_notifier.dart';
import 'package:softpro_support/screens/task/imageCard.dart';
import 'package:softpro_support/task_notifier.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../config/theme/app_colors.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:fluid_dialog/fluid_dialog.dart';





String UserSelected='0';
String softWarSelected = '0';
String typeSupportSelected = '0';

class AddTaskPage extends StatefulWidget {
  final String customerName;
  final String idCus;
  final String? taskDes;
  final String? taskSolution;
   final String isDone;
   final String? idTask;
   final String? supportUser;
   final String? idSoftware;
  //  final String? idtypesupport;
   final String? tel;
   final String? idDep;
  
   AddTaskPage({super.key, this.supportUser,this.idSoftware, required this.customerName,required this.idCus,this.idTask, required this.isDone,this.taskDes,this.taskSolution, this.tel, this.idDep});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
   

    final FocusNode searchFocusNode = FocusNode();
        final FocusNode taskDesNode = FocusNode();
            final FocusNode taskSolNode = FocusNode();
    final _formKey = GlobalKey<FormState>();
    final _taskDes = TextEditingController();
    final _taskSolution = TextEditingController();


_addTask() async{

if ( _taskDes.text == ''|| typeSupportSelected == '0'){
   ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
  content: Text(
    'Deppartment && Description are required',
    style: TextStyle(
      color: Colors.white,
      fontSize: 13.0,
     
    ),
  ),
  backgroundColor: AppColors.primary,
  behavior: SnackBarBehavior.floating,
  duration: Duration(seconds: 3),
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
            return;
}


    String responseAddTask = await  Provider.of<TaskNotifier>(context, listen: false).addTask(_taskDes.text, _taskSolution.text,widget.idTask, widget.idCus, isDoneStr,UserSelected,softWarSelected,typeSupportSelected);
             Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
  content: Text(
    '$responseAddTask',
    style: TextStyle(
      color: Colors.white,
      fontSize: 13.0,
     
    ),
  ),
  backgroundColor: AppColors.blueGray,
  behavior: SnackBarBehavior.floating,
  duration: Duration(seconds: 3),
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






_alertD(kind){
   showDialog(
              context: context,
              builder: (context) => FluidDialog(
                
                rootPage: FluidDialogPage(
                    
                  alignment: Alignment.center,
                  
                  builder: (context) =>  TestDialog(idTask:widget.idTask!,kind: kind),
                ),
              ),
            );
}



 bool isDoneLocal = false;
 String isDoneStr = '0';
 String idTaskLocal = '0';
 getImages(){
        Provider.of<TaskNotifier>(context, listen: false).getImages(widget.idTask);

 }

    @override
    void initState() {
      super.initState();
   UserSelected = widget.supportUser??'0';
   
    softWarSelected =widget.idSoftware?? '0';
 typeSupportSelected = widget.idDep?? '0';

  Provider.of<TaskNotifier>(context, listen: false).emptyImagesValue();
  if(widget.idTask==''||widget.idTask == null || widget.idTask == '0'){

  }else{
          getImages();
  }

      isDoneStr =widget.idTask=='0'||widget.idTask==''||widget.idTask==null?'0': widget.isDone;
               print(widget.supportUser);
               print(widget.idSoftware);
               print(widget.idDep);
              widget.idTask==null? idTaskLocal='0': idTaskLocal = widget.idTask!;
              widget.taskDes==null? _taskDes.text='': _taskDes.text = widget.taskDes!;
        widget.taskSolution==null? _taskSolution.text='': _taskSolution.text = widget.taskSolution!;
          widget.isDone=='1'?isDoneLocal=true:isDoneLocal==false;
       setState(() {
      });
     // _taskDes.text = widget.taskDes!;

    }
       
    
    
  @override
  Widget build(BuildContext context) {

      ThemeData theme = Theme.of(context);
             return Consumer<TaskNotifier>(
builder: (context, model, child) {
    return Scaffold(
      // bottomNavigationBar: Consumer<TaskNotifier>(
      //   builder: (context, model, child) {
          
        
      //   return Container(
      //     padding: EdgeInsets.symmetric(horizontal: 20),
      //     child: ElevatedButton(child: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //     Text('${model.isAddTask}'),
      //                 model.isAddingTask == true?Container(width: 15,height: 15, child: CircularProgressIndicator(color: Colors.white,)):Container(width: 0,height: 0,)
                   

      //       ],
      //     ),onPressed: () {
      //       _addTask();
      //     },),);
      //   }
      //   ),
      
      appBar:    PreferredSize(
          
          preferredSize: Size(double.infinity, 80),
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
          Text(widget.customerName==''?'New Task': '${widget.customerName}',style:  theme.textTheme.headlineMedium!
              .copyWith(color: AppDynamicColorBuilder.getGrey900AndWhite(context)),), 
                 actions: [
                  widget.tel == null ||widget.tel == ''?Container():
                   InkWell(
                    onTap: () {
                       launch("https://wa.me/${widget.tel}");
                    },
                     child: Icon(Icons.phone),
                   ),
                   SizedBox(width: 20,),
                  InkWell(onTap: (){
                  _addTask();
                 }, child: Container(
                  width: 60,
                  decoration: BoxDecoration(color: AppColors.blue,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20))
                  ),
                  // margin: EdgeInsets.only(right: 30),
                  child: model.isAddingTask == true?Container(width: 10,height: 10, padding: EdgeInsets.symmetric(vertical: 20,horizontal: 14), child: CircularProgressIndicator(color: AppColors.white,)): Icon(Icons.save_outlined,color: AppColors.white,) ,))],
                  toolbarHeight: 80,))
                  
                  ))
        ),
        body: SingleChildScrollView(
  
  

            child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                
             const SizedBox(height: 30,),
                  Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text("Task detail :",style: theme.textTheme.labelLarge!.copyWith(
                                     //color: theme.primaryColor,
                                                 color:AppColors.warning,
                                      fontWeight: FontWeight.w600),),
                                      Container(alignment: Alignment.centerRight,
                                      child:Row(children: [
                                     widget.idTask == '0'?Container():  InkWell(onTap: (){
                                       _alertD('1');
                                       }, child: model.isUploadImg==false? Icon(Icons.add_a_photo):
                                       Container(width: 18,height: 18, 
                                       child: CircularProgressIndicator(color: AppDynamicColorBuilder.getGrey800AndWhite(context)
                                       ,strokeWidth: 2,semanticsLabel: 'loading',))),
                                    // SizedBox(width: 20,),
                                    //  Container(
                                    //   decoration: BoxDecoration(color: Colors.blueGrey,
                                    //   borderRadius: BorderRadius.circular(10)),
                                    //    padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10), 
                                    //    child: InkWell(onTap: (){
                                    //            _addTask();
                                    //    }, child: model.isAddingTask?
                                    //    Container(width: 24,height: 24, child: CircularProgressIndicator(color: AppColors.white,)):
                                    //     Icon(Icons.save,color: AppColors.white,)))
                                      ])
                                      )
               ],
             ),
                SizedBox(height: 20,),
          
                          SizedBox(height: 10,),
              AnimatedContainer(
                   duration: const Duration(milliseconds: 500),
              height: 100.h,
              decoration: BoxDecoration(
                color: AppDynamicColorBuilder.getGrey100AndDark2(context),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color:
                       AppColors.warning,
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: _taskDes,
                 maxLines: 5,
                 cursorColor: AppColors.warning,
                 textDirection: TextDirection.ltr,
                  focusNode: taskDesNode,
                  style: theme.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppDynamicColorBuilder.getGrey900AndWhite(context)),
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: 'Task',
                    hintStyle: theme.textTheme.bodyLarge!.copyWith(
                        color: AppColors.warning,
                        fontWeight: FontWeight.w500),
                    icon: Icon(Icons.close,
                      color:  AppColors.warning,
                        
                    ),
                  ),
                ),
              ),
              Divider(height: 20,),
AnimatedContainer(
   duration: const Duration(milliseconds: 500),
  height: model.imagesTasks!.isEmpty?0: 100,
  child: ListView.builder(
    itemCount: model.imagesTasks!.length,
    scrollDirection: Axis.horizontal,
    itemBuilder: (context, index) {
     return ImageCardTask(idTask: widget.idTask!, id:model.imagesTasks![index]['Id'] , imageName:model.imagesTaskShow[index],index: index, imagesShow: model.imagesTaskShow, );

    } 
  ),
),


 model.imagesTasks!.isEmpty?Container(): Divider(height: 20,),










 Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text("More Details :",style: theme.textTheme.labelLarge!.copyWith(
                                     //color: theme.primaryColor,
                                                 color:AppDynamicColorBuilder.getGrey900AndWhite(context),
                                      fontWeight: FontWeight.w600),),
                                     
               ],
             ),
                SizedBox(height: 20,),
          
                          SizedBox(height: 10,),
              Consumer<CustomerNotifier>(
                builder: (context, modelCustomer, child) {
                  
                
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Expanded(
                       child: AnimatedContainer(
                           duration: const Duration(milliseconds: 500),
                                       height: 50.h,
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
                        child: DropdownButtonExample(idTask: widget.idTask!, type: 'Type',dropDownItems: AppStaticData.deppSupportList,typeSupportId: widget.idDep,)
                                       ),
                     ),
                    SizedBox(width: 20,),
                         Expanded(
                      child: AnimatedContainer(
                           duration: const Duration(milliseconds: 500),
                      height: 50.h,
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
                        child: DropdownButtonExample(idTask: widget.idTask!, type: 'User',dropDownItems: AppStaticData.userList,supportUserId: widget.supportUser,)
                      ),
                    ),
                 
                  ],
                );
                }
              ),
              Divider(height: 20,),




 SizedBox(height: 20,),
          
                          SizedBox(height: 10,),
              AnimatedContainer(
                   duration: const Duration(milliseconds: 500),
              height: 65.h,
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
                child: DropdownButtonExample(idTask: widget.idTask!, type: 'SoftWare',dropDownItems: AppStaticData.softWareList,softwareId: widget.idSoftware,)
              ),
              Divider(height: 20,),






























               Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text("Task solution :",style: theme.textTheme.labelLarge!.copyWith(
                                     //color: theme.primaryColor,
                                                 color:AppColors.success,
                                      fontWeight: FontWeight.w600),),
                                   widget.idTask == '0'?Container(): InkWell(onTap: (){
                                       _alertD('2');
                                       }, child: model.isUploadImgSol==false? Icon(Icons.add_a_photo):
                                       Container(width: 18,height: 18, child: CircularProgressIndicator(color: AppDynamicColorBuilder.getGrey800AndWhite(context),strokeWidth: 2,semanticsLabel: 'loading',)))
               ],
             ),
               
              SizedBox(height: 10,),
           
                          SizedBox(height: 10,),
                          AnimatedContainer(
                   duration: const Duration(milliseconds: 500),
              height: 100.h,
              decoration: BoxDecoration(
                color: AppDynamicColorBuilder.getGrey100AndDark2(context),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color:
                       AppColors.success,
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: _taskSolution,
                 maxLines: 5,
                 cursorColor: AppColors.warning,
                  focusNode: taskSolNode,
                  style: theme.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppDynamicColorBuilder.getGrey900AndWhite(context)),
                       textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: 'solution',
                    hintStyle: theme.textTheme.bodyLarge!.copyWith(
                        color: AppColors.success,
                        fontWeight: FontWeight.w500),
                    icon: Icon( Icons.done,
                      color:  AppColors.success,
                        
                    ),
                  ),
                ),
              ),
               Divider(height: 20,),
                    AnimatedContainer(
   duration: const Duration(milliseconds: 500),
  height: model.imagesSolution!.isEmpty?0: 100,
  child: ListView.builder(
    itemCount: model.imagesSolution!.length,
    scrollDirection: Axis.horizontal,
    itemBuilder: (context, index) {
     return ImageCardTask(idTask: widget.idTask!, id:model.imagesSolution![index]['Id'] , imageName:model.imagesSolutionShow[index],index: index, imagesShow: model.imagesSolutionShow, );

    } 
  ),
),


 model.imagesSolution!.isEmpty?Container(): Divider(height: 20,),
                        SizedBox(height: 10,),
              Container(
                       alignment: Alignment.center,
              height: 60.h,
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
                child: ListTile(title: isDoneStr =='0'?Text("Not Done Yet",style: TextStyle(color: AppColors.primary),): Text("Is Done"),trailing: Switch(
                // thumb color (round icon)
                activeColor: Colors.amber,
                activeTrackColor: Colors.cyan,
                inactiveThumbColor: Colors.blueGrey.shade600,
                inactiveTrackColor: Colors.grey.shade400,
                splashRadius: 50.0,
                // boolean variable value
                value: isDoneLocal,
                // changes the state of the switch
                onChanged: (value) => setState((){
                  if(value == true){
                    isDoneStr = '1';
                  }else{
                    isDoneStr = '0';
                  }
                  isDoneLocal = value;
                }),
              ),),
              ),
              SizedBox(height: 20,)
            // Container(
            //   alignment: Alignment.centerRight,
            //   padding: const EdgeInsets.symmetric(vertical: 16),
            //   child: ElevatedButton(
          
            //     onPressed: () {
            //    model.isAddingTask == true?null:
            //     _addTask();
            //     },
            //     child: Container(
            //       alignment: Alignment.centerRight,
               
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //            Text('${model.isAddTask}'),
            //            model.isAddingTask == true?Container(width: 15,height: 15, child: CircularProgressIndicator(color: Colors.white,)):Container()
            //         ],
            //       ),
            //     ),

            //   ),
            // ),
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










//const List<String> list = <String>['One', 'Two', 'Three', 'Four'];



class DropdownButtonExample extends StatefulWidget {
  final String? supportUserId;
  final String? typeSupportId;
  final String? softwareId;
  final String idTask;
  String type ;
  final List<dynamic> dropDownItems;
  

   DropdownButtonExample({super.key, required this.idTask,this.supportUserId,this.typeSupportId,this.softwareId,  required this.type, required this.dropDownItems});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String? dropdownValue ;
  @override
  void initState() {
    super.initState();
    print('--------------');
    print(widget.typeSupportId);
    dropdownValue =  widget.type == "User"?
  
      widget.supportUserId == null||widget.supportUserId == '0'?dropdownValue:widget.supportUserId:
      widget.type == "SoftWare"?
      widget.softwareId == null||widget.softwareId == '0'?dropdownValue:widget.softwareId:
      widget.typeSupportId == null||widget.typeSupportId == '0'?dropdownValue:widget.typeSupportId;
      widget.idTask == "0"||widget.idTask==null||widget.idTask==''?null:

       widget.type == "User"?
      UserSelected = widget.supportUserId!:
      widget.type == "SoftWare"?
          softWarSelected = widget.softwareId!:
        typeSupportSelected = widget.typeSupportId!;
      
      setState(() {
        
      });

  }


  @override
  Widget build(BuildContext context) {
  
    return Consumer<CustomerNotifier>(
      builder: (context, model, child) {
        
      
      return DropdownButton<String>(
        isExpanded: true,
        value: dropdownValue,
        hint: Text("${widget.type}"),
        icon: const Icon(Icons.arrow_drop_down),
        elevation: 16,
        //style: const TextStyle(color: AppColors.lightBlue),
        underline: Container(
          height: 2,
         // color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
    
            dropdownValue = value!;
            if(widget.type == 'User'){
            UserSelected = value;
            }else if(widget.type == 'SoftWare'){
    softWarSelected =value;
            }else{
              typeSupportSelected = value;
              print(typeSupportSelected);
              
            }
          });
        },
       items: widget.dropDownItems.map<DropdownMenuItem<String>>((map) {
      return widget.type=='User'? DropdownMenuItem<String>(
        value: map['Id'] as String?,
        
        child: Text(map['code'] as String),
      ):widget.type=='SoftWare'?DropdownMenuItem<String>(
        value: map['id'] as String?,
        child: Text(map['Name'] as String),
      ):
      // DropdownMenuItem<String>(
      //   value: map['Id'] as String?,
      //   child: Text(map['Type'] as String),
      // )
       DropdownMenuItem<String>(
        value: map['Id'] as String?,
        child: Text(map['Description'] as String),
      )
      ;
      }).toList(),
    
      );
      }
    );
  }
}



class TestDialog extends StatelessWidget {
  final String idTask;
  final String kind;
  const TestDialog({Key? key, required this.idTask, required this.kind}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      ThemeData theme = Theme.of(context);
    return Consumer<TaskNotifier>(
      builder: (context, model, child) {
        
    
      return Container(
        color: AppDynamicColorBuilder.getDark2AndGrey50(context),
      
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
    
              children: [
    
                Text(
                  'Select Image',
                  style:  theme.textTheme.headlineMedium!
                    .copyWith(color: AppDynamicColorBuilder.getGrey900AndWhite(context)),
                ),
                SizedBox(width: 20,),
                Container(child: Icon(Icons.camera,color: AppColors.purple.withOpacity(1),),)
              ],
            ),
            const SizedBox(height: 20,),
             Text(
                'Select image from camera or device or issa kwayder',style:   theme.textTheme.bodyLarge!
                .copyWith(color: AppDynamicColorBuilder.getGrey900AndWhite(context)),),
                SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    
                    onTap: (){
                        Navigator.of(context).pop();
                      model.pickImage(idTask,kind);
                    },
                    child: Container(decoration: BoxDecoration(color: AppDynamicColorBuilder.getDark3AndGrey200(context), borderRadius: BorderRadius.circular(16)), alignment:
                     Alignment.center, padding: EdgeInsets.all(20), child:  Text('Camera',style:   theme.textTheme.bodyLarge!
                .copyWith(),)),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: InkWell(
                    
                    onTap: (){
                      Navigator.of(context).pop();
                      model.selectImage(idTask,kind);
                    },
                    child: Container(decoration: BoxDecoration(color: AppDynamicColorBuilder.getDark3AndGrey200(context), borderRadius: BorderRadius.circular(16)), alignment:
                     Alignment.center, padding: EdgeInsets.all(20), child:  Text('Device',style:   theme.textTheme.bodyLarge!
                .copyWith(),)),
                  ),
                ),
                
              ],
            ),
          ],
        ),
      );
      }
    );
  }
}

