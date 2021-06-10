import 'package:alfa_banck/src/modules/usuario.dart';
import 'package:alfa_banck/src/resources/repository.dart';
import 'package:alfa_banck/src/resources/repository/persistenceServiceUsers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerfilUsuario extends StatefulWidget {
  static const String routeName = "tela_user_detalhes";

  @override
  _PerfilUsuarioState createState() => _PerfilUsuarioState();
}

class _PerfilUsuarioState extends State<PerfilUsuario> {
  Usuario usuario = new Usuario("", "", "", "", "");

  void _initUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    usuario.nome = prefs.getString('nome');
    usuario.email = prefs.getString('email');
    usuario.telefone = prefs.getString('telefone');
    usuario.cpf = prefs.getString('cpf');
    if (usuario.nome != null) {
      setState(() {
        usuario = usuario;
      });
    }
  }

  @override
  void initState() {
    _initUsuario();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _initUsuario();

    return Container(
      child: usuario.nome != ""
          ? Scaffold(
              backgroundColor: Colors.redAccent,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.redAccent,
                centerTitle: true,
                title: Text('Meu Pefil'),
              ),
              body: Card(
                semanticContainer: true,
                color: Colors.redAccent,
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Nome: ${usuario.nome}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'CPF: ${usuario.cpf}',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'E-mail: ${usuario.email}',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Telefone: ${usuario.telefone}',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
