// ignore: file_names
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:switcher_button/switcher_button.dart';
import 'package:tcc_ll/src/bloc/cadastro.dart';

import 'anmition/fadeanimation.dart';

class CadastroPerfil extends StatefulWidget {
  const CadastroPerfil({Key? key}) : super(key: key);

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
                      "Cadastro Dados Básicos",
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
                      hintText: 'Nome Completo',
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
                      hintText: 'Data Nascimento',
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
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.email_outlined,
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
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: const Color.fromARGB(255, 241, 67, 24),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: SwitcherButton(
                        onColor: const Color.fromARGB(187, 171, 7, 177),
                        offColor: const Color.fromARGB(234, 250, 247, 247),
                        value: bloc.termo,
                        onChange: (value) {
                          setState(() {
                            // ignore: unrelated_type_equality_checks
                            bloc.termo == value;
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
                  ],
                ),
              ),
              SizedBox(
                height: he * 0.02,
              ),
              FadeAnimation(
                delay: 1,
                child: TextButton(
                  onPressed: () {
                    bloc.CadastroPerfil(
                        nomeController,
                        dataNascimentoController,
                        telefoneController,
                        bloc.responsalvel,
                        bloc.termo);
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
