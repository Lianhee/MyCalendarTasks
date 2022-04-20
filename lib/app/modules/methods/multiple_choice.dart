import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycalendar/app/modules/controller.dart';

class Choices extends StatefulWidget {
  final List choices;
  final bool multiple;
  final List<bool>? choosed;
  const Choices(
      {Key? key, required this.multiple, required this.choices, this.choosed})
      : super(key: key);

  @override
  _Choices createState() => _Choices();
}

class _Choices extends State<Choices> {
  Controller ctrl = Get.find<Controller>();
  @override
  Widget build(BuildContext context) {
    final choices = widget.choices;
    final multiple = widget.multiple;
    final choosed = widget.choosed;

    return Wrap(
        children: choices
            .map((e) => Obx(() {
                  final index = choices.indexOf(e);
                  return FilterChip(
                    backgroundColor: Colors.white,
                    selectedColor: const Color.fromARGB(255, 228, 187, 255),
                    elevation: 2,
                    label: Text(e),
                    selected: (multiple)
                        ? ctrl.choosedIndex.contains(index) && choosed![index]
                        : ctrl.chooseIndex.value == index,
                    onSelected: (bool selected) {
                      ctrl.chooseIndex.value = selected ? index : 0;
                      if (multiple) {
                        if (selected) {
                          ctrl.choosedIndex.add(index);
                        } else {
                          ctrl.choosedIndex.remove(index);
                        }

                        choosed![index] = ctrl.choosedIndex.contains(index);
                      }
                    },
                  );
                }))
            .toList());
  }
}
