// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';
import 'package:tcc_ll/src/bloc/cadastro.dart';
import 'package:tcc_ll/src/bloc/movimentacao.dart';
import 'package:tcc_ll/src/bloc/responsavel.dart';
import 'package:tcc_ll/src/views/ListarAfiliado.dart';
import 'package:tcc_ll/src/views/Perfil.dart';
import 'package:tcc_ll/src/views/TelaPrincipalResponsavel.dart';
import 'package:tcc_ll/src/views/anmition/fadeanimation.dart';
import 'package:tcc_ll/src/views/singup.dart';

// ignore: must_be_immutable
class CadastroAfiliado extends StatefulWidget {
  CadastroAfiliado({Key? key, required this.user, required this.responsalvel})
      : super(key: key);
  User user;
  bool responsalvel;
  @override
  State<CadastroAfiliado> createState() => _CadastroAfiliadoState();
}

class _CadastroAfiliadoState extends State<CadastroAfiliado> {
  int currentPage = 0;
  bool ispasswordev = true;
  Gender? selected;
  List movimentacao = [];

  final TextEditingController idAfiliadoController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();

  var bloc = MovimentacaoBloc();
  var blocCadastro = CadastroBloc();
  var blocResponsavel = ResponsavelBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 230, 46, 0),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => TelaPrincipalResponsavel(
                      user: widget.user,
                      responsavel: widget.responsalvel,
                    )));
          },
          iconSize: 30,
        ),
        title: const Text("Tela cadastro dependente"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: WaveClipperOne(),
              child: Container(
                height: 100,
                width: 450,
                color: const Color.fromARGB(255, 230, 46, 0),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            margin: const EdgeInsets.only(left: 49, right: 5),
                            child: Text("Cadastro de dependentes",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                  fontSize: 20,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: he * 0.04,
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
                  controller: idAfiliadoController,
                  decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.person_sharp,
                      color: Colors.white,
                    ),
                    hintText: 'ID dependente',
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
              height: he * 0.04,
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
                  controller: nomeController,
                  decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.person_sharp,
                      color: Colors.white,
                    ),
                    hintText: 'Nome dependente',
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
              height: he * 0.04,
            ),
            FadeAnimation(
              delay: 1,
              child: TextButton(
                onPressed: () async {
                  if (blocResponsavel
                      .validarUsuario(idAfiliadoController.text)) {
                    ResponsavelBloc.cadastroAfiliado(
                        userId: widget.user.uid,
                        idAfiliado: idAfiliadoController.text,
                        nome: nomeController.text);

                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => ListarAfiliado(
                              user: widget.user,
                              responsalvel: widget.responsalvel,
                            )));
                  } else {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      title: 'Oops...',
                      text: 'Essse id não existe!',
                    );
                  }
                },
                child: Text(
                  "Cadastrar dependente",
                  style: GoogleFonts.heebo(
                    color: Colors.white,
                    letterSpacing: 0.2,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(226, 171, 7, 177),
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 80),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: he * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}
