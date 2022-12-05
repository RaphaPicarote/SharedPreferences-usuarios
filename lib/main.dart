import 'package:dados_locais/estados.dart';
import 'package:dados_locais/repository.dart';
import 'package:dados_locais/transacao.dart';
import 'package:flutter/material.dart';

import 'controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final nome = TextEditingController();
  final email = TextEditingController();
  final senha = TextEditingController();

  final controller = Controller(SharedPreferencesRepository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        child: Column(
          children: [
            TextFormField(
              controller: nome,
              decoration: const InputDecoration(labelText: "Nome"),
            ),
            TextFormField(
              controller: email,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextFormField(
              controller: senha,
              decoration: const InputDecoration(labelText: "Senha"),
            ),
            TextButton(
              onPressed: () => controller.criarUsuario(
                  nome: nome.text, email: email.text, senha: senha.text),
              child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    if (controller.estado is EstadoCarregando) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return const Text('cadastrar');
                    }
                  }),
            ),
            ElevatedButton(
              onPressed: () {
                controller.getUsuarios();
                showModalBottomSheet(
                  context: context,
                  builder: (context) => AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) {
                      if (controller.estado is EstadoInicial) {
                        return const Center(
                          child: Text('Não existe usuários'),
                        );
                      }
                      if (controller.estado is EstadoSucesso) {
                        return ListView.builder(
                          itemCount: controller.usuarios.length,
                          itemBuilder: (context, index) {
                            final item = controller.usuarios[index];
                            return ListTile(
                              title: Text(item.nome),
                              subtitle: Text(item.email),
                            );
                          },
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                );
              },
              child: null,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (contextNew) => const transacao()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
