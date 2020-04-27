import 'package:flutter/material.dart';
import 'package:personalflow/app/componentes/icone_user/componentes/info_user/infor_user.dart';
import 'package:personalflow/app/componentes/mudar_tema/mudar_tema.dart';

class ModalUser extends StatelessWidget {
  ModalUser({Key key, this.tamanhoTela}) : super(key: key);

  final double tamanhoTela;

  @override
  Widget build(BuildContext context) => Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[InfoUser(), Divider(), MudarTema()]);
}