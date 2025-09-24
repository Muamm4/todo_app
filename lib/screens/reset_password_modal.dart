import 'package:todo_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class PasswordResetModal extends StatefulWidget {
  const PasswordResetModal({super.key});

  @override
  State<PasswordResetModal> createState() => _PasswordResetModalState();
}

class _PasswordResetModalState extends State<PasswordResetModal> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        'Recuperar senha',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      content: Form(
        key: _formKey,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Endereço de e-mail',
              prefixIcon: Icon(Icons.email_outlined, color: Colors.grey[600]),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor, insira e-mail válido';
              }
              return null;
            },
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey[700],
          ),
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              authService.redefinicaoSenha(email: _emailController.text).then((
                  String? erro,
                  ) {
                Navigator.of(context).pop();

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
                    content: Text('Um link de redefinição de senha foi enviado para o seu e-mail'),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[600],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text('Recuperar senha'),
        ),
      ],
    );
  }
}