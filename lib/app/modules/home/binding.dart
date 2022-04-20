import 'package:get/get.dart';
import 'package:mycalendar/app/data/providers/provider.dart';
import 'package:mycalendar/app/data/services/repository.dart';
import 'package:mycalendar/app/modules/controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => Controller(
        projectRepository: ProjectRepository(
          projectProvider: ProjectProvider(),
        ),
      ),
    );
  }
}
