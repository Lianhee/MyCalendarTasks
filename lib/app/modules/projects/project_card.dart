import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycalendar/app/modules/controller.dart';
import 'package:mycalendar/app/modules/projects/projects_view.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:mycalendar/app/models/project.dart';

class ProjectCard extends StatelessWidget {
  final ctrl = Get.find<Controller>();
  final Project project;
  final int sets;
  ProjectCard({
    Key? key,
    required this.project,
    required this.sets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = Get.width / sets;
    final color = project.color;
    final title = project.title;
    final icon = project.icon;
    var doneTasks = ctrl.getDone(project: project);
    var size = ctrl.getSize(project: project);

    String s = size == 1 ? '' : 's';
    final bool zoomInSet = (sets == 2);
    return InkWell(
      onTap: () async {
        ctrl.changeProject(project);
        //ctrl.changeTasks(project);
        Get.to(() => const ProjectWindow());
      },
      child: Container(
        width: width,
        height: width,
        margin: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          color: project.color.withOpacity(0.35),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: zoomInSet ? 15 : 10,
            ),
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(7),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: zoomInSet ? 60 : 40,
                            height: zoomInSet ? 60 : 40,
                            child: Icon(
                              icon,
                              color: color,
                              size: zoomInSet ? 60 : 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Column(
                    children: [
                      SizedBox(
                          width: zoomInSet ? 80 : 50,
                          height: zoomInSet ? 80 : 50,
                          child: SfRadialGauge(
                            axes: <RadialAxis>[
                              RadialAxis(
                                  minimum: 0,
                                  maximum:
                                      size.toDouble() > 0 ? size.toDouble() : 1,
                                  showLabels: false,
                                  showTicks: false,
                                  axisLineStyle: AxisLineStyle(
                                    thickness: 0.2,
                                    cornerStyle: CornerStyle.bothCurve,
                                    color: color.withOpacity(0.25),
                                    thicknessUnit: GaugeSizeUnit.factor,
                                  ),
                                  pointers: <GaugePointer>[
                                    RangePointer(
                                      value: doneTasks.toDouble(),
                                      cornerStyle: CornerStyle.bothCurve,
                                      width: 0.2,
                                      sizeUnit: GaugeSizeUnit.factor,
                                      color: color,
                                    ),
                                  ],
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                        positionFactor: 0.1,
                                        angle: 90,
                                        widget: Text(
                                          '$doneTasks / $size',
                                          style: TextStyle(
                                            fontSize: zoomInSet ? 15 : 10,
                                            fontWeight: zoomInSet
                                                ? FontWeight.normal
                                                : FontWeight.bold,
                                          ),
                                        ))
                                  ])
                            ],
                          )),
                    ],
                  ),
                )
              ],
            ),
            Row(
              children: [
                SizedBox(
                  height: zoomInSet ? 10 : 5,
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(7),
                    child: Text(
                      title,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: zoomInSet ? 20 : 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey.shade700,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 7),
                    child: Text(
                      '$size Task$s',
                      style: TextStyle(
                        fontSize: zoomInSet ? 15 : 12,
                        color: Colors.blueGrey.shade300,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
