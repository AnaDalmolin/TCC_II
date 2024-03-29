import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_ll/src/bloc/cadastro.dart';

import 'anmition/fadeanimation.dart';
import 'login.dart';

// ignore: constant_identifier_names
enum Gender { fullname, Email, password, confirmpassword, phone }

class Singup extends StatefulWidget {
  const Singup({Key? key}) : super(key: key);

  @override
  _SingupState createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Color enabled = Colors.white;
  Color enabledtxt = Colors.white;
  Color deaible = Colors.white;
  Color backgroundColor = const Color.fromARGB(188, 13, 172, 40);
  bool ispasswordev = true;
  Gender? selected;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController confSenhaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  var bloc = CadastroBloc();

  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: he * 0.02,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: we * 0.04),
                    child: const Icon(
                      Icons.arrow_back_outlined,
                      color: Colors.white,
                      size: 35.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: he * 0.03,
                ),
                FadeAnimation(
                  delay: 1,
                  child: Container(
                    margin: const EdgeInsets.only(right: 80.0),
                    child: Text(
                      "Criar sua conta",
                      style: GoogleFonts.heebo(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          letterSpacing: 2),
                    ),
                  ),
                ),
                SizedBox(height: he * 0.07),
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
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: emailController,
                      onTap: () {
                        setState(() {
                          selected = Gender.Email;
                        });
                      },
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color:
                              selected == Gender.Email ? enabledtxt : deaible,
                        ),
                        hintText: 'E-mail',
                        hintStyle: TextStyle(
                          color:
                              selected == Gender.Email ? enabledtxt : deaible,
                        ),
                      ),
                      style: TextStyle(
                          color:
                              selected == Gender.Email ? enabledtxt : deaible,
                          fontWeight: FontWeight.bold),
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
                        color: Colors.orange),
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: senhaController,
                      onTap: () {
                        setState(() {
                          selected = Gender.password;
                        });
                      },
                      decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.lock_open_outlined,
                            color: selected == Gender.password
                                ? enabledtxt
                                : deaible,
                          ),
                          suffixIcon: IconButton(
                            icon: ispasswordev
                                ? Icon(
                                    Icons.visibility_off,
                                    color: selected == Gender.password
                                        ? enabledtxt
                                        : deaible,
                                  )
                                : Icon(
                                    Icons.visibility,
                                    color: selected == Gender.password
                                        ? enabledtxt
                                        : deaible,
                                  ),
                            onPressed: () =>
                                setState(() => ispasswordev = !ispasswordev),
                          ),
                          hintText: 'Senha',
                          hintStyle: TextStyle(
                              color: selected == Gender.password
                                  ? enabledtxt
                                  : deaible)),
                      obscureText: ispasswordev,
                      style: TextStyle(
                          color: selected == Gender.password
                              ? enabledtxt
                              : deaible,
                          fontWeight: FontWeight.bold),
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
                        color: Colors.orange),
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: confSenhaController,
                      onTap: () {
                        setState(() {
                          selected = Gender.confirmpassword;
                        });
                      },
                      decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.lock_open_outlined,
                            color: selected == Gender.confirmpassword
                                ? enabledtxt
                                : deaible,
                          ),
                          suffixIcon: IconButton(
                            icon: ispasswordev
                                ? Icon(
                                    Icons.visibility_off,
                                    color: selected == Gender.confirmpassword
                                        ? enabledtxt
                                        : deaible,
                                  )
                                : Icon(
                                    Icons.visibility,
                                    color: selected == Gender.confirmpassword
                                        ? enabledtxt
                                        : deaible,
                                  ),
                            onPressed: () =>
                                setState(() => ispasswordev = !ispasswordev),
                          ),
                          hintText: 'Confirme sua senha',
                          hintStyle: TextStyle(
                              color: selected == Gender.confirmpassword
                                  ? enabledtxt
                                  : deaible)),
                      obscureText: ispasswordev,
                      style: TextStyle(
                          color: selected == Gender.confirmpassword
                              ? enabledtxt
                              : deaible,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: he * 0.02,
                ),
                FadeAnimation(
                  delay: 1,
                  child: TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          User? user =
                              await CadastroBloc.registerUsingEmailPassword(
                            email: emailController.text,
                            password: senhaController.text,
                          );
                          if (user != null) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const Login()),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.redAccent,
                              content: Text(
                                'Dados invalido',
                                style: TextStyle(
                                  color: Colors.white,
                                  // background: Colors.white,
                                  decorationColor: Colors.white,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Cadastrar",
                        style: GoogleFonts.heebo(
                          color: Colors.white,
                          letterSpacing: 0.5,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 80),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)))),
                ),
                SizedBox(height: he * 0.1),
                FadeAnimation(
                  delay: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Já tem uma conta?",
                          style: GoogleFonts.heebo(
                            color: Colors.white,
                            letterSpacing: 0.5,
                          )),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const Login();
                          }));
                        },
                        child: Text("Logar",
                            style: GoogleFonts.heebo(
                              color: Colors.orange.withOpacity(0.9),
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: he * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
