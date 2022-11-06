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
        backgroundColor: const Color.fromARGB(187, 171, 7, 177),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              ClipPath(
                clipper: WaveClipperOne(),
                child: Container(
                  height: 100,
                  color: const Color.fromARGB(187, 171, 7, 177),
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
                    color: const Color.fromARGB(255, 241, 67, 24),
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
                    color: const Color.fromARGB(255, 241, 67, 24),
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
                      hintText: 'Data nascimento',
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
                    color: const Color.fromARGB(255, 241, 67, 24),
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
                        offColor: Colors.red,
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
                      "Você é responsalvel por alguém?",
                      style: TextStyle(
                          color: Color.fromARGB(255, 241, 67, 24),
                          fontWeight: FontWeight.bold),
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
                        activeColor: Color.fromARGB(255, 241, 67, 24),
                        value: bloc.termo,
                        onChanged: (value) {
                          setState(() => bloc.termo = !bloc.termo);
                        },
                      ),
                    ),
                    const Text(
                      "Aceita os termos de compromisso?",
                      style: TextStyle(
                          color: Color.fromARGB(255, 241, 67, 24),
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.text_snippet_sharp),
                      color: Colors.deepOrange,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Termos de condição."),
                                content: const Text(
                                    "Por este instrumento particular de Contrato de Prestação de Serviços, de um lado a, (Aplicativo desenvolvido pela estudante Ana Caroline), com sede a rua Mário de barros, nº 922, residência – Centro Sul – Dois Vizinhos - Paraná, CEP nº 85660-000, doravante denominada simplesmente  CONTRATADA, e de outro lado, como CONTRATANTE  a pessoa física/ jurídica identificada no “TERMO DE ADESÃO” , tem entre si justo e acordado uma vez aceita a referida proposta, o que se segue”: 1- OBJETO Na qualidade de prestador de serviços de controle financeiro para jovens e adolescentes, a CONTRATADA  coloca a disposição da CONTRATANTE os serviços de serviços de controle financeiro para jovens e adolescentes  via online descritos no “TERMO DE ADESÃO”. – Os serviços oferecidos são: - Cadastro de progressão e conclusão de objetivos. - Anotações de depósitos e saques. - Movimentações e gráficos referentes a das as ações realizadas pelo afiliado no aplicativo. - Controle para os responsáveis referentes as movimentações realizadas pelos jovens e adolescentes. - Disponibilização de conquistas referentes a progressão do usuário. 3 – DAS OBRIGAÇÕES DA CONTRATADA 3.1 – A  CONTRATADA disponibilizará um “username” (“Nome do Usuário”) e um “password” (“Senha de Acesso”), “Data de Nascimento”(Data de nascimento do usuário), “Telefone” e “Email”   que serão sua identificação junto a CONTRATADA; 3.2 – A CONTRATADA disponibilizará os serviços ora contratados e manterá os serviços conforme o plano escolhido pela CONTRATANTE especificado no Termo de Adesão, enviando a CONTRATANTE as informações via e-mail, ao endereço previamente fornecido pela  CONTRATANTE. 3.3 – A CONTRATADA envidará os melhores esforços para assegurar e desenvolver a qualidade do serviço ora contratado, comprometendo-se ainda, a respeitar a privacidade do CONTRATANTE, garantindo que não divulgara sua senha de acesso ou e-mail de acesso. Não será efetuada nenhum tipo de MULTA/REAJUSTE devido aos serviços fornecidos serem completamente gratuitos. Sendo contratado o acesso à Prestação de Serviços via on-line (Aplicativo móvel), o mesmo poderá, eventualmente, sofrer interrupções devido a: (a) manutenções técnicas e/ou operacionais que exijam o desligamento temporário do sistema ou impossibilitem o acesso; (b) casos fortuitos ou força maior; (c) falta de fornecimento de energia elétrica para o sistema da CONTRATADA; (e) ocorrências de falhas no sistema de transmissão e/ou roteamento no acesso à internet;"),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
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
                    backgroundColor: const Color.fromARGB(255, 230, 46, 0),
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
