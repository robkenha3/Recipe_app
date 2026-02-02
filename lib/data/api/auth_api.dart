import 'package:firebase_auth/firebase_auth.dart';

class AuthApi {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> register({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      print('Erro no registro: ${e.message}');
      rethrow;
    } catch (e) {
      print('Erro inesperado no registro: $e');
      return null;
    }
  }

  Future<User?> login({required String email, required String password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      print('Erro no login: ${e.message}');
      rethrow;
    } catch (e) {
      print('Erro inesperado no login: $e');
      return null;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;

  /// Stream para monitorar login e logout
  Stream<User?> authStateChanges() => _auth.authStateChanges();
}
