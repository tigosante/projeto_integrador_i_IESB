import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

String chenal = "";
String chenal_type = "";
int chenal_id = 0;

NotificationDetails get _ongoing{
  final androidChannelSpecifics = AndroidNotificationDetails(
    chenal, 
    "chanel $chenal$chenal_id}",
    "notificações de tarefas da categoria $chenal_type",
    importance: Importance.Max,
    priority: Priority.High,
    ongoing: false,
    autoCancel: true,
    style: AndroidNotificationStyle.BigText,
  );

  final iosChannelSpecifics = IOSNotificationDetails();
  return NotificationDetails(androidChannelSpecifics, iosChannelSpecifics);
}

Future showOngoingNotification(
  FlutterLocalNotificationsPlugin notifications,{
    @required String title,
    @required String body,
    @required int id = 0,
    @required Time notificationTime,
    @required Day dayNotification
  }
)=> _showNotifications(notifications, title: title, body: body, id: id, type: _ongoing, time: notificationTime, day: dayNotification);

Future _showNotifications(
  FlutterLocalNotificationsPlugin notifications, {
    @required String title,
    @required String body,
    @required NotificationDetails type,
    @required int id,
    @required Day day,
    Time time,
  }) => 
  // notifications.show(id, title, body, type,);
  notifications.showDailyAtTime(id, title, body, time,type);
  // notifications.showWeeklyAtDayAndTime(id, title, body, day,time,type);
  // notifications.periodicallyShow(0, title, body, RepeatInterval.EveryMinute,type);

class Notificacao{
  dynamic tarefa;
  dynamic notifications;
  int id_chanel;
  List agendadas;

  dynamic filtro(){
    if(tarefa["details"] == null){
      chenal = tarefa["title"];
      chenal_id = id_chanel;
      chenal_type = "simples";

      if(tarefa["data_form"] != null){
        if(tarefa["hora"] != null){
          if(tarefa["agendada"]){
            print("Agenada: ${tarefa["agendada"]}");
          }else{
            showOngoingNotification(notifications,
              title: tarefa["title"],
              body: "Sua tarefa está chegando ao fim!\nConfere se você não esqueceu nada.",
              id: id_chanel,
              notificationTime: Time(int.parse(tarefa["hora"].split(":")[0].trim()), int.parse(tarefa["hora"].split(":")[1].trim())),
              dayNotification: Day(int.parse(tarefa["data_form"].split(" ")[1].trim()))
            );
          }
        }else{
          print("simples: data");
        }
      }
    }else{
      print("Composta");
    }
  }

  // int trata_data(data){

  // }

  // dynamic 

  Notificacao({this.tarefa, this.notifications, this.id_chanel, this.agendadas});
}