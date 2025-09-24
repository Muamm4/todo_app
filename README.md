# To-Do App com Flutter e Firebase

Este é um aplicativo de lista de tarefas (To-Do) desenvolvido com Flutter e integrado ao Firebase para autenticação e armazenamento de dados em tempo real.

## ✨ Funcionalidades

- **Autenticação de Usuários**: Login e cadastro utilizando o Firebase Authentication (E-mail e Senha).
- **Gerenciamento de Tarefas**: Crie, leia, atualize e delete tarefas (CRUD).
- **Persistência de Dados**: As tarefas são salvas no Firestore e sincronizadas entre dispositivos.
- **Interface Moderna**: Design limpo e responsivo.

## Getting Started

Siga os passos abaixo para configurar e executar o projeto em sua máquina local.

### 📋 Pré-requisitos

Antes de começar, certifique-se de que você tem o seguinte instalado:

- **[Flutter SDK](https://docs.flutter.dev/get-started/install)**: Versão 3.0 ou superior.
- **Um Editor de Código**: [VS Code](https://code.visualstudio.com/) com a extensão do Flutter ou [Android Studio](https://developer.android.com/studio).
- **[Firebase CLI](https://firebase.google.com/docs/cli#setup_the_cli)** (Opcional, mas recomendado para facilitar a configuração).

### 🔥 Configuração do Firebase

1.  **Crie um Projeto no Firebase**:
    - Acesse o [Console do Firebase](https://console.firebase.google.com/).
    - Clique em "Adicionar projeto" e siga as instruções para criar um novo projeto.

2.  **Configure a Autenticação**:
    - No menu lateral do seu projeto no Firebase, vá para **Authentication**.
    - Clique na aba **"Sign-in method"**.
    - Habilite o provedor **"E-mail/senha"** e salve.

3.  **Conecte o Flutter ao Firebase**:
    - Instale a Firebase CLI se ainda não o fez.
    - Faça login na sua conta Google: `firebase login`
    - No diretório raiz do seu projeto Flutter, execute o comando para configurar o Firebase:
      ```bash
      flutterfire configure
      ```
    - Siga as instruções no terminal para selecionar o projeto Firebase que você criou e as plataformas que deseja configurar (Android, iOS, Web). Este comando irá gerar automaticamente o arquivo `firebase_options.dart` na pasta `lib/`.

### 🚀 Executando a Aplicação

1.  **Instale as dependências** executando no terminal, na raiz do projeto:
    ```bash
    flutter pub get
    ```
2.  **Execute o aplicativo**:
    ```bash
    flutter run
    ```

Agora o aplicativo deve estar rodando no seu emulador ou dispositivo físico!
