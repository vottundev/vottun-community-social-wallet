import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';



class PushService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  late FirebaseMessaging fm;

  PushService();

  void initPushService() async {
    fm = FirebaseMessaging.instance;

    NotificationSettings settings = await fm.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (Platform.isIOS) {
        await FlutterLocalNotificationsPlugin().resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
              alert: true,
              badge: true,
              sound: false,
            );
      }
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        //await getAuthCubit().updateUserFCMToken(token);
      }
    } else {
      print('User declined or has not accepted permission');
    }

    initNotificationListener();
    listenOnTokenRefresh();

    await initNotificationsSettings();
  }

  void initNotificationListener() {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      AppleNotification? apple = message.notification?.apple;


      if (notification != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                  android?.channelId ?? 'social_wallet_channel_id',
                  'com.example.social_wallet',
                  channelDescription: "SocialWallet Notifications Channel",
                  icon: "@drawable/ic_notifications",
                  importance: Importance.max,
                  priority: Priority.high,
                ),
                iOS: DarwinNotificationDetails(
                    presentSound: apple?.sound != null,
                    sound: apple?.sound?.name,
                    subtitle: apple?.subtitle ?? "")),
            payload: json.encode(message.data));
      }

      }).onError((error) {
        print(error);
      });
  }

  void listenOnTokenRefresh() {
    fm.onTokenRefresh.listen((event) async {
      //await getAuthCubit().updateUserFCMToken(event);
    }).onError((error) {
      print(error);
    });
  }

  Future<void> initNotificationsSettings() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('ic_notifications');

    const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    InitializationSettings initializationSettings =
        const InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    
    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings
    );
  }

  Future<void> showLocalNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) async {
    //final platformChannelSpecifics = await _notificationDetails();
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      NotificationDetails(
          android: const AndroidNotificationDetails(
            'social_wallet_channel_id',
            'com.example.social_wallet',
            channelDescription: "SocialWallet Notifications Channel",
            icon: "@drawable/ic_notifications",
            importance: Importance.max,
            priority: Priority.max,
          ),
          iOS: DarwinNotificationDetails(
              presentSound: true,
              subtitle: body)),
      payload: payload,
    );
  }
}
