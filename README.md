# Flutter Connectivity Service

A comprehensive Flutter package for managing network connectivity with real-time monitoring, automatic reconnection detection, and user-friendly snackbar notifications.


## Features

- 🔄 Real-time connectivity monitoring
- 📱 Automatic snackbar notifications for connection changes
- 🎨 Customizable UI components and messages
- 🚀 GetX integration for reactive state management
- 📶 Support for WiFi and mobile data detection
- ⚡ Lightweight and efficient
- 🛡️ Graceful error handling
- 🎯 Easy to integrate and use


# How to use this package,see below 
## Add these two lines in main().
## WidgetsFlutterBinding.ensureInitialized() and Get.put(ConnectionServices());  just below void main()
## see below 

void main() {
WidgetsFlutterBinding.ensureInitialized();  
Get.put(ConnectionServices()); 
runApp(const MyApp());
}
## see given image below to use this package

Example
! example_pic.png (example_pic/example_pic.png)
### Callbacks



## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_connectivity_service: ^2.0.2