import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mycalendar/app/data/services/services.dart';
import 'package:mycalendar/app/modules/home/binding.dart';
import 'package:mycalendar/app/modules/welcome/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());

  runApp(const Welcome());
}

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  GetMaterialApp build(BuildContext context) {
    return GetMaterialApp(
      title: 'MyCalendar',
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      initialBinding: InitialBinding(),
      home: const WelcomePage(),
    );
  }
}
