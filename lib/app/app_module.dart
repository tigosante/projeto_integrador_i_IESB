import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personalflow/app/app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:personalflow/app/app_widget.dart';
import 'package:personalflow/app/screens/home/home_controller.dart';
import 'package:personalflow/app/screens/home/home_module.dart';
import 'package:personalflow/app/screens/home/pages/simples/simples_controller.dart';
import 'package:personalflow/app/screens/login/login_controller.dart';
import 'package:personalflow/app/screens/login/login_module.dart';
import 'package:personalflow/app/screens/nova_tarefa/nova_tarefa_controller.dart';
import 'package:personalflow/app/screens/nova_tarefa/nova_tarefa_module.dart';
import 'package:personalflow/app/screens/splash/splash_page.dart';
import 'package:personalflow/core/controller/login/auth_controller.dart';
import 'package:personalflow/core/model/composta/composed_repository.dart';
import 'package:personalflow/core/model/composta/composed_repository.interface.dart';
import 'package:personalflow/core/model/login/email/email_interface.dart';
import 'package:personalflow/core/model/login/email/email_repository.dart';
import 'package:personalflow/core/model/login/google/google_interface.dart';
import 'package:personalflow/core/model/login/google/google_repository.dart';
import 'package:personalflow/app/screens/home/pages/composta/composta_controller.dart';
import 'package:personalflow/core/model/simples/simple_repository.dart';
import 'package:personalflow/core/model/simples/simple_repository.interface.dart';

import 'componentes/barra_pesquisa/barra_pesquisa_controller.dart';
import 'componentes/icone_user/icone_user_controller.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind((i) => HomeController()),
        Bind((i) => LoginController()),
        Bind((i) => AuthController()),
        Bind((i) => IconUserController()),
        Bind((i) => BarraPesquisaController()),
        Bind((i) => NovaTarefaController()),
        Bind((i) => SimplesController(i.get())),
        Bind<ISimpleRepository>(
            (i) => TarefaSimplesRepository(Firestore.instance)),
        Bind<EmailInterface>((i) => LoginEmailRepository()),
        Bind<GoogleInterface>((i) => LoginGoogleRepository()),
        Bind((i) => CompostaController(i.get())),
        Bind<IComposedRepository>(
            (i) => TarefaCompostaRepository(Firestore.instance)),
      ];

  @override
  List<Router> get routers => [
        Router("/", child: (_, args) => SplashPage()),
        Router("/home", module: HomeModule()),
        Router("/login", module: LoginModule()),
        Router("/adicionar_tarefa", module: NovaTarefaModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
