import 'package:all_in_one/models/metal_rate_model.dart';
import 'package:all_in_one/views/frm_metal_rate.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'ihelper/hive_helper.dart';

void main() async{
  // Hive preparation
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MetalRateModelAdapter());  /* Modal name + Adapter */
  await HiveHelper.init();                        /* Open hive box */

  runApp(const GoldSwing());
}

class GoldSwing extends StatelessWidget {
  const GoldSwing({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'All In One',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const FrmMetalRate(),
    );
  }
}