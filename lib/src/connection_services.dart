import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
//
// class ConnectionServices extends GetxController {
//   late Connectivity _connectivity;
//   RxBool isConnected = true.obs;
//   StreamSubscription? _streamSubscription;
//   bool _isGetXReady = false;
//   Timer? _readyCheckTimer;
//
//   final ConnectionConfig config;
//
//   ConnectionServices({ConnectionConfig? config})
//       : config = config ?? const ConnectionConfig() {
//     _connectivity = Connectivity();
//   }
// // changes for onInit made by Ritesh Sahu
//   @override
//   void onInit() {
//     super.onInit();
//     _waitForGetXToBeReady();
//   }
//
//   void _waitForGetXToBeReady() {
//     _readyCheckTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
//       try {
//         if (Get.context != null && Get.key.currentState != null) {
//           _isGetXReady = true;
//           timer.cancel();
//           checkInitialConnection();
//           listenToNetworkChanges();
//         }
//       } catch (e) {
//         // GetX not ready yet, continue waiting
//       }
//     });
//   }
//
//   Future<void> checkInitialConnection() async {
//     if (!_isGetXReady) return;
//
//     try {
//       final connectivityResult = await _connectivity.checkConnectivity();
//       final results = _normalizeConnectivityResult(connectivityResult);
//       _updateConnectionState(results);
//     } catch (e) {
//       debugPrint('Error checking initial connection: $e');
//     }
//   }
//
//   List<ConnectivityResult> _normalizeConnectivityResult(dynamic result) {
//     if (result is List<ConnectivityResult>) {
//       return result;
//     } else if (result is ConnectivityResult) {
//       return [result];
//     } else {
//       return [ConnectivityResult.none];
//     }
//   }
//
//   void _updateConnectionState(List<ConnectivityResult> connectivityResults) {
//     if (!_isGetXReady) return;
//
//     bool hasConnection = connectivityResults.any(
//             (result) => result != ConnectivityResult.none);
//
//     if (!hasConnection) {
//       debugPrint("No internet connection");
//       isConnected.value = false;
//       if (config.showNoInternetSnackbar) {
//         _showNoInternetSnackbar();
//       }
//     } else {
//       debugPrint("Internet connected");
//       isConnected.value = true;
//       _safeCloseSnackbar();
//       if (config.showConnectedSnackbar) {
//         _showConnectedSnackbar(connectivityResults);
//       }
//     }
//     update();
//   }
//
//   /// Safely closes any open snackbars
//   void _safeCloseSnackbar() {
//     try {
//       if (Get.isSnackbarOpen) {
//         Get.closeCurrentSnackbar();
//       }
//     } catch (e) {
//       debugPrint('Error closing snackbar: $e');
//     }
//   }
//
//   /// Shows no internet connection snackbar
//   void _showNoInternetSnackbar() {
//     if (!_isGetXReady) return;
//
//     try {
//       _safeCloseSnackbar();
//
//       Get.rawSnackbar(
//         messageText: Text(
//           config.noInternetMessage,
//           style: config.noInternetTextStyle,
//         ),
//         isDismissible: config.noInternetDismissible,
//         duration: config.noInternetDuration,
//         backgroundColor: config.noInternetBackgroundColor,
//         icon: Icon(
//           config.noInternetIcon,
//           color: config.noInternetIconColor,
//           size: config.iconSize,
//         ),
//         margin: config.margin,
//         borderRadius: config.borderRadius,
//         snackStyle: config.snackStyle,
//         snackPosition: config.snackPosition,
//       );
//     } catch (e) {
//       debugPrint('Error showing no internet snackbar: $e');
//     }
//   }
//
//   /// Shows connected snackbar with connection type information
//   void _showConnectedSnackbar(List<ConnectivityResult> connectivityResults) {
//     if (!_isGetXReady) return;
//
//     try {
//       String connectionType = "Back Online";
//       Color backgroundColor = config.connectedBackgroundColor;
//       IconData iconData = config.connectedIcon;
//
//       if (connectivityResults.contains(ConnectivityResult.wifi)) {
//         connectionType = config.wifiConnectedMessage;
//         backgroundColor = config.wifiBackgroundColor;
//         iconData = config.wifiIcon;
//       } else if (connectivityResults.contains(ConnectivityResult.mobile)) {
//         connectionType = config.mobileConnectedMessage;
//         backgroundColor = config.mobileBackgroundColor;
//         iconData = config.mobileIcon;
//       }
//
//       Get.rawSnackbar(
//         messageText: Text(
//           connectionType,
//           style: config.connectedTextStyle,
//         ),
//         isDismissible: config.connectedDismissible,
//         duration: config.connectedDuration,
//         backgroundColor: backgroundColor,
//         icon: Icon(
//           iconData,
//           color: config.connectedIconColor,
//           size: config.iconSize,
//         ),
//         margin: config.margin,
//         borderRadius: config.borderRadius,
//         snackStyle: config.snackStyle,
//         snackPosition: config.snackPosition,
//       );
//     } catch (e) {
//       debugPrint('Error showing connected snackbar: $e');
//     }
//   }
//
//   /// Starts listening to network connectivity changes
//   void listenToNetworkChanges() {
//     if (!_isGetXReady) return;
//
//     _streamSubscription = _connectivity.onConnectivityChanged.listen(
//           (connectivityResult) {
//         final results = _normalizeConnectivityResult(connectivityResult);
//         _updateConnectionState(results);
//       },
//       onError: (error) {
//         debugPrint('Error listening to connectivity changes: $error');
//       },
//     );
//   }
//
//   /// Manually check current connection status
//   /// Returns true if connected, false otherwise
//   Future<bool> checkConnection() async {
//     try {
//       final connectivityResult = await _connectivity.checkConnectivity();
//       final results = _normalizeConnectivityResult(connectivityResult);
//       bool hasConnection = results.any(
//               (result) => result != ConnectivityResult.none);
//       return hasConnection;
//     } catch (e) {
//       debugPrint('Error checking connection: $e');
//       return false;
//     }
//   }
//
//   @override
//   void onClose() {
//     _readyCheckTimer?.cancel();
//     _streamSubscription?.cancel();
//     _isGetXReady = false;
//     super.onClose();
//   }
// }
class ConnectionServices extends GetxController {
  late Connectivity _connectivity;
  RxBool isConnected = true.obs;
  StreamSubscription? _streamSubscription;
  bool _isGetXReady = false;
  Timer? _readyCheckTimer;

  final ConnectionConfig config;

  ConnectionServices({ConnectionConfig? config})
      : config = config ?? const ConnectionConfig() {
    _connectivity = Connectivity();
  }

  @override
  void onInit() {
    super.onInit();
    _waitForGetXToBeReady();
  }

  void _waitForGetXToBeReady() {
    _readyCheckTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      try {
        if (Get.context != null && Get.key.currentState != null) {
          _isGetXReady = true;
          timer.cancel();
          checkInitialConnection();
          listenToNetworkChanges();
        }
      } catch (e) {
        // GetX not ready yet, continue waiting
      }
    });
  }

  Future<void> checkInitialConnection() async {
    if (!_isGetXReady) return;

    try {
      final connectivityResult = await _connectivity.checkConnectivity();
      final results = _normalizeConnectivityResult(connectivityResult);
      // Just update the state without showing snackbars on initial check
      _updateConnectionState(results, isInitialCheck: true);
    } catch (e) {
      debugPrint('Error checking initial connection: $e');
    }
  }

  List<ConnectivityResult> _normalizeConnectivityResult(dynamic result) {
    if (result is List<ConnectivityResult>) {
      return result;
    } else if (result is ConnectivityResult) {
      return [result];
    } else {
      return [ConnectivityResult.none];
    }
  }

  void _updateConnectionState(List<ConnectivityResult> connectivityResults, {bool isInitialCheck = false}) {
    if (!_isGetXReady) return;

    bool hasConnection = connectivityResults.any(
            (result) => result != ConnectivityResult.none);

    if (!hasConnection) {
      debugPrint("No internet connection");
      isConnected.value = false;
      // Only show snackbar if not initial check
      if (!isInitialCheck && config.showNoInternetSnackbar) {
        _showNoInternetSnackbar();
      }
    } else {
      debugPrint("Internet connected");
      bool wasDisconnected = !isConnected.value;
      isConnected.value = true;
      _safeCloseSnackbar();
      // Only show connected snackbar if connection was previously lost (not on initial check)
      if (!isInitialCheck && wasDisconnected && config.showConnectedSnackbar) {
        _showConnectedSnackbar(connectivityResults);
      }
    }
    update();
  }

  /// Safely closes any open snackbars
  void _safeCloseSnackbar() {
    try {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    } catch (e) {
      debugPrint('Error closing snackbar: $e');
    }
  }

  /// Shows no internet connection snackbar
  void _showNoInternetSnackbar() {
    if (!_isGetXReady) return;

    try {
      _safeCloseSnackbar();

      Get.rawSnackbar(
        messageText: Text(
          config.noInternetMessage,
          style: config.noInternetTextStyle,
        ),
        isDismissible: config.noInternetDismissible,
        duration: config.noInternetDuration,
        backgroundColor: config.noInternetBackgroundColor,
        icon: Icon(
          config.noInternetIcon,
          color: config.noInternetIconColor,
          size: config.iconSize,
        ),
        margin: config.margin,
        borderRadius: config.borderRadius,
        snackStyle: config.snackStyle,
        snackPosition: config.snackPosition,
      );
    } catch (e) {
      debugPrint('Error showing no internet snackbar: $e');
    }
  }

  /// Shows connected snackbar with connection type information
  void _showConnectedSnackbar(List<ConnectivityResult> connectivityResults) {
    if (!_isGetXReady) return;

    try {
      String connectionType = "Back Online";
      Color backgroundColor = config.connectedBackgroundColor;
      IconData iconData = config.connectedIcon;

      if (connectivityResults.contains(ConnectivityResult.wifi)) {
        connectionType = config.wifiConnectedMessage;
        backgroundColor = config.wifiBackgroundColor;
        iconData = config.wifiIcon;
      } else if (connectivityResults.contains(ConnectivityResult.mobile)) {
        connectionType = config.mobileConnectedMessage;
        backgroundColor = config.mobileBackgroundColor;
        iconData = config.mobileIcon;
      }

      Get.rawSnackbar(
        messageText: Text(
          connectionType,
          style: config.connectedTextStyle,
        ),
        isDismissible: config.connectedDismissible,
        duration: config.connectedDuration,
        backgroundColor: backgroundColor,
        icon: Icon(
          iconData,
          color: config.connectedIconColor,
          size: config.iconSize,
        ),
        margin: config.margin,
        borderRadius: config.borderRadius,
        snackStyle: config.snackStyle,
        snackPosition: config.snackPosition,
      );
    } catch (e) {
      debugPrint('Error showing connected snackbar: $e');
    }
  }

  /// Starts listening to network connectivity changes
  void listenToNetworkChanges() {
    if (!_isGetXReady) return;

    _streamSubscription = _connectivity.onConnectivityChanged.listen(
          (connectivityResult) {
        final results = _normalizeConnectivityResult(connectivityResult);
        _updateConnectionState(results);
      },
      onError: (error) {
        debugPrint('Error listening to connectivity changes: $error');
      },
    );
  }

  /// Manually check current connection status
  /// Returns true if connected, false otherwise
  Future<bool> checkConnection() async {
    try {
      final connectivityResult = await _connectivity.checkConnectivity();
      final results = _normalizeConnectivityResult(connectivityResult);
      bool hasConnection = results.any(
              (result) => result != ConnectivityResult.none);
      return hasConnection;
    } catch (e) {
      debugPrint('Error checking connection: $e');
      return false;
    }
  }

  @override
  void onClose() {
    _readyCheckTimer?.cancel();
    _streamSubscription?.cancel();
    _isGetXReady = false;
    super.onClose();
  }
}
/// Configuration class for customizing ConnectionServices behavior
class ConnectionConfig {
  // Snackbar behavior
  final bool showNoInternetSnackbar;
  final bool showConnectedSnackbar;

  // No Internet Snackbar Configuration
  final String noInternetMessage;
  final bool noInternetDismissible;
  final Duration noInternetDuration;
  final Color noInternetBackgroundColor;
  final IconData noInternetIcon;
  final Color noInternetIconColor;
  final TextStyle noInternetTextStyle;

  // Connected Snackbar Configuration
  final String wifiConnectedMessage;
  final String mobileConnectedMessage;
  final bool connectedDismissible;
  final Duration connectedDuration;
  final Color connectedBackgroundColor;
  final Color wifiBackgroundColor;
  final Color mobileBackgroundColor;
  final IconData connectedIcon;
  final IconData wifiIcon;
  final IconData mobileIcon;
  final Color connectedIconColor;
  final TextStyle connectedTextStyle;

  // General Snackbar Styling
  final EdgeInsets margin;
  final double borderRadius;
  final double iconSize;
  final SnackStyle snackStyle;
  final SnackPosition snackPosition;

  const ConnectionConfig({
    this.showNoInternetSnackbar = true,
    this.showConnectedSnackbar = true,

    // No Internet Configuration
    this.noInternetMessage = "Please check your internet connection",
    this.noInternetDismissible = false,
    this.noInternetDuration = const Duration(days: 1),
    this.noInternetBackgroundColor = Colors.red,
    this.noInternetIcon = Icons.wifi_off,
    this.noInternetIconColor = Colors.white,
    this.noInternetTextStyle = const TextStyle(color: Colors.white, fontSize: 16),

    // Connected Configuration
    this.wifiConnectedMessage = "Connected via WiFi",
    this.mobileConnectedMessage = "Connected via Mobile Data",
    this.connectedDismissible = true,
    this.connectedDuration = const Duration(seconds: 3),
    this.connectedBackgroundColor = Colors.green,
    this.wifiBackgroundColor = Colors.blue,
    this.mobileBackgroundColor = Colors.green,
    this.connectedIcon = Icons.wifi,
    this.wifiIcon = Icons.wifi,
    this.mobileIcon = Icons.signal_cellular_4_bar,
    this.connectedIconColor = Colors.white,
    this.connectedTextStyle = const TextStyle(color: Colors.white, fontSize: 16),

    // General Styling
    this.margin = const EdgeInsets.all(10),
    this.borderRadius = 8.0,
    this.iconSize = 30.0,
    this.snackStyle = SnackStyle.FLOATING,
    this.snackPosition = SnackPosition.BOTTOM,
  });
}