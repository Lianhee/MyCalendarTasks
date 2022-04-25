import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mycalendar/app/core/values/colors.dart';
import 'package:mycalendar/app/core/values/icons.dart';
import 'package:mycalendar/app/core/values/text.dart';
import 'package:mycalendar/app/models/project.dart';
import 'package:mycalendar/app/models/task.dart';
import 'package:mycalendar/app/modules/controller.dart';
import 'package:mycalendar/app/modules/methods/days.dart';
import 'package:mycalendar/app/modules/methods/multiple_choice.dart';

class EditTask extends StatefulWidget {
  final Task task;
  const EditTask({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  Controller ctrl = Get.find<Controller>();
  bool first = true;

  late Project project;
  late String taskTitle;
  late Task oldTask;

  //Day and Time when selected
  DateTime now = DateTime.now();
  TimeOfDay timeNow = TimeOfDay.now();

  // Project selected
  Project? selectedProject;

  // Deadline
  bool setDeadline = false;
  DateTime? selectedDeadline;

  // Priority
  bool setPriority = false;
  int priority = 5;

  // Alarm
  TimeOfDay? selecctedAlarmTime;
  DateTime? selectedAlarmDate;
  DateTime? selectedAlarm;
  bool setAlarm = false;
  String? alarmString;

  // Repeat
  bool setRepeat = false;
  int repeatState = 9;
  String? repeatRange;
  String? repeatNumber;
  DateTime? repeatDate;
  MapEntry<int?, String>? selectedRepeat;
  final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  List<bool> daysSelected = [false, false, false, false, false, false, false];
  String? repeatString;

  // Default Color
  Color color = const Color.fromARGB(255, 145, 120, 180);

  final icons = getIconsData();

  @override
  Widget build(BuildContext context) {
    Task task = widget.task;
    oldTask = task;
    if (first) {
      taskTitle = task.task;
      project = task.project;
      selectedProject = task.project;
      selectedDeadline = task.dueDate;
      if (selectedDeadline != null) {
        setDeadline = true;
      }
      selectedAlarm = task.remindDateTime;
      if (selectedAlarm != null) {
        setAlarm = true;
        selectedAlarmDate = selectedAlarm = DateTime(
          selectedAlarmDate!.year,
          selectedAlarmDate!.month,
          selectedAlarmDate!.day,
        );
        selecctedAlarmTime = TimeOfDay(
          hour: selectedAlarm!.hour,
          minute: selecctedAlarmTime!.minute,
        );
        alarmString = selecctedAlarmTime!.toString().substring(10, 15);

        // selectedAlarm = DateTime(
        //   selectedAlarmDate!.year,
        //   selectedAlarmDate!.month,
        //   selectedAlarmDate!.day,
        //   selecctedAlarmTime!.hour,
        //   selecctedAlarmTime!.minute,
        // );
      }

      priority = task.priority;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _newTask(project),
        _newTaskDetails(project),
      ],
    );
  }

  _newTask(Project? project) {
    first = false;
    color = chooseColor(project);
    return Form(
      key: ctrl.taskFormKey,
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: TextFormField(
          autofocus: true,
          //initialValue: taskTitle,
          controller: ctrl.taskEditCtrl..text = taskTitle,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 15),
            hintText: 'New Task...',
            hintStyle: const TextStyle(
              fontSize: 15,
            ),
            border: InputBorder.none,
            labelStyle: const TextStyle(
              color: Color.fromARGB(255, 104, 103, 172),
              fontWeight: FontWeight.bold,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Icon(
                Icons.circle_outlined,
                color: color,
              ),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: IconButton(
                onPressed: () async {
                  if (setRepeat) {
                    finalDaysSelected();
                  }
                  if (ctrl.taskEditCtrl.text.isNotEmpty) {
                    var task = Task(
                      task: ctrl.taskEditCtrl.text,
                      done: false,
                      project: selectedProject!,
                      dueDate: (setDeadline) ? selectedDeadline : null,
                      remindDateTime: (setAlarm) ? selectedAlarm : null,
                      repeat: (setRepeat) ? selectedRepeat : null,
                      repeatDate: repeatDate,
                      repeatEvery: daysSelected,
                      priority: priority,
                    );
                    ctrl.editTask(oldTask, task);
                    //bool added = ctrl.addTask(task);
                    Get.back();
                    // if (added) {
                    //   EasyLoading.showSuccess('Task Edited');
                    // } else {
                    //   EasyLoading.showError('Task cannot be edit');
                    // }
                  }
                  ctrl.taskEditCtrl.clear();
                  ctrl.editCtrl.clear();
                  ctrl.choosedIndex.clear();
                },
                icon: Icon(
                  Icons.arrow_upward_rounded,
                  color: color,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /* 
   * New Task Details:
   * Project
   * Due Date
   * Alarm
   * Repeat
   */

  _newTaskDetails(Project? project) {
    return Padding(
        padding: const EdgeInsets.only(left: 2, bottom: 15),
        child: SizedBox(
          height: 35,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 5,
                  right: 5,
                ),
                child: _selectProject(project),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 5,
                  right: 5,
                ),
                child: _selectPriority(project),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 5,
                  right: 5,
                ),
                child: _selectDeadline(project),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 5,
                  right: 5,
                ),
                child: _selectAlarm(project),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 5,
                  right: 5,
                ),
                child: _selectRepeat(project),
              ),
            ],
          ),
        ));
  }

  // Project
  _selectProject(Project? project) {
    return InkWell(
      onTap: (() async {
        await showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(15),
            ),
          ),
          builder: (context) => SingleChildScrollView(
            child: Wrap(children: [
              ListTile(
                  leading: const Icon(
                    Icons.create_new_folder_rounded,
                    color: Color.fromARGB(255, 145, 120, 180),
                  ),
                  title: const Text('ToDo'),
                  onTap: () async {
                    Get.back();
                    setState(() {
                      selectedProject = ctrl.defaultProject.value;
                    });
                  }),
              const Divider(
                height: 5,
                indent: 10,
                endIndent: 10,
                color: Colors.grey,
              ),
              ...ctrl.projects
                  .map((e) => ListTile(
                      leading: Icon(
                        e.icon,
                        color: e.color,
                      ),
                      title: Text(e.title),
                      onTap: () async {
                        Get.back();
                        setState(() {
                          selectedProject = e;
                        });
                      }))
                  .toList(),
            ]),
          ),
        );
      }),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 2,
          bottom: 2,
          left: 10,
          right: 10,
        ),
        child: Row(
          children: [
            (selectedProject == null)
                ? (project == null)
                    ? const Icon(
                        Icons.create_new_folder_rounded,
                        color: Color.fromARGB(255, 145, 120, 180),
                        size: 20,
                      )
                    : Icon(
                        project.icon,
                        color: project.color,
                        size: 20,
                      )
                : Icon(
                    selectedProject!.icon,
                    color: selectedProject!.color,
                    size: 20,
                  ),
            const SizedBox(
              width: 5,
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: Get.width / 2,
                //minWidth: 10,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 2),
                child: (selectedProject == null)
                    ? (project == null)
                        ? const Text('ToDo')
                        : Text(
                            project.title,
                            overflow: TextOverflow.ellipsis,
                          )
                    : Text(
                        selectedProject!.title,
                        overflow: TextOverflow.ellipsis,
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Priority

  _selectPriority(Project? project) {
    return Container(
      decoration: BoxDecoration(
        color: (setPriority) ? priorityColor().withOpacity(0.5) : null,
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: (() async {
          await showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(15),
              ),
            ),
            builder: (context) => SingleChildScrollView(
              child: Wrap(children: [
                ListTile(
                    leading: Icon(
                      Icons.looks_one_rounded,
                      color: Colors.red.shade200,
                    ),
                    title: const Text('Urgent & Important'),
                    onTap: () async {
                      Get.back();
                      setState(() {
                        setPriority = true;
                        priority = 0;
                      });
                    }),
                ListTile(
                    leading: Icon(
                      Icons.looks_two_rounded,
                      color: Colors.orange.shade200,
                    ),
                    title: const Text('Not Urgent & Important'),
                    onTap: () async {
                      Get.back();
                      setState(() {
                        setPriority = true;
                        priority = 1;
                      });
                    }),
                ListTile(
                    leading: Icon(
                      Icons.looks_3_rounded,
                      color: Colors.green.shade200,
                    ),
                    title: const Text('Urgent & Not Important'),
                    onTap: () async {
                      Get.back();
                      setState(() {
                        setPriority = true;
                        priority = 2;
                      });
                    }),
                ListTile(
                    leading: Icon(
                      Icons.looks_4_rounded,
                      color: Colors.blue.shade200,
                    ),
                    title: const Text('Not Urgent & Not Important'),
                    onTap: () async {
                      Get.back();
                      setState(() {
                        setPriority = true;
                        priority = 3;
                      });
                    }),
              ]),
            ),
          );
        }),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 2,
            bottom: 2,
            left: 10,
            right: 10,
          ),
          child: Row(
            children: [
              Icon(
                Icons.priority_high_rounded,
                color: priorityColor(),
                size: 20,
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                constraints: BoxConstraints(
                  maxWidth: Get.width / 2,
                  //minWidth: 10,
                ),
                child: Text(
                  priorityText(),
                ),
              ),
              (setPriority)
                  ? IconButton(
                      constraints: BoxConstraints.loose(const Size(25, 25)),
                      splashRadius: 5,
                      padding: const EdgeInsets.only(
                        top: 2,
                        bottom: 2,
                      ),
                      onPressed: () async {
                        setState(() {
                          setPriority = false;
                          priority = 4;
                        });
                      },
                      icon: Icon(
                        Icons.cancel,
                        color: priorityColor(),
                        size: 20,
                      ))
                  : const Padding(padding: EdgeInsets.zero)
            ],
          ),
        ),
      ),
    );
  }

  // Deadline

  _selectDeadline(Project? project) {
    return Container(
      decoration: BoxDecoration(
        color: (setDeadline) ? color.withOpacity(0.5) : null,
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
          onTap: (() async {
            _pickDate(alarm: false);
          }),
          child: Padding(
              padding: const EdgeInsets.only(
                top: 2,
                bottom: 2,
                left: 10,
                right: 10,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today_rounded,
                    color: color,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: Get.width / 2,
                      //minWidth: 10,
                    ),
                    child: Text(
                      deadlineText(),
                    ),
                  ),
                  (setDeadline)
                      ? IconButton(
                          constraints: BoxConstraints.loose(const Size(25, 25)),
                          splashRadius: 5,
                          padding: const EdgeInsets.only(
                            top: 2,
                            bottom: 2,
                          ),
                          onPressed: () async {
                            setState(() {
                              setDeadline = false;
                            });
                          },
                          icon: Icon(
                            Icons.cancel,
                            color: color,
                            size: 20,
                          ))
                      : const Padding(padding: EdgeInsets.zero)
                ],
              ))),
    );
  }

  // Alarm

  _selectAlarm(Project? project) {
    return Container(
        decoration: BoxDecoration(
          color: (setAlarm) ? color.withOpacity(0.5) : null,
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          onTap: (() async {
            _pickDate(alarm: true);
          }),
          borderRadius: BorderRadius.circular(5),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 2,
              bottom: 2,
              left: 10,
              right: 10,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.alarm_sharp,
                  color: color,
                  size: 24,
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: Get.width / 2,
                    //minWidth: 10,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: (setAlarm)
                        ? Text(
                            'Remind me at $alarmString\n${Days.format.format(selectedAlarmDate!)}',
                            style: const TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          )
                        : const Text('Remind Me'),
                  ),
                ),
                (setAlarm)
                    ? IconButton(
                        constraints: BoxConstraints.loose(const Size(25, 25)),
                        splashRadius: 5,
                        padding: const EdgeInsets.only(
                          top: 2,
                          bottom: 2,
                        ),
                        onPressed: () async {
                          setState(() {
                            setAlarm = false;
                          });
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: color,
                          size: 20,
                        ))
                    : const Padding(padding: EdgeInsets.zero)
              ],
            ),
          ),
        ));
  }

  // Repeat

  _selectRepeat(Project? project) {
    return Container(
        decoration: BoxDecoration(
          color: (setRepeat) ? color.withOpacity(0.5) : null,
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          onTap: (() async {
            _showRepeatMenu();
          }),
          borderRadius: BorderRadius.circular(5),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 2,
              bottom: 2,
              left: 10,
              right: 10,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.repeat_rounded,
                  color: color,
                  size: 24,
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: Get.width / 2,
                    //minWidth: 10,
                  ),
                  child: Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: (setRepeat)
                          ? Text(
                              '$repeatString',
                              overflow: TextOverflow.ellipsis,
                            )
                          : const Text(
                              'Repeat',
                            )),
                ),
                (setRepeat)
                    ? IconButton(
                        constraints: BoxConstraints.loose(const Size(25, 25)),
                        splashRadius: 5,
                        padding: const EdgeInsets.only(
                          top: 2,
                          bottom: 2,
                        ),
                        onPressed: () async {
                          setState(() {
                            setRepeat = false;
                          });
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: color,
                          size: 20,
                        ))
                    : const Padding(padding: EdgeInsets.zero)
              ],
            ),
          ),
        ));
  }

  // Auxiliar Methods

  // DateTime picker

  void _pickDate({required bool alarm}) async {
    await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime.utc(1989, 01, 01),
        lastDate: DateTime.utc(2100, 12, 31),
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Color.fromARGB(
                      255, 204, 179, 240), // header background color
                  onPrimary:
                      Color.fromARGB(255, 108, 58, 179), // header text color
                  onSurface: Colors.black, // body text color
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    primary: const Color.fromARGB(
                        255, 145, 120, 180), // button text color
                  ),
                ),
              ),
              child: child!);
        }).then((value) {
      if (value != null) {
        if (alarm) {
          _pickTime();
          setState(() {
            selectedAlarmDate = value;
          });
        } else {
          setState(() {
            setDeadline = true;
            selectedDeadline = value;
          });
        }
      }
    });
  }

  void _pickTime() async {
    await showTimePicker(
      context: context,
      initialTime: timeNow,
      builder: (context, child) {
        child = Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color.fromARGB(
                    255, 204, 179, 240), // header background color
                onPrimary:
                    Color.fromARGB(255, 108, 58, 179), // header text color
                onSurface: Colors.black, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: const Color.fromARGB(
                      255, 145, 120, 180), // button text color
                ),
              ),
            ),
            child: child!);
        child = MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
        return child;
      },
    ).then((value) {
      if (value != null) {
        setState(() {
          setAlarm = true;
          selecctedAlarmTime = value;
          alarmString = selecctedAlarmTime!.toString().substring(10, 15);

          selectedAlarm = DateTime(
            selectedAlarmDate!.year,
            selectedAlarmDate!.month,
            selectedAlarmDate!.day,
            selecctedAlarmTime!.hour,
            selecctedAlarmTime!.minute,
          );
        });
      }
    });
  }

  // Repeat Menu

  void _showRepeatMenu() async {
    final icons = getRepeatIconsData();
    final title = getRepeatTitle();
    await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text(
              'Choose how the task will repeat',
              style: TextStyle(fontSize: 15),
            ),
            children: [
              for (int i = 0; i < icons.length; i++)
                SimpleDialogOption(
                  onPressed: () async {
                    Get.back();
                    _setRepeatState(repeat: i);
                    if (i == icons.length - 1) {
                      _customizedRepeat();
                    }
                  },
                  child: Row(
                    children: [
                      Icon(
                        icons[i],
                        color: color,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(title[i]),
                    ],
                  ),
                ),
            ],
          );
        });
  }

  // Customized Repeat

  void _customizedRepeat() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Repeat every ...',
              style: TextStyle(fontSize: 15),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(children: [
                  _chooseRepeat(),
                ]),
              ],
            ),
            actions: <Widget>[
              TextButton(
                  child: Text(
                    "CANCEL",
                    style: TextStyle(
                      color: color,
                    ),
                  ),
                  onPressed: () {
                    setRepeat = false;
                    Get.back();
                  }),
              TextButton(
                  child: Text(
                    "OK",
                    style: TextStyle(
                      color: color,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      repeatNumber = repeatNumber ?? '1';
                      repeatRange = repeatRange ?? 'days';
                    });
                    int number = int.parse(repeatNumber!);
                    if (number > 1) {
                      _setRepeatState(repeat: 5, number: number);
                    } else {
                      switch (repeatRange) {
                        case 'days':
                          _setRepeatState(repeat: 0);
                          break;
                        case 'weeks':
                          if (daysSelected.lastIndexOf(true) ==
                              daysSelected.indexOf(true)) {
                            _setRepeatState(repeat: 2);
                          } else {
                            _setRepeatState(repeat: 5, number: number);
                          }
                          break;
                        case 'months':
                          _setRepeatState(repeat: 3);
                          break;
                        case 'years':
                          _setRepeatState(repeat: 4);
                          break;
                      }
                    }
                    Get.back();
                  }),
            ],
          );
        });
  }

  _chooseRepeat() async {
    var items = [
      'days',
      'weeks',
      'months',
      'years',
    ];
    return StatefulBuilder(builder: (context, setState) {
      return Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5, right: 5),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey.withOpacity(0.5))),
                  width: 75,
                  height: 31,
                  child: Center(
                    child: Form(
                      key: ctrl.formKey,
                      child: TextFormField(
                        showCursor: false,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ],
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                        autofocus: true,
                        controller: ctrl.editCtrl..text = repeatNumber ?? '1',
                        onChanged: (String? changed) {
                          repeatNumber = (ctrl.editCtrl.value.text.isEmpty)
                              ? '1'
                              : ctrl.editCtrl.value.text;
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Container(
                  height: 31,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey.withOpacity(0.5))),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                      alignment: AlignmentDirectional.bottomCenter,
                      value: repeatRange ?? 'days',
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          repeatRange = value!;
                        });
                      },
                    )),
                  ),
                ),
              )
            ],
          ),
          (repeatRange == 'weeks')
              ? SizedBox(
                  width: Get.width / 1.5,
                  child: Wrap(children: [
                    Choices(
                      multiple: true,
                      choices: days,
                      choosed: daysSelected,
                    ),
                  ]),
                )
              : const Padding(padding: EdgeInsets.zero)
        ],
      );
    });
  }

  //Repeat State

  void _setRepeatState({required int repeat, int? number}) {
    setState(() {
      setRepeat = true;
      setDeadline = true;
      repeatDate = selectedDeadline ?? now;
      selectedDeadline = selectedDeadline ?? now;
      repeatState = repeat;
      if (repeatState < 5) {
        repeatString = getRepeatTitle()[repeatState];
      }
      switch (repeatState) {
        case 1:
          if (now.weekday == 6) {
            selectedDeadline = now.add(Duration.hoursPerDay.hours * 2);
          } else if (now.weekday == 7) {
            selectedDeadline = now.add(Duration.hoursPerDay.hours);
          }

          break;
        case 5:
          repeatString =
              (number! > 1) ? 'Every $number $repeatRange' : 'Weekly';
          if (repeatRange == 'weeks') {
            int nextDay =
                daysSelected.indexOf(true, now.weekday - 1) - (now.weekday - 1);
            if (nextDay < 0) {
              nextDay = 7 - now.weekday + daysSelected.indexOf(true) + 1;
            }

            selectedDeadline = now.add(Duration.hoursPerDay.hours * nextDay);
            repeatDate = now.add(Duration.hoursPerDay.hours * nextDay);
            List daysS = [];
            for (int i = 0; i < 7; i++) {
              if (daysSelected.elementAt(i)) {
                daysS.add(days.elementAt(i));
              }
            }
            repeatString = (repeatString! +
                '\n${daysS.toString().substring(1, daysS.toString().length - 1)}');
          } else {
            repeatDate = selectedDeadline ?? now;
            selectedDeadline = selectedDeadline ?? now;
          }
          break;
      }
      selectedRepeat =
          MapEntry(number, (repeatState < 5) ? repeatString! : repeatRange!);
    });
  }

  String deadlineText() {
    if (setDeadline) {
      int diffToToday =
          Days.diffDays(now: now.toUtc(), date: selectedDeadline!);

      switch (diffToToday) {
        case 0:
          return 'Due Today';
        case -1:
          return 'Due Yesterday';
        case 1:
          return 'Due Tomorrow';
        default:
          return 'Due ${Days.format.format(selectedDeadline!)}';
      }
    } else {
      return 'Add Due Date';
    }
  }

  void finalDaysSelected() async {
    if (repeatState < 5) {
      selectedRepeat = MapEntry(null, getRepeatTitle()[repeatState]);
    }
    switch (repeatState) {
      case 0:
        daysSelected.fillRange(0, 7, true);
        break;
      case 1:
        daysSelected.fillRange(0, 5, true);
        break;
      case 2:
        daysSelected[now.weekday - 1] = true;
        break;
      case 5:
        selectedRepeat = MapEntry(int.parse(repeatNumber!), repeatRange!);
        break;
    }
  }

  Color priorityColor() {
    return (priority < 4) ? getPriorityColors()[priority] : color;
  }

  String priorityText() {
    return (priority < 4) ? getPriorityText()[priority] : 'Set Priority';
  }
}
