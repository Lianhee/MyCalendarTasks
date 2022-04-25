import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mycalendar/app/core/utils/keys.dart';
import 'package:mycalendar/app/data/providers/provider.dart';
import 'package:mycalendar/app/data/services/repository.dart';
import 'package:mycalendar/app/data/services/services.dart';
import 'package:mycalendar/app/modules/controller.dart';
import 'package:mycalendar/app/modules/welcome/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Welcome());
}

Future<void> init(String username) async {
  print('init $username');
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init(username));
  Get.lazyPut(
    () => Controller(
      projectRepository: ProjectRepository(
        projectProvider: ProjectProvider(),
        username: username,
      ),
    ),
  );
  Controller ctrl = Get.find<Controller>();
  ctrl.init(username);
}

Future<void> close() async {
  Controller controller = Get.find<Controller>();
  controller.onClose();
}

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  GetMaterialApp build(BuildContext context) {
    return GetMaterialApp(
      title: 'MyCalendar',
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      home: const WelcomePage(),
    );
  }
}
