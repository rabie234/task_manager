import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:softpro_support/config/global/utils/random_movie_point.dart';
import 'package:softpro_support/config/services/server.dart';
import 'package:softpro_support/config/theme/app_colors.dart';
import 'package:softpro_support/task_notifier.dart';



class ImageCardTask extends StatefulWidget {
   final String imageName;
   final int index;
   final String idTask;
   final String id;
   final List<String> imagesShow;
  const ImageCardTask({super.key, required this.imageName, required this.index, required this.imagesShow, required this.id, required this.idTask});

  @override
  State<ImageCardTask> createState() => _ImageCardTaskState();
}

class _ImageCardTaskState extends State<ImageCardTask> {



  deleteImg() async{
       Navigator.pop(context, 'Cancel');
                    String res = await  Provider.of<TaskNotifier>(context, listen: false).deleteImg(widget.id,widget.idTask);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        '$res',
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
    )); 
  }
 late CustomImageProvider customImageProvider;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onLongPress: () {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Delete Photo'),
          content: const Text('Are you sure you want to delete this photo'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async{
             deleteImg();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      },
      onTap: (){ customImageProvider = CustomImageProvider(
                          imageUrls: widget.imagesShow,
                          initialIndex: widget.index);
                           showImageViewerPager(context, customImageProvider,
                   useSafeArea: true,
                        doubleTapZoomable: true,
                        onViewerDismissed: (_) {
                          SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                              overlays: SystemUiOverlay.values);
                        },
                                  onPageChanged: (page) {
                                // print("Page changed to $page");
                              },);
                          
                          
                          },
      child: Container(
        width: 100.w,
       
        // margin: needsSpacing
        //     ? EdgeInsets.only(
        //         left: itemIndex == 0 ? 24.w : 10.w,
        //         right: itemIndex == itemCount - 1 ? 24.w : 0)
        //     : null,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: NetworkImage('https://api.softpro.me/CustomersAPIs/supportApi/images/${widget.imageName}'),
            fit: BoxFit.fitHeight,
          ),
        ),
       
      ),
    );
  }
}



// class ImageCardTask extends StatelessWidget {
 
//  final String imageName;

//   const ImageCardTask({
//     Key? key,
  
//     required this.imageName,
   
//   }) : super(key: key);
//   late CustomImageProvider customImageProvider;
//   @override
//   Widget build(BuildContext context) {
//     ThemeData theme = Theme.of(context);
//     return GestureDetector(
//       onTap:   customImageProvider = CustomImageProvider(
//                           imageUrls: model.folderFiles,
//                           initialIndex: index);,
//       child: Container(
//         width: 100.w,
       
//         // margin: needsSpacing
//         //     ? EdgeInsets.only(
//         //         left: itemIndex == 0 ? 24.w : 10.w,
//         //         right: itemIndex == itemCount - 1 ? 24.w : 0)
//         //     : null,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           image: DecorationImage(
//             image: NetworkImage('https://api.softpro.me/CustomersAPIs/supportApi/images/${imageName}'),
//             fit: BoxFit.fitHeight,
//           ),
//         ),
       
//       ),
//     );
//   }
// }


class CustomImageProvider extends EasyImageProvider {
  @override
  final int initialIndex;
  final List<String> imageUrls;

  CustomImageProvider({required this.imageUrls, this.initialIndex = 0})
      : super();

  @override
  ImageProvider<Object> imageBuilder(BuildContext context, int index) {
    return NetworkImage('https://api.softpro.me/CustomersAPIs/supportApi/images/${imageUrls[index]}');
  }

  @override
  int get imageCount => imageUrls.length;
} 
