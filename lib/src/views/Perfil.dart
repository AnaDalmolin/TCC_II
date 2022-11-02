// ignore_for_file: prefer_const_constructors
import 'package:avatars/avatars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_bottom_navigation_2/fancy_bottom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_ll/src/bloc/cadastro.dart';
import 'package:tcc_ll/src/bloc/movimentacao.dart';
import 'package:tcc_ll/src/views/TelaConquista.dart';
import 'package:tcc_ll/src/views/TelaDepositoSaque.dart';
import 'package:tcc_ll/src/views/TelaPrincipalResponsavel.dart';
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            print(widget.responsavel);
            if (widget.responsavel) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => TelaPrincipalResponsavel(
                        user: widget.user,
                        responsavel: widget.responsavel,
                      )));
            } else {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => TelaInicial(
                        user: widget.user,
                      )));
            }
          },
          iconSize: 30,
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
            stream: CadastroBloc.readItems(userId: widget.user.uid),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }
              if (snapshot.hasData || snapshot.data != null) {
                var doc = snapshot.data!.docs[0];
                var data = doc.data() as Map;
                return Column(
                  children: [
                    Center(
                      heightFactor: 1.5,
                      child: Avatar(
                        elevation: 3,
                        shape: AvatarShape.rectangle(
                            200, 200, BorderRadius.all(Radius.circular(30.0))),
                        name: data['Nome'],
                      ),
                    ),
                    SizedBox(
                      height: he * 0.01,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 5),
                      child: Text(data['Nome'],
                          style: GoogleFonts.poppins(
                            color: Colors.deepOrange,
                            letterSpacing: 0.5,
                            fontSize: 30,
                          )),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 45, right: 5),
                          child: Text("ID: ",
                              style: GoogleFonts.poppins(
                                color: Colors.deepOrange,
                                letterSpacing: 0.5,
                                fontSize: 25,
                              )),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 5, right: 5),
                          child: Text(doc.id,
                              style: GoogleFonts.poppins(
                                color: Colors.purple[900],
                                letterSpacing: 0.5,
                                fontSize: 20,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: he * 0.04,
                    ),
                    TextButton(
                      onPressed: () {},
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: he * 0.02,
                    ),
                    TextButton(
                      onPressed: () {},
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: he * 0.02,
                    ),
                    TextButton(
                      onPressed: () {},
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.orangeAccent,
                  ),
                ),
              );
            }),
      ),
    );
  }
}
