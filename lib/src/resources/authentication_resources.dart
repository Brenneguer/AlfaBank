
import 'package:alfa_banck/src/modules/usuario.dart';
import 'package:alfa_banck/src/resources/repository/persistationDb.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthenticationResources {
  //implementei firebase Auth para que nessa classe eu tenha acesso a todos os metodos do firebase
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //Recebe no seu fluxo objetos do tipo do firebase user, contem todas as informações do usuario atual logado
  Stream<User> get onAuthStateChange => _firebaseAuth.authStateChanges();

  Future<int> cadastrarComEmailAndSenha(Usuario usuario) async {
    try {
      print("Authentication Resources tentando cadastrar usuario: ${usuario.email}, ${usuario.senha}");
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: usuario.email, password: usuario.senha);
      await persistenceService.adicionarUsuario(usuario);
      return 1;
    } on PlatformException catch (e) {
      print('Platform Exception: Authentication ${e.toString()}');
      return -1;
    } catch (e) {
      print('Exception: Authenticaton ${e.toString()}');
      return -2;
    }
  }

  Future<int> loginComEmailAndSenha(String email, String senha) async {
    try {
      print('tentando: $email, senha: $senha');
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: senha);
      return 1;
    } on PlatformException catch(e) {
      print('Platform exception: AuthenticationResources ${e.toString()}');
      return -1;
    } catch (e) {
      print('Exception: AuthenticationResources ${e.toString()}');
      return -2;
    }
  }

  Future<void> get sair async {
    _firebaseAuth.signOut();
  }

  //TODO ESCREVER METODO LINHA 40 authentication_resources.dart

}
