import 'dart:async';
import 'dart:developer';

import 'package:ecommerce_demo_app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runZonedGuarded<Future<void>>(
        () async {
      WidgetsFlutterBinding.ensureInitialized();

      // Run the app within the same zone
      runApp(
        GetMaterialApp(
          title: 'Cart ',
          initialRoute: '/home',
          debugShowCheckedModeBanner: false,
          getPages: AppPages.pages,
          theme: ThemeData(useMaterial3: true),
        ),
      );
    },

        (dynamic error, StackTrace stackTrace) {
      log('error $error');
      log('stackTrace $stackTrace');
    },
  );
}


