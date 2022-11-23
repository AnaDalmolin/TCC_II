// ignore_for_file: deprecated_member_use

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';
import 'package:switcher_button/switcher_button.dart';
import 'package:tcc_ll/src/bloc/cadastro.dart';
import 'package:tcc_ll/src/views/TelaPrincipalResponsavel.dart';
import 'package:tcc_ll/src/views/telaPrincipal.dart';

import 'anmition/fadeanimation.dart';

class CadastroPerfil extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  CadastroPerfil({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  State<CadastroPerfil> createState() => _CadastroPerfilState();
}

class _CadastroPerfilState extends State<CadastroPerfil> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController dataNascimentoController =
      TextEditingController();
  var bloc = CadastroBloc();
  final format = DateFormat("dd-MM-yyyy");

  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    // print(widget.user);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bem vindo",
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              ClipPath(
                clipper: WaveClipperOne(),
                child: Container(
                  height: 100,
                  color: Colors.blueAccent,
                  child: Center(
                    child: Text(
                      "Cadastro dados básicos",
                      style: GoogleFonts.heebo(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          letterSpacing: 1),
                    ),
                  ),
                ),
              ),
              FadeAnimation(
                delay: 1,
                child: Container(
                  width: we * 0.9,
                  height: he * 0.071,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.orange,
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: nomeController,
                    onTap: () {},
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.person_pin_outlined,
                        color: Colors.white,
                      ),
                      hintText: 'Nome completo',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: he * 0.02,
              ),
              FadeAnimation(
                delay: 1,
                child: Container(
                  width: we * 0.9,
                  height: he * 0.071,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.orange,
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: DateTimeField(
                    controller: dataNascimentoController,
                    format: format,
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.date_range_outlined,
                        color: Colors.white,
                      ),
                      hintText: 'Data de nascimento',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2100));
                    },
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: he * 0.02,
              ),
              FadeAnimation(
                delay: 1,
                child: Container(
                  width: we * 0.9,
                  height: he * 0.071,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.orange,
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onTap: () {},
                    controller: telefoneController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      hintText: 'Telefone',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: he * 0.02,
              ),
              FadeAnimation(
                delay: 1,
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 5),
                      padding: const EdgeInsets.all(8.0),
                      child: SwitcherButton(
                        onColor: Colors.green,
                        offColor: Color.fromARGB(255, 233, 84, 14),
                        value: bloc.responsalvel,
                        onChange: (value) {
                          setState(() {
                            // ignore: unrelated_type_equality_checks
                            setState(
                                () => bloc.responsalvel = !bloc.responsalvel);
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: he * 0.02,
                    ),
                    const Text(
                      "Você é responsálvel por alguém?",
                      style: TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              FadeAnimation(
                delay: 1,
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 5),
                      child: Checkbox(
                        checkColor: Colors.white,
                        activeColor: Colors.orange,
                        value: bloc.termo,
                        onChanged: (value) {
                          setState(() => bloc.termo = !bloc.termo);
                        },
                      ),
                    ),
                    const Text(
                      "Aceita os termos de compromisso?",
                      style: TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.text_snippet_sharp),
                      color: Colors.orange,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Política de privacidade."),
                              content: const SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Text(
                                    "Ao utilizar as aplicações  Ana Caroline Dal Molin, você concorda com estas condições. Por gentileza, leia com atenção todas as informações. Caso não concorde com estas condições, não utilize a aplicação.  Sobre o Aplicativo É um aplicativo mobile, onde tem o intuído de fazer com que adolecentes e jovens aprendam a gerenciar seu dinheirode uma maneira organizada e divertida. No aplicativo é possível iniciar com alguns objetivos para guardar o dinheiro para comprar um determinado item que esse usuário deseja. Além disso é possível depositar algum valor direto no objetivo para saber o quanto já tem e quanto falta para conseguir alcançar. Além disso a aplicação, tem a opção de depositar e sacar valores que já foram inseridos na aplicação. Todas os calculos de quanto o usuário já tem na aplicação ou retirou fica armazenado nos históricos. Depois que o usuário já atingiu alguma conquista essa fica armazenada nas conquistas. Existe a possibilidade de ter um usuário que vai ser o responsável, no qual vai conseguir acompanhar as movimentações, objetivos e conquistas de se afiliados. Essa funcionalidade é para os pais terem controle sobre como os seus filhos estão gerenciando seu dinheiro e aonde está sendo gasto esses valores que estarem visiveis nas conquistas. CONTATO: anadv21@gmail.com. Princípios de Privacidade Sobre as principais práticas de privacidade: ● Essa aplicação foi desenvolvida para auxiliar os adolecentes e jovens a controlar sua vida financeira; ● As informações coletadas no aplicativo mobile vão ser utilizados somente para uso na aplicação; ● Não é feita a venda de informações pessoais ou quais quer tipos de informações coletadas no aplicativo. ● Suas informações são armazenadas em bancos de dados onde os dados sensíveis serão criptografados. CONTATO: anadv21@gmail.com. Informações pessoais que podemos coletar: As informações coletadas no aplicativo são as informações inseridas na hora do cadastro. Não vamos perdir para informar novamente os dados durante o usuário da aplicação. Os seus dados serão utilizados dentro da aplicação para exibição, autenticação e validação. CONTATO: anadv21@gmail.com. Mudanças na Política de privacidade Quaisquer mudanças que venham a ocorrer na política de privacidade ou em outra área da aplicação serão enviadas aos usuários através dos meios de comunicação como e-mail, redes sociais e até mesmo avisos no aplicativo. CONTATO: anadv21@gmail.com. Termos de serviço SUA CONTA Ao utilizar o aplicativo Ana Caroline Dal Molin você é responsável por manter a confidencialidade de sua conta e senha e restringir o acesso ao seu aparelho celular, e responsabiliza-se por todas as atividades que ocorram com sua conta ou sua senha.  reserva-se o direito de encerrar contas, remover ou editar conteúdo da aplicação; CONTATO: anadv21@gmail.com."),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      iconSize: 30,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: he * 0.02,
              ),
              FadeAnimation(
                delay: 1,
                child: TextButton(
                  onPressed: () async {
                    if (bloc.termo == false) {
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.warning,
                        title: 'Ops!',
                        text:
                            'Você prescisa concordar com os termos de compromisso!',
                        onConfirmBtnTap: () async {
                          Navigator.of(context).pop();
                        },
                      );
                    } else {
                      bloc.CadastroPerfil(
                          nomeController.text,
                          dataNascimentoController.text,
                          telefoneController.text,
                          bloc.responsalvel,
                          bloc.termo,
                          widget.user.uid);

                      bool responsavel =
                          await bloc.validarTipoUsuario(widget.user.uid);
                      if (responsavel) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => TelaPrincipalResponsavel(
                                    user: widget.user,
                                    responsavel: responsavel,
                                  )),
                        );
                      } else {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => TelaInicial(
                                    user: widget.user,
                                  )),
                        );
                      }
                    }
                  },
                  child: Text(
                    "Cadastrar informações",
                    style: GoogleFonts.heebo(
                      color: Colors.white,
                      letterSpacing: 0.2,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 80),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
