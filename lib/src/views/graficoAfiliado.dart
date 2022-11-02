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
import 'package:tcc_ll/src/views/singup.dart';

// ignore: must_be_immutable
class GraficoAfiliado extends StatefulWidget {
  GraficoAfiliado(
      {Key? key,
      required this.user,
      required this.responsalvel,
      required this.afiliado})
      : super(key: key);
  User user;
  bool responsalvel;
  String afiliado;
  @override
  State<GraficoAfiliado> createState() => _GraficoAfiliadoState();
}

class _GraficoAfiliadoState extends State<GraficoAfiliado> {
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
        title: const Text("Relatório do afiliado"),
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
                            margin: const EdgeInsets.only(left: 130, right: 5),
                            child: Text("Relatório",
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
            TextButton(
              onPressed: () {},
              child: Text(
                "Gráfico movimento",
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
              height: he * 0.03,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Objetivos",
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
              height: he * 0.03,
            ),
            const Divider(
              height: 5,
              thickness: 4,
              indent: 10,
              endIndent: 10,
              color: Color.fromARGB(255, 230, 46, 0),
            ),
            SizedBox(
              height: he * 0.03,
            ),
            Text("Historico de movimentação",
                style: GoogleFonts.poppins(
                  color: Colors.deepPurple,
                  letterSpacing: 0.5,
                  fontSize: 22,
                )),
            SizedBox(
              height: he * 0.03,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: MovimentacaoBloc.readItemsHistorico(
                    userId: widget.afiliado),
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
                            bool movimento = data['movimentacao'];
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
                                        color: movimento == true
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(movimento == true
                                                ? Icons.currency_exchange
                                                : Icons.remove_circle_outline),
                                            color: Colors.white,
                                            onPressed: () {},
                                            iconSize: 30,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                              movimento
                                                  ? 'Deposito:'
                                                  : 'Saque:',
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                letterSpacing: 0.5,
                                                fontSize: 22,
                                              )),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          IconButton(
                                            icon: Icon(
                                                Icons.attach_money_outlined),
                                            color: Colors.white,
                                            onPressed: () {},
                                            iconSize: 30,
                                          ),
                                          Text(data['valor'].toString(),
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                letterSpacing: 0.2,
                                                fontSize: 22,
                                              )),
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
