// ignore_for_file: prefer_const_constructors
import 'package:avatars/avatars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_bottom_navigation_2/fancy_bottom_navigation.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_ll/src/bloc/cadastro.dart';
import 'package:tcc_ll/src/bloc/movimentacao.dart';
import 'package:tcc_ll/src/views/Perfil.dart';
import 'package:tcc_ll/src/views/TelaConquista.dart';
import 'package:tcc_ll/src/views/TelaDepositoSaque.dart';
import 'package:tcc_ll/src/views/anmition/fadeanimation.dart';
import 'package:tcc_ll/src/views/singup.dart';
import 'package:tcc_ll/src/views/telaObjetivo.dart';

// ignore: must_be_immutable
class TelaPrincipalResponsavel extends StatefulWidget {
  TelaPrincipalResponsavel({Key? key, required this.user}) : super(key: key);
  User user;
  @override
  State<TelaPrincipalResponsavel> createState() =>
      _TelaPrincipalResponsavelState();
}

class _TelaPrincipalResponsavelState extends State<TelaPrincipalResponsavel> {
  int currentPage = 0;
  bool ispasswordev = true;
  bool responsalvel = false;
  Gender? selected;
  List movimentacao = [];

  var bloc = MovimentacaoBloc();
  var blocCadastro = CadastroBloc();

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
        title: const Text("Tela Inicial"),
        backgroundColor: const Color.fromARGB(255, 230, 46, 0),
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
                        Avatar(
                          elevation: 3,
                          shape: AvatarShape.rectangle(
                              50, 50, BorderRadius.all(Radius.circular(20.0))),
                          name: 'Ana Dal Molin',
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => TelaPerfil(
                                  user: widget.user,
                                  responsavel: responsalvel,
                                ),
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            margin: const EdgeInsets.only(left: 20, right: 5),
                            child: Text("Ana Dal Molin",
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
              height: he * 0.02,
            ),
            FadeAnimation(
              delay: 1,
              child: ClipSmoothRect(
                child: Container(
                  width: 300,
                  height: 70,
                  decoration: ShapeDecoration(
                    gradient: LinearGradient(colors: const [
                      Colors.deepOrange,
                      Color.fromARGB(255, 221, 27, 37),
                    ]),
                    shape: SmoothRectangleBorder(
                      borderRadius: SmoothBorderRadius(
                        cornerRadius: 10,
                        cornerSmoothing: 0.5,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              margin: const EdgeInsets.only(),
                              child: IconButton(
                                icon: const Icon(Icons.remove_red_eye),
                                color: Colors.white,
                                onPressed: () {},
                                iconSize: 30,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              margin: const EdgeInsets.only(left: 20, right: 5),
                              child: Text("Saldo",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                    fontSize: 30,
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              margin: const EdgeInsets.only(left: 8, right: 5),
                              child: StreamBuilder<QuerySnapshot<Object?>>(
                                  stream: MovimentacaoBloc.readItems(
                                      userId: widget.user.uid),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      print('');
                                    } else if (snapshot.data?.docs.length ==
                                            0 ||
                                        snapshot.data == null) {
                                      return Text(
                                        '0.00',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          letterSpacing: 0.5,
                                          fontSize: 30,
                                        ),
                                      );
                                    } else if (snapshot.hasData ||
                                        snapshot.data != null) {
                                      var doc = snapshot.data!.docs[0];
                                      var data = doc.data() as Map;
                                      return Text(
                                        data['valor'].toString(),
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          letterSpacing: 0.5,
                                          fontSize: 30,
                                        ),
                                      );
                                    }
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Colors.orangeAccent,
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // padding: const EdgeInsets.all(8.0),
                ),
              ),
            ),
            SizedBox(
              height: he * 0.02,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: MovimentacaoBloc.readItems(userId: widget.user.uid),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }
                  if (snapshot.hasData) {
                    var doc = snapshot.data!.docs[0];
                    var data = doc.data() as Map<String, dynamic>?;
                    return Row(
                      children: [
                        FadeAnimation(
                          delay: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CadastroDepositoSaque(
                                              user: widget.user,
                                              movimento: false,
                                              docId: doc.id,
                                              saldoAtual: data!['valor'] ?? 0,
                                            )));
                              },
                              child: Text(
                                "Anotar Saque",
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
                          ),
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CadastroDepositoSaque(
                                                user: widget.user,
                                                movimento: true,
                                                docId: doc.id,
                                                saldoAtual:
                                                    data!['valor'] ?? 0)));
                              },
                              child: Text(
                                "Anotar Deposito",
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
            SizedBox(
              height: he * 0.02,
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
                    userId: widget.user.uid),
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
                                        color:
                                            Color.fromARGB(207, 152, 10, 165),
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
