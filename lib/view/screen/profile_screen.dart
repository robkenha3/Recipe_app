import 'package:flutter/material.dart';
import '../../data/api/auth_api.dart';
import 'edit_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final AuthApi _authApi = AuthApi();

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    // Usuário não logado
    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Meu Perfil",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 1,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.account_circle, size: 100, color: Colors.grey),
              const SizedBox(height: 20),
              const Text(
                "Você não está logado",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Faça login para acessar todos os recursos.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text("Login", style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      );
    }

    // Usuário logado - mostra perfil
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Meu Perfil",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),

            // Foto do perfil
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey[300],
                backgroundImage: AssetImage("assets/profile_placeholder.png"),
              ),
            ),

            const SizedBox(height: 20),

            // Nome do usuário
            Text(
              user.displayName ?? "Nome do Usuário",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),

            // Email
            Text(
              user.email ?? "usuario@email.com",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),

            const SizedBox(height: 20),
            const Divider(height: 30, thickness: 1),

            // Opções de perfil
            _buildOptionTile(
              icon: Icons.person,
              label: "Editar perfil",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfileScreen(),
                  ),
                );
              },
            ),

            _buildOptionTile(
              icon: Icons.favorite,
              label: "Favoritos",
              onTap: () {
                Navigator.pushNamed(context, "/favorites");
              },
            ),

            _buildOptionTile(
              icon: Icons.lock,
              label: "Alterar senha",
              onTap: () {
              },
            ),

            _buildOptionTile(
              icon: Icons.settings,
              label: "Configurações",
              onTap: () {
              },
            ),

            const SizedBox(height: 30),

            // Botão sair
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () async {
                  await _authApi.logout();
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text(
                  "Sair da conta",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Widget helper para opções da lista
  Widget _buildOptionTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, size: 28),
      title: Text(label, style: const TextStyle(fontSize: 18)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      onTap: onTap,
    );
  }
}
