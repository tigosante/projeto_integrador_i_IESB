import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:personal_flow/app/shared/tasks_functions.dart';

class NewTask extends StatefulWidget {
  NewTask({Key key, @required this.toDoList}) : super(key: key);

  List toDoList;

  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  Map<String, dynamic> data_list = Map();
  bool press = true;
  TextEditingController controller_titulo = TextEditingController();
  List<TextEditingController> controller_sub = [TextEditingController()];

  @override
  Widget build(BuildContext context) {
    List toDoList = widget.toDoList;
    TasksProp tasksProp = TasksProp(context_screen: context);
    double size_screem = tasksProp.outScreenSize;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Nova Tarefa"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: size_screem * 0.05,
              left: size_screem * 0.07,
              right: size_screem * 0.07,
            ),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius:
                      BorderRadius.all(Radius.circular(size_screem * 0.02))),
              child: Padding(
                padding: EdgeInsets.only(left: size_screem * 0.02),
                child: TextField(
                  controller: controller_titulo,
                  decoration: InputDecoration(
                    labelText: "Título",
                    border: InputBorder.none,
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.transparent,
            height: size_screem * 0.05,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                      left: size_screem * 0.07,
                      right: size_screem * 0.07,
                    ),
                    itemCount: controller_sub.length,
                    itemBuilder: (BuildContext context, int index) =>
                        buildDetailsBody(context, index, size_screem),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        onPressed: () {
          setState(() {
            if (addToDo()) {
              Navigator.pop(context, toDoList);
            } else {
              Navigator.pop(context, null);
            }
          });
        },
        icon: Icon(
          Icons.add,
        ),
        label: Text(
          "Adicionar",
          style: TextStyle(fontFamily: 'Orkney-bold'),
        ),
      ),
    );
  }

  Widget buildDetailsBody(context, index, size_screem) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(size_screem * 0.02),
                topRight: Radius.circular(size_screem * 0.02),
                bottomLeft: Radius.circular(size_screem * 0.02),
              )),
          child: Padding(
            padding: EdgeInsets.only(left: size_screem * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: controller_sub[index],
                    decoration: InputDecoration(
                      hintText: "Tarefa",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                    maxLines: 8,
                    minLines: 1,
                  ),
                ),
                controller_sub[index] ==
                        controller_sub[controller_sub.length - 1]
                    ? IconButton(
                        color: Colors.blue[600],
                        icon: Icon(
                          Icons.add_circle,
                        ),
                        onPressed: () {
                          setState(() {
                            controller_sub.add(TextEditingController());
                          });
                        },
                      )
                    : IconButton(
                        color: Colors.red[600],
                        icon: Icon(
                          Icons.remove_circle_outline,
                        ),
                        onPressed: () {
                          setState(() {
                            List toDoNovo = [];
                            Map<String, dynamic> toDo = Map();
                            Map<String, dynamic> toNovo = Map();

                            controller_sub.removeAt(index);
                            data_list["$index"] = null;

                            toDo = Map.from(data_list);

                            for (int i = 0; i <= toDo.length; i++) {
                              if (toDo["$i"] != null) {
                                toDoNovo.add(toDo["$i"]);
                              }
                            }

                            for (int i = 0; i < toDoNovo.length; i++) {
                              toNovo["$i"] = toDoNovo[i];
                            }

                            data_list = toNovo;
                          });
                        },
                      ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[dataHora(context, size_screem, index)],
        ),
        Divider(
          color: Colors.transparent,
          height: size_screem * 0.02,
        ),
      ],
    );
  }

  Widget dataHora(context, size_screem, index) {
    IconButton bt_calendar = IconButton(
        color: Colors.blue[600],
        icon: Icon(
          Icons.calendar_today,
        ),
        onPressed: () {});

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(size_screem * 0.02),
                bottomLeft: Radius.circular(size_screem * 0.02),
                bottomRight: Radius.circular(size_screem * 0.02),
              )),
          child: dtHr(context, index, size_screem),
        ),
        data_list["$index"] == null
            ? bt_calendar
            : data_list["$index"]["data_form"] == null
                ? bt_calendar
                : IconButton(
                    color: Colors.red[600],
                    icon: Icon(
                      Icons.close,
                    ),
                    onPressed: () {
                      setState(() {
                        data_list["$index"]["data_form"] = null;
                        data_list["$index"]["hora"] = null;
                      });
                    },
                  ),
      ],
    );
  }

  Widget dtHr(context, index, size_screem) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        InkWell(
          child: Container(
            margin: EdgeInsets.only(
              top: size_screem * 0.02,
              left: size_screem * 0.02,
              right: size_screem * 0.02,
              bottom: size_screem * 0.02,
            ),
            child: Text(
              data_list["$index"] == null
                  ? "Data"
                  : data_list["$index"]["data_form"] == null
                      ? "Data"
                      : data_list["$index"]["data_form"],
              style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: size_screem * 0.025,
                  fontFamily: 'Orkney-bold'),
            ),
          ),
          onTap: () async {
            final DateTime picked = await showDatePicker(
              context: context,
              firstDate: new DateTime(2000),
              lastDate: new DateTime(2030),
              initialDate: new DateTime.now(),
            );
            setState(() {
              DataHora dataHora = DataHora(picked: picked);
              data_list["$index"] = dataHora.calendario();
            });
          },
        ),
        Text(
          "-",
          style: TextStyle(
              color: Colors.blue[600],
              fontSize: size_screem * 0.025,
              fontFamily: 'Orkney-bold'),
        ),
        data_list["$index"] == null
            ? Text(
                "   Hora   ",
                style: TextStyle(
                    color: Colors.blue[600],
                    fontSize: size_screem * 0.025,
                    fontFamily: 'Orkney-bold'),
              )
            : data_list["$index"]["data_form"] == null ?
            Text(
                "   Hora   ",
                style: TextStyle(
                    color: Colors.blue[600],
                    fontSize: size_screem * 0.025,
                    fontFamily: 'Orkney-bold'),
              ) 
              :InkWell(
                child: Container(
                  margin: EdgeInsets.only(
                    top: size_screem * 0.02,
                    left: size_screem * 0.02,
                    right: size_screem * 0.02,
                    bottom: size_screem * 0.02,
                  ),
                  child: Text(
                    data_list["$index"]["hora"] == null || data_list["$index"]["hora"] == ""
                        ? "Hora"
                        : data_list["$index"]["hora"],
                    style: TextStyle(
                        color: Colors.blue[600],
                        fontSize: size_screem * 0.025,
                        fontFamily: 'Orkney-bold'),
                  ),
                ),
                onTap: () async {
                  final TimeOfDay picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  setState(() {
                    DataHora dataHora = DataHora(picked: picked);
                    String retorno = dataHora.hora().toString();
                    if(retorno != "null"){
                      data_list["$index"]["hora"] = retorno;
                    }else{
                      data_list["$index"]["hora"] = null;
                    }
                  });
                },
              )
      ],
    );
  }

  addToDo() {
    if (controller_titulo.text.trim() != "") {
      Map<String, dynamic> newToDo = Map();
      Map<String, dynamic> details = Map();

      newToDo["title"] = controller_titulo.text.trim();
      newToDo["ok"] = false;

      for (int i = 0; i < controller_sub.length; i++) {
        if (controller_sub[i].text.trim() != "") {
          Map<String, dynamic> content = Map();

          if(data_list["$i"] != null){
            content["hora"] = data_list["$i"]["hora"];
            content["data_form"] = data_list["$i"]["data_form"];
          }

          content["title"] = controller_sub[i].text.trim();
          content["bool"] = false;
          
          details["$i"] = content;
        }
      }

      newToDo["details"] = details;

      widget.toDoList.insert(0, newToDo);

      return true;
    } else {
      return false;
    }
  }
}
