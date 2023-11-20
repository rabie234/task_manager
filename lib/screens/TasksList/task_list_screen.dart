import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:softpro_support/config/global/constants/app_static_data.dart';
import 'package:softpro_support/config/global/widgets/project_app_bar.dart';
import 'package:softpro_support/config/theme/app_colors.dart';
import 'package:softpro_support/config/theme/app_theme.dart';
import 'package:softpro_support/screens/TasksList/widgets/filter_dropdown.dart';
import 'package:softpro_support/screens/task/add_task.dart';
import 'package:softpro_support/task_notifier.dart';
import 'package:softpro_support/theme_notifier.dart';
import 'package:softpro_support/screens/TasksList/widgets/task_card.dart';
import 'package:provider/provider.dart';

import 'package:grouped_list/grouped_list.dart';
import '../explore/widgets/search_and_filter.dart';

class TaskScreen extends StatefulWidget {
  final List<dynamic> tasks;
  const TaskScreen({Key? key, required this.tasks}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  _getTasks() async {
    Provider.of<TaskNotifier>(context, listen: false).getTask();
  }

  _delet(id) async {
    String resDelet =
        await Provider.of<TaskNotifier>(context, listen: false).deletTask(id);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        resDelet,
        style: const TextStyle(
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
        label: 'close',
        onPressed: () {
          // Add your logic here
        },
        textColor: Colors.white,
      ),
    ));
  }

  @override
  void initState() {
    super.initState();
    _getTasks();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Consumer<ThemeNotifier>(
      builder: (context, ThemeNotifier themeNotifier, child) =>
          DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size(double.infinity, 130),
            child: ProjectAppBar(
              appBarTitle: 'Tasks',
              actions: [AddTask()],
              isbottomTab: true,
            ),
          ),
          body: Consumer<TaskNotifier>(
            builder: (context, model, child) {
              return TabBarView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                       Padding(
                        padding: const EdgeInsets.only(right: 0),
                         child: Row(
                           children: [
                            
                             Expanded(flex: 5, child: SearchAndFilter(typeSearch: 'task')),
                             Expanded( flex: 1,child: FilterDropDown(),
                               )
                           ],
                         ),
                       ),
                      Expanded(
                        // color: Colors.transparent,
                        // elevation: 0,
                        child: GroupedListView<dynamic, String>(
                          floatingHeader: true,
                          elements: model.task_list,
                          groupBy: (element) => element['endDate'] ?? '',
                          groupComparator: (value1, value2) =>
                              value2.compareTo(value1),
                          itemComparator: (item1, item2) => item1['endDate']
                              .compareTo(item2['endDate']), // optional
                          order: GroupedListOrder.ASC,
                          useStickyGroupSeparators: true,
                          groupSeparatorBuilder: (String value) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  color: AppColors.amber.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                value,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.blueGray),
                              ),
                            ),
                          ),
                          itemBuilder: (c, element) {
                            return Card(
                              elevation: 8.0,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 6.0),
                              child: SizedBox(
                                child: ListTile(
                                  onLongPress: () {
                                    UserDetail.isAdmin == false
                                        ? null
                                        : showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              title: const Text(
                                                'WARNING !!! ',
                                                style: TextStyle(
                                                    color: AppColors.red),
                                              ),
                                              content: const Text(
                                                  'Do  you want delet this task'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, 'Cancel'),
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    _delet(element['Id']);
                                                    Navigator.pop(
                                                        context, 'OK');
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            ),
                                          );
                                  },
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddTaskPage(
                                                idSoftware:
                                                    element['idSoftware'],
                                                idDep: element['idDep'] ?? '',
                                                tel: element['Tel'],
                                                supportUser: element[
                                                    'iduserToSupport'],
                                                idCus: element['idcustomer'],
                                                customerName: element[
                                                        'name_customer'] ??
                                                    '',
                                                isDone: element['isDone'],
                                                taskDes:
                                                    element['description'],
                                                taskSolution:
                                                    element['Solution'],
                                                idTask: element['Id'],
                                              )),
                                    );
                                  },
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  trailing: Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              // color: theme.primaryColor.withOpacity(0.1),
                                              color: element['isDone'] == "1"
                                                  ? Colors.green
                                                      .withOpacity(0.1)
                                                  : AppColors.primary
                                                      .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w,
                                              vertical: 6.h),
                                          child: Text(
                                            element['isDone'] == '0'
                                                ? 'Not Done'
                                                : 'Done',
                                            style: theme.textTheme.labelSmall!
                                                .copyWith(
                                                    // color: theme.primaryColor,
                                                    color:
                                                        element['isDone'] ==
                                                                "1"
                                                            ? Colors.green
                                                            : AppColors
                                                                .primary,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Text(
                                            element['nameUserToSupport'] ==
                                                    UserDetail.name
                                                ? " (For You) "
                                                : element[
                                                        'nameUserToSupport'] ??
                                                    '',
                                            style: theme.textTheme.bodyMedium!
                                                .copyWith(
                                                    color:
                                                        element['nameUserToSupport'] ==
                                                                UserDetail
                                                                    .name
                                                            ? AppColors.red
                                                            : AppColors.blue,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  title: Text(element['name_customer'] == ''
                                      ? 'Task'
                                      : element['name_customer']),
                                  subtitle:
                                      Text(element['description'] ?? ''),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          // color: Colors.transparent,
                          // elevation: 0,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: model.tasks_forYou.length,
                            itemBuilder: (context, index) => Card(
                              elevation: 8.0,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 6.0),
                              child: SizedBox(
                                child: ListTile(
                                  onLongPress: () {
                                    UserDetail.isAdmin == false
                                        ? null
                                        : showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              title: const Text(
                                                'WARNING !!! ',
                                                style: TextStyle(
                                                    color: AppColors.red),
                                              ),
                                              content: const Text(
                                                  'Do  you want delet this task'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, 'Cancel'),
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    _delet(model
                                                            .tasks_forYou[index]
                                                        ['Id']);
                                                    Navigator.pop(
                                                        context, 'OK');
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            ),
                                          );
                                  },
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddTaskPage(
                                                idSoftware:
                                                    model.tasks_forYou[index]
                                                        ['idSoftware'],
                                                idDep: model.tasks_forYou[index]
                                                        ['idDep'] ??
                                                    '',
                                                tel: model.tasks_forYou[index]
                                                    ['Tel'],
                                                supportUser:
                                                    model.tasks_forYou[index]
                                                        ['iduserToSupport'],
                                                idCus: model.tasks_forYou[index]
                                                    ['idcustomer'],
                                                customerName:
                                                    model.tasks_forYou[index]
                                                            ['name_customer'] ??
                                                        '',
                                                isDone:
                                                    model.tasks_forYou[index]
                                                        ['isDone'],
                                                taskDes:
                                                    model.tasks_forYou[index]
                                                        ['description'],
                                                taskSolution:
                                                    model.tasks_forYou[index]
                                                        ['Solution'],
                                                idTask: model
                                                    .tasks_forYou[index]['Id'],
                                              )),
                                    );
                                  },
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  trailing: Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              // color: theme.primaryColor.withOpacity(0.1),
                                              color: model.tasks_forYou[index]
                                                          ['isDone'] ==
                                                      "1"
                                                  ? Colors.green
                                                      .withOpacity(0.1)
                                                  : AppColors.primary
                                                      .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w, vertical: 6.h),
                                          child: Text(
                                            model.tasks_forYou[index]
                                                        ['isDone'] ==
                                                    '0'
                                                ? 'Not Done'
                                                : 'Done',
                                            style: theme.textTheme.labelSmall!
                                                .copyWith(
                                                    // color: theme.primaryColor,
                                                    color: model.tasks_forYou[
                                                                    index]
                                                                ['isDone'] ==
                                                            "1"
                                                        ? Colors.green
                                                        : AppColors.primary,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Text(
                                            model.tasks_forYou[index]
                                                        ['nameUserToSupport'] ==
                                                    UserDetail.name
                                                ? " (For You) "
                                                : model.tasks_forYou[index]
                                                        ['nameUserToSupport'] ??
                                                    '',
                                            style: theme.textTheme.bodyMedium!
                                                .copyWith(
                                                    color: model.tasks_forYou[
                                                                    index][
                                                                'nameUserToSupport'] ==
                                                            UserDetail.name
                                                        ? AppColors.red
                                                        : AppColors.blue,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  title: Text(model.tasks_forYou[index]
                                              ['name_customer'] ==
                                          ''
                                      ? 'Task'
                                      : model.tasks_forYou[index]
                                          ['name_customer']),
                                  subtitle: Text(model.tasks_forYou[index]
                                          ['description'] ??
                                      ''),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          // color: Colors.transparent,
                          // elevation: 0,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: model.tasks_notDone.length,
                              itemBuilder: (context, index) => Card(
                                    elevation: 8.0,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 6.0),
                                    child: SizedBox(
                                      child: ListTile(
                                        onLongPress: () {
                                          UserDetail.isAdmin == false
                                              ? null
                                              : showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: const Text(
                                                      'WARNING !!! ',
                                                      style: TextStyle(
                                                          color: AppColors.red),
                                                    ),
                                                    content: const Text(
                                                        'Do  you want delet this task'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context,
                                                                'Cancel'),
                                                        child: const Text(
                                                            'Cancel'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          _delet(model
                                                                  .tasks_notDone[
                                                              index]['Id']);
                                                          Navigator.pop(
                                                              context, 'OK');
                                                        },
                                                        child: const Text('OK'),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                        },
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddTaskPage(
                                                      idSoftware: model
                                                              .tasks_notDone[
                                                          index]['idSoftware'],
                                                      idDep:
                                                          model.tasks_notDone[
                                                                      index]
                                                                  ['idDep'] ??
                                                              '',
                                                      tel: model.tasks_notDone[
                                                          index]['Tel'],
                                                      supportUser: model
                                                                  .tasks_notDone[
                                                              index]
                                                          ['iduserToSupport'],
                                                      idCus: model
                                                              .tasks_notDone[
                                                          index]['idcustomer'],
                                                      customerName:
                                                          model.tasks_notDone[
                                                                      index][
                                                                  'name_customer'] ??
                                                              '',
                                                      isDone:
                                                          model.tasks_notDone[
                                                              index]['isDone'],
                                                      taskDes: model
                                                              .tasks_notDone[
                                                          index]['description'],
                                                      taskSolution: model
                                                              .tasks_notDone[
                                                          index]['Solution'],
                                                      idTask:
                                                          model.tasks_notDone[
                                                              index]['Id'],
                                                    )),
                                          );
                                        },
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                                vertical: 10.0),
                                        trailing: Container(
                                          child: Column(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    // color: theme.primaryColor.withOpacity(0.1),
                                                    color: model.tasks_notDone[
                                                                    index]
                                                                ['isDone'] ==
                                                            "1"
                                                        ? Colors.green
                                                            .withOpacity(0.1)
                                                        : AppColors.primary
                                                            .withOpacity(0.1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w,
                                                    vertical: 6.h),
                                                child: Text(
                                                  model.tasks_notDone[index]
                                                              ['isDone'] ==
                                                          '0'
                                                      ? 'Not Done'
                                                      : 'Done',
                                                  style: theme
                                                      .textTheme.labelSmall!
                                                      .copyWith(
                                                          // color: theme.primaryColor,
                                                          color: model.tasks_notDone[
                                                                          index]
                                                                      [
                                                                      'isDone'] ==
                                                                  "1"
                                                              ? Colors.green
                                                              : AppColors
                                                                  .primary,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(top: 5),
                                                child: Text(
                                                  model.tasks_notDone[index][
                                                              'nameUserToSupport'] ==
                                                          UserDetail.name
                                                      ? " (For You) "
                                                      : model.tasks_notDone[
                                                                  index][
                                                              'nameUserToSupport'] ??
                                                          '',
                                                  style: theme
                                                      .textTheme.bodyMedium!
                                                      .copyWith(
                                                          color: model.tasks_notDone[
                                                                          index]
                                                                      [
                                                                      'nameUserToSupport'] ==
                                                                  UserDetail
                                                                      .name
                                                              ? AppColors.red
                                                              : AppColors.blue,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        title: Text(model.tasks_notDone[index]
                                                    ['name_customer'] ==
                                                ''
                                            ? 'Task'
                                            : model.tasks_notDone[index]
                                                ['name_customer']),
                                        subtitle: Text(
                                            model.tasks_notDone[index]
                                                    ['description'] ??
                                                ''),
                                      ),
                                    ),
                                  )),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
