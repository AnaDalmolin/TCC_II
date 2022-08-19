import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_ll/src/views/singup.dart';

import 'anmition/fadeanimation.dart';

enum Gender {
  // ignore: constant_identifier_names
  Email,
  password,
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Color enabled = Colors.white;
  Color enabledtxt = Colors.white;
  Color deaible = Colors.white;
  Color backgroundColor = Color.fromARGB(255, 230, 46, 0);
  bool ispasswordev = true;
  Gender? selected;

  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: const Color.fromARGB(187, 171, 7, 177),
        body: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: we,
              height: he,
              child: Column(
                children: <Widget>[
                  FadeAnimation(
                    delay: 0.8,
                    child: Image(
                      image: const AssetImage('assets/handy-finance.gif'),
                      width: we * 0.9,
                      height: he * 0.4,
                      alignment: Alignment.center,
                    ),
                  ),
                  SizedBox(
                    height: he * 0.01,
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
                          hintText: 'Email',
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
                          color: Color.fromARGB(255, 241, 67, 24)),
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
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
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Login",
                          style: GoogleFonts.heebo(
                            color: Colors.white,
                            letterSpacing: 0.5,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 230, 46, 0),
                            padding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 80),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)))),
                  ),
                  SizedBox(
                    height: he * 0.01,
                  ),
                  FadeAnimation(
                    delay: 1,
                    child: Text("Esqueceu sua senha?",
                        style: GoogleFonts.heebo(
                          color: Colors.white,
                          letterSpacing: 0.5,
                        )),
                  ),
                  SizedBox(height: he * 0.12),
                  FadeAnimation(
                    delay: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Ainda Não tem conta? ",
                            style: GoogleFonts.heebo(
                              color: Colors.white,
                              letterSpacing: 0.5,
                            )),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return const Singup();
                            }));
                          },
                          child: Text("Cadastre-se",
                              style: GoogleFonts.heebo(
                                color: Color.fromARGB(255, 230, 46, 0)
                                    .withOpacity(0.9),
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
