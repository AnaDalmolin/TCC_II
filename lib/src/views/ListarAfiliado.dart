// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_ll/src/bloc/cadastro.dart';
import 'package:tcc_ll/src/bloc/movimentacao.dart';
import 'package:tcc_ll/src/bloc/responsavel.dart';
import 'package:tcc_ll/src/views/TelaPrincipalResponsavel.dart';
import 'package:tcc_ll/src/views/anmition/fadeanimation.dart';
import 'package:tcc_ll/src/views/graficoAfiliado.dart';
import 'package:tcc_ll/src/views/singup.dart';

// ignore: must_be_immutable
class ListarAfiliado extends StatefulWidget {
  ListarAfiliado({Key? key, required this.user, required this.responsalvel})
      : super(key: key);
  User user;
  bool responsalvel;
  @override
  State<ListarAfiliado> createState() => _ListarAfiliadoState();
}

class _ListarAfiliadoState extends State<ListarAfiliado> {
  int currentPage = 0;
  bool ispasswordev = true;
  bool responsalvel = false;
  Gender? selected;
  List movimentacao = [];

  final TextEditingController idAfiliadoController = TextEditingController();

  var bloc = MovimentacaoBloc();
  var blocCadastro = CadastroBloc();
  var blocResponsavel = ResponsavelBloc();

  @override
  void initState() {
    blocCadastro.IndentificarResponsavel(widget.user, responsalvel);

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
        title: const Text("Tela de listagem de dependentes"),
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
                            margin: const EdgeInsets.only(left: 80, right: 5),
                            child: Text("Lista de dependentes",
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
              height: he * 0.03,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: ResponsavelBloc.readItems(userId: widget.user.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                  } else if (snapshot.data != null) {
                    return SizedBox(
                      width: 350,
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            var doc = snapshot.data!.docs[index];
                            var data = doc.data() as Map<String, dynamic>;
                            return index > 5
                                ? SizedBox()
                                : FadeAnimation(
                                    delay: 1,
                                    child: Container(
                                      margin:
                                          const EdgeInsets.fromLTRB(0, 4, 0, 0),
                                      width: we * 0.6,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        color:
                                            Color.fromARGB(207, 152, 10, 165),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.family_restroom),
                                            color: Colors.white,
                                            onPressed: () {},
                                            iconSize: 30,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(data['nome'],
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                letterSpacing: 0.5,
                                                fontSize: 20,
                                              )),
                                          Spacer(),
                                          IconButton(
                                            icon: Icon(
                                                Icons.view_timeline_outlined),
                                            color: Colors.white,
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              GraficoAfiliado(
                                                                user:
                                                                    widget.user,
                                                                responsalvel: widget
                                                                    .responsalvel,
                                                                afiliado: data[
                                                                    'idAfiliado'],
                                                              )));
                                            },
                                            iconSize: 30,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                          }),
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
          ],
        ),
      ),
    );
  }
}
