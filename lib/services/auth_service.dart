import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register
  Future<User?> register(String name, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update display name
      await result.user?.updateDisplayName(name);
      await result.user?.reload(); // ✅ make sure displayName is updated

      return _auth.currentUser; // ✅ always return fresh user
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? "Registration failed");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  // Login
  Future<User?> login(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? "Login failed");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  // Stream user changes
  Stream<User?> get userStream => _auth.authStateChanges();
}
