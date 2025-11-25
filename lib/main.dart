import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_connectivity_service/flutter_connectivity_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Connectivity Service Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final ConnectionServices connectionService = Get.put(ConnectionServices());

  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connectivity Service Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Obx(() => Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: connectionService.isConnected.value
                    ? Colors.green.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: connectionService.isConnected.value
                      ? Colors.green
                      : Colors.red,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    connectionService.isConnected.value
                        ? Icons.wifi
                        : Icons.wifi_off,
                    size: 50,
                    color: connectionService.isConnected.value
                        ? Colors.green
                        : Colors.red,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    connectionService.isConnected.value
                        ? 'Connected'
                        : 'Disconnected',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: connectionService.isConnected.value
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ],
              ),
            )),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                bool isConnected = await connectionService.checkConnection();
                Get.snackbar(
                  'Connection Status',
                  isConnected ? 'Connected' : 'Not Connected',
                  backgroundColor: isConnected ? Colors.green : Colors.red,
                  colorText: Colors.white,
                );
              },
              child: const Text('Check Connection'),
            ),
          ],
        ),
      ),
    );
  }
}