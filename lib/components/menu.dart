import 'package:todo_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Menu extends StatelessWidget {
  const Menu({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue[600]!,
              Colors.blue[800]!,
            ],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Header melhorado
            Container(
              height: 200,
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Avatar do usuário
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.account_circle,
                      size: 60,
                      color: Colors.blue[600],
                    ),
                  ),
                  SizedBox(height: 16),

                  // Nome do usuário
                  Text(
                    (user.displayName != null && user.displayName!.isNotEmpty)
                        ? user.displayName!
                        : "Usuário",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4),

                  // Email do usuário
                  Text(
                    user.email!,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Seção branca
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 30),

                  // Botão de logout melhorado
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: ListTile(
                      leading: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.logout,
                          color: Colors.red[600],
                          size: 20,
                        ),
                      ),
                      title: Text(
                        'Sair',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.red[700],
                        ),
                      ),
                      onTap: () {
                        AuthService().deslogar();
                      },
                    ),
                  ),

                  SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}