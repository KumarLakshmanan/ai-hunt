import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'contants/constants.dart';
import 'notification.dart';

showCallbackDialog(String message, Function onTap,
    {bool barrierDismissible = true, bool showCancel = true}) {
  Get.dialog(
    AlertDialog(
      content: Text(message),
      actions: <Widget>[
        if (showCancel)
          TextButton(
            child: const Text("Cancel"),
            onPressed: () {
              Get.back();
            },
          ),
        TextButton(
          child: const Text("Ok"),
          onPressed: () {
            onTap();
          },
        )
      ],
    ),
    barrierDismissible: barrierDismissible,
  );
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message from firebase");
  print(message.data);
  _messageHandler(message);
}

firebaseCloudMessagingListeners() {
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
    _messageHandler(message);
  });
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    _messageHandler(message);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    _messageHandler(message);
  });
}

Future<void> _messageHandler(RemoteMessage message) async {
  Map<String, dynamic> data = message.data;
  if (kDebugMode) {
    print(data);
  }
  await NotificationService().showNotify(
    body: data,
  );
}

Future<String> getAndroidRegId() async {
  try {
    if (!kIsWeb) {
      final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      String? androidRegId = await firebaseMessaging.getToken();
      await http.post(
        Uri.parse(
          '$apiUrl?mode=saveregid&regid=$androidRegId&version=1.0.0+1',
        ),
      );
      if (kDebugMode) {
        print('Android Reg Id: $androidRegId');
      }
      return androidRegId!;
    } else {
      return "";
    }
  } catch (e) {
    return "";
  }
}

MaterialColor createMaterialColor(Color color) {
  final strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (final strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

int getMilliSecondsTime(dynamic timeInEpoch) {
  if (timeInEpoch is String) {
    timeInEpoch = int.parse(timeInEpoch);
  }
  if (timeInEpoch.toString().length <= 11) {
    return timeInEpoch * 1000;
  } else {
    return timeInEpoch;
  }
}

convertEpochtoTimeAgo(int epoch) {
  epoch = getMilliSecondsTime(epoch);
  var date = DateTime.fromMillisecondsSinceEpoch(epoch);
  var now = DateTime.now();
  var difference = now.difference(date);
  var timeAgo = '';
  if (difference.inSeconds <= 0 ||
      difference.inSeconds > 0 && difference.inMinutes == 0 ||
      difference.inMinutes > 0 && difference.inHours == 0 ||
      difference.inHours > 0 && difference.inDays == 0) {
    timeAgo = DateFormat('hh:mm a').format(date);
  } else if (difference.inDays == 1) {
    timeAgo = 'Yesterday';
  } else {
    if (difference.inDays <= 30) {
      timeAgo = '${difference.inDays} days ago';
    } else if (difference.inDays > 30 && difference.inDays <= 365) {
      timeAgo = '${(difference.inDays / 30).floor()} months ago';
    } else {
      timeAgo = '${(difference.inDays / 365).floor()} years ago';
    }
  }
  return timeAgo;
}

snackbar(String title, String message, {bool success = false}) {
  Get.closeCurrentSnackbar();
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    animationDuration: const Duration(milliseconds: 300),
    borderRadius: 0,
    backgroundColor: Colors.white.withOpacity(0.1),
    colorText: Colors.white,
    margin: const EdgeInsets.all(0),
  );
}

Color generateRandomColor(String str) {
  int hash = 0;
  for (int i = 0; i < str.length; i++) {
    hash = str.codeUnitAt(i) + ((hash << 5) - hash);
  }
  final finalHash = hash.abs() % (256 * 256 * 256);
  final red = ((finalHash & 0xFF0000) >> 16);
  final blue = ((finalHash & 0xFF00) >> 8);
  final green = ((finalHash & 0xFF));
  return Color.fromRGBO(red, blue, green, 1);
}
