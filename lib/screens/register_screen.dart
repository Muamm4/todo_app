import 'package:todo_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmaSenhaController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();

  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black54,
              Colors.purple[800]!,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // AppBar customizada
              Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    Text(
                      'Voltar',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo e título
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20,
                                offset: Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.person_add,
                            size: 60,
                            color: Colors.purple[600],
                          ),
                        ),
                        SizedBox(height: 24),
                        Text(
                          'Criar Conta',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 40),

                        // Card de cadastro
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20,
                                offset: Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Campo nome
                              _buildInputField(
                                controller: _nomeController,
                                hintText: 'Nome',
                                icon: Icons.person_outline,
                              ),
                              SizedBox(height: 16),

                              // Campo email
                              _buildInputField(
                                controller: _emailController,
                                hintText: 'E-mail',
                                icon: Icons.email_outlined,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(height: 16),

                              // Campo senha
                              _buildInputField(
                                controller: _senhaController,
                                hintText: 'Senha',
                                icon: Icons.lock_outline,
                                obscureText: true,
                              ),
                              SizedBox(height: 16),

                              // Campo confirmar senha
                              _buildInputField(
                                controller: _confirmaSenhaController,
                                hintText: 'Confirmar senha',
                                icon: Icons.lock_outline,
                                obscureText: true,
                              ),
                              SizedBox(height: 24),

                              // Botão cadastrar
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_senhaController.text == _confirmaSenhaController.text) {
                                      authService
                                          .registerUser(
                                        email: _emailController.text,
                                        senha: _senhaController.text,
                                        nome: _nomeController.text,
                                      )
                                          .then((String? erro) {
                                        if (!context.mounted) return;
                                        if (erro != null) {
                                          final snackBar = SnackBar(
                                            content: Text(erro),
                                            backgroundColor: Colors.red,
                                            behavior: SnackBarBehavior.floating,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                        } else {
                                          final snackBar = SnackBar(
                                            content: Text('Conta criada com sucesso!'),
                                            backgroundColor: Colors.purple[600],
                                            behavior: SnackBarBehavior.floating,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                          Navigator.pop(context);
                                        }
                                      });
                                    } else {
                                      const snackBar = SnackBar(
                                        content: Text('As senhas não são iguais.'),
                                        backgroundColor: Colors.red,
                                        behavior: SnackBarBehavior.floating,
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.purple[600],
                                    foregroundColor: Colors.white,
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    'Cadastrar',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(icon, color: Colors.grey[600]),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16),
        ),
      ),
    );
  }
}