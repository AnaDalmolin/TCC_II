// ignore_for_file: prefer_const_constructors
import 'package:avatars/avatars.dart';
import 'package:fancy_bottom_navigation_2/fancy_bottom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_ll/src/bloc/movimentacao.dart';
import 'package:tcc_ll/src/views/TelaConquista.dart';
import 'package:tcc_ll/src/views/TelaDepositoSaque.dart';
import 'package:tcc_ll/src/views/singup.dart';
import 'package:tcc_ll/src/views/telaObjetivo.dart';
import 'package:tcc_ll/src/views/telaPrincipal.dart';

// ignore: must_be_immutable
class TelaPerfil extends StatefulWidget {
  TelaPerfil({Key? key, required this.user, required this.responsavel})
      : super(key: key);
  bool responsavel;
  User user;
  @override
  State<TelaPerfil> createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  int currentPage = 0;
  bool ispasswordev = true;
  Gender? selected;
  List movimentacao = [];

  var bloc = MovimentacaoBloc();

  @override
  void initState() {
    bloc.listarAnotacoesMovimentacao(widget.user, movimentacao);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil"),
        backgroundColor: const Color.fromARGB(255, 230, 46, 0),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              heightFactor: 1.5,
              child: Avatar(
                elevation: 3,
                shape: AvatarShape.rectangle(
                    200, 200, BorderRadius.all(Radius.circular(30.0))),
                name: 'Ana Dal Molin',
              ),
            ),
            SizedBox(
              height: he * 0.01,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 5),
              child: Text("Ana Dal Molin",
                  style: GoogleFonts.poppins(
                    color: Colors.deepOrange,
                    letterSpacing: 0.5,
                    fontSize: 30,
                  )),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 5),
              child: Text("ID #123123123",
                  style: GoogleFonts.poppins(
                    color: Colors.purple[900],
                    letterSpacing: 0.5,
                    fontSize: 20,
                  )),
            ),
            SizedBox(
              height: he * 0.04,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => CadastroDepositoSaque(
                          user: widget.user,
                          movimento: true,
                        )));
              },
              child: Text(
                "Trocar Foto",
                style: GoogleFonts.poppins(
                  color: const Color.fromARGB(255, 230, 46, 0),
                  letterSpacing: 0.2,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: TextButton.styleFrom(
                side: BorderSide(
                  width: 3.0,
                  color: const Color.fromARGB(255, 230, 46, 0),
                ),
                backgroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            SizedBox(
              height: he * 0.02,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => CadastroDepositoSaque(
                          user: widget.user,
                          movimento: true,
                        )));
              },
              child: Text(
                "Trocar Senha",
                style: GoogleFonts.poppins(
                  color: const Color.fromARGB(255, 230, 46, 0),
                  letterSpacing: 0.2,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: TextButton.styleFrom(
                side: BorderSide(
                  width: 3.0,
                  color: const Color.fromARGB(255, 230, 46, 0),
                ),
                backgroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            SizedBox(
              height: he * 0.02,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => CadastroDepositoSaque(
                          user: widget.user,
                          movimento: true,
                        )));
              },
              child: Text(
                "Termos de Condição",
                style: GoogleFonts.poppins(
                  color: Color.fromARGB(226, 171, 7, 177),
                  letterSpacing: 0.2,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: TextButton.styleFrom(
                side: BorderSide(
                  width: 3.0,
                  color: Color.fromARGB(226, 171, 7, 177),
                ),
                backgroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        circleColor: Colors.white,
        barBackgroundColor: const Color.fromARGB(255, 230, 46, 0),
        activeIconColor: const Color.fromARGB(255, 230, 46, 0),
        inactiveIconColor: Colors.white,
        textColor: Colors.white,
        tabs: [
          TabData(
            iconData: Icons.military_tech_outlined,
            title: "Conquistas",
            onclick: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => TelaConquista(
                        user: widget.user,
                      )));
            },
          ),
          TabData(
            iconData: Icons.home,
            title: "Inicio",
            onclick: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => TelaInicial(
                        user: widget.user,
                      )));
            },
          ),
          TabData(
              iconData: Icons.radar,
              title: "Objetivo",
              onclick: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => TelaObjetivo(
                          user: widget.user,
                        )));
              })
        ],
        initialSelection: 1,
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
          });
        },
      ),
    );
  }

  int index = 0;
  double leftWidth = 75.0;
  int leftTextColor = 1;
  int leftBackgroundColor = 0;
  double rightWidth = 75.0;
  int rightTextColor = 1;
  int rightBackgroundColor = 0;
  final List<Color> colorPallete = <Color>[
    Colors.white,
    Colors.black,
    Colors.blue,
    Colors.blueAccent,
    Colors.red,
    Colors.redAccent,
    Colors.teal,
    Colors.orange,
    Colors.pink,
    Colors.purple,
    Colors.lime,
    Colors.green
  ];
}
