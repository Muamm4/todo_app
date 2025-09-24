import 'package:todo_app/screens/register_screen.dart';
import 'package:todo_app/screens/reset_password_modal.dart';
import 'package:todo_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

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
              Colors.purple[600]!,
            ],  
          ),
        ),
        child: SafeArea(
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
                      Icons.checklist,
                      size: 60,
                      color: Colors.purple[600],
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'To Do App',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Organize suas tarefas',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  SizedBox(height: 40),

                  // Card de login
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
                        Text(
                          'Fazer Login',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                        SizedBox(height: 24),

                        // Campo de email
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: Colors.grey[200]),
                            decoration: InputDecoration(
                              hintText: 'E-mail',
                              prefixIcon: Icon(Icons.email_outlined, color: Colors.grey[200]),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(16),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),

                        // Campo de senha
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: TextField(
                            obscureText: true,
                            controller: _senhaController,
                            style: TextStyle(color: Colors.grey[200]),
                            decoration: InputDecoration(
                              hintText: 'Senha',
                              prefixIcon: Icon(Icons.lock_outline, color: Colors.grey[200]),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(16),
                            ),
                          ),
                        ),
                        SizedBox(height: 24),

                        // Botão de login
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              authService
                                  .loginUser(
                                email: _emailController.text,
                                senha: _senhaController.text,
                              )
                                  .then((String? erro) {
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
                                }
                              });
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
                              'Entrar',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),

                        // Divisor
                        Row(
                          children: [
                            Expanded(child: Divider(color: Colors.grey[300])),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'ou',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ),
                            Expanded(child: Divider(color: Colors.grey[300])),
                          ],
                        ),
                        SizedBox(height: 16),

                        // Botão criar conta
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(),
                                ),
                              );
                            },
                            icon: Icon(Icons.person_add_outlined),
                            label: Text('Criar conta'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.purple[600],
                              side: BorderSide(color: Colors.purple[600]!),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),

                        // Link esqueceu senha
                        TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return PasswordResetModal();
                              },
                            );
                          },
                          child: Text(
                            'Esqueceu sua senha?',
                            style: TextStyle(
                              color: Colors.grey[600],
                              decoration: TextDecoration.underline,
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
      ),
    );
  }
}